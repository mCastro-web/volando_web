
package org.utec.volandouy.web.servlets;

import jakarta.persistence.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.lang.Exception;
import java.util.List;


import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;
import publicadores.*;

@WebServlet("/ConsultaCheckinServlet")
public class ConsultaCheckinServlet extends HttpServlet {

    private final ControladorSistemaPublish port =
            new ControladorSistemaPublishService().getControladorSistemaPublishPort();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        DtUsuario usuario = (session != null) ? (DtUsuario) session.getAttribute("usuario") : null;

        if (usuario == null || !"cliente".equalsIgnoreCase(usuario.getTipo())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            List<Long> reservas = port.listarReservasConCheckin(usuario.getNickname());
            request.setAttribute("reservas", reservas);
            request.getRequestDispatcher("/WEB-INF/consultaCheckin.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("notyf_error_checkin", "Error al obtener reservas.");
            request.getRequestDispatcher("/WEB-INF/consultaCheckin.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        HttpSession session = request.getSession(false);
        DtUsuario usuario = (session != null) ? (DtUsuario) session.getAttribute("usuario") : null;

        if (usuario == null || !"cliente".equalsIgnoreCase(usuario.getTipo())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String accion = request.getParameter("accion");
        String idReservaStr = request.getParameter("idReserva");

        if (idReservaStr == null || idReservaStr.isEmpty()) {
            request.setAttribute("notyf_error_checkin", "Debe seleccionar una reserva.");
            doGet(request, response);
            return;
        }

        Long idReserva = Long.parseLong(idReservaStr);

        try {
            // Guardamos el id seleccionado para mantenerlo en el JSP
            request.setAttribute("idReservaSeleccionada", idReserva);

            if ("verReserva".equals(accion)) {
                DtReserva dtReserva = port.obtenerReservaCheckin(idReserva);
                request.setAttribute("dtReserva", dtReserva);

            } else if ("verCheckin".equals(accion)) {
                DtCheckin dtCheckin = port.obtenerCheckinPorReserva(idReserva);
                request.setAttribute("dtCheckin", dtCheckin);

            } else if ("pdfCheckin".equals(accion)) {
                DtCheckin dtCheckin = port.obtenerCheckinPorReserva(idReserva);
                if (dtCheckin != null) {
                    response.setContentType("application/pdf");
                    response.setHeader("Content-Disposition",
                            "attachment; filename=\"tarjeta_embarque_" + idReserva + ".pdf\"");
                    generarPDF(dtCheckin, response.getOutputStream());
                    return; // no forward
                }
            }

            // Forward con reservas y atributos seteados
            List<Long> reservas = port.listarReservasConCheckin(usuario.getNickname());
            request.setAttribute("reservas", reservas);
            request.getRequestDispatcher("/WEB-INF/consultaCheckin.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("notyf_error_checkin", "Error interno del sistema.");
            doGet(request, response);
        }
    }

    private void generarPDF(DtCheckin dtCheckin, OutputStream out) throws DocumentException, IOException {
        Document doc = new Document(PageSize.A4, 50, 50, 50, 50); // márgenes
        PdfWriter.getInstance(doc, out);
        doc.open();

        // Agregar logo (favicon.png) desde resources/static
        try {
            InputStream logoStream = getClass().getClassLoader().getResourceAsStream("static/favicon.png");
            if (logoStream != null) {
                byte[] bytes = logoStream.readAllBytes();
                Image logo = Image.getInstance(bytes);
                logo.scaleToFit(80, 80); // tamaño máximo
                logo.setAlignment(Element.ALIGN_CENTER);
                doc.add(logo);
                doc.add(Chunk.NEWLINE);
            }
        } catch (Exception e) {
            System.out.println("No se pudo agregar el logo: " + e.getMessage());
        }

        // Título
        Paragraph titulo = new Paragraph("Tarjeta de Embarque", FontFactory.getFont(FontFactory.HELVETICA_BOLD, 20));
        titulo.setAlignment(Element.ALIGN_CENTER);
        titulo.setSpacingAfter(20); // espacio después del título
        doc.add(titulo);

        // Datos del cliente y vuelo
        Paragraph infoCliente = new Paragraph(
                "Cliente: " + dtCheckin.getNombreCliente() + " " + dtCheckin.getApellidoCliente() + "\n" +
                        "Vuelo: " + dtCheckin.getNombreVuelo() + "\n" +
                        "Ruta: " + dtCheckin.getNombreRuta() + "\n" +
                        "Origen: " + dtCheckin.getCiudadOrigen() + " - Destino: " + dtCheckin.getCiudadDestino() + "\n" +
                        "Fecha del vuelo: " + dtCheckin.getFechaVuelo() + "\n" +
                        "Hora de embarque: " + dtCheckin.getHoraEmbarque() + "\n"
        );
        infoCliente.setSpacingAfter(20); // espacio antes de la tabla
        doc.add(infoCliente);

        // Tabla de pasajeros
        PdfPTable table = new PdfPTable(3);
        table.setWidthPercentage(100);
        table.setSpacingBefore(10f); // espacio arriba de la tabla
        table.setSpacingAfter(10f);  // espacio abajo de la tabla

        // Encabezados
        Font headerFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12);
        PdfPCell cell1 = new PdfPCell(new Phrase("Nombre", headerFont));
        PdfPCell cell2 = new PdfPCell(new Phrase("Apellido", headerFont));
        PdfPCell cell3 = new PdfPCell(new Phrase("Asiento", headerFont));
        cell1.setHorizontalAlignment(Element.ALIGN_CENTER);
        cell2.setHorizontalAlignment(Element.ALIGN_CENTER);
        cell3.setHorizontalAlignment(Element.ALIGN_CENTER);
        table.addCell(cell1);
        table.addCell(cell2);
        table.addCell(cell3);

        // Filas de pasajeros
        if (dtCheckin.getPasajeros() != null && dtCheckin.getPasajeros().getPasajero() != null) {
            for (publicadores.DtPasajeCheckin p : dtCheckin.getPasajeros().getPasajero()) {
                table.addCell(p.getNombre());
                table.addCell(p.getApellido());
                table.addCell(p.getTipoAsiento());
            }
        } else {
            PdfPCell noData = new PdfPCell(new Phrase("No hay pasajeros", FontFactory.getFont(FontFactory.HELVETICA, 11)));
            noData.setColspan(3);
            noData.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(noData);
        }

        doc.add(table);

        // Pie de página opcional
        Paragraph footer = new Paragraph("¡Buen viaje!", FontFactory.getFont(FontFactory.HELVETICA_OBLIQUE, 12));
        footer.setAlignment(Element.ALIGN_CENTER);
        doc.add(footer);

        doc.close();
    }
}
