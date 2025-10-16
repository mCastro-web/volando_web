package org.utec.volandouy.web.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import sistema.ISistema;
import sistema.Sistema;
import model.Cliente;
import java.io.IOException;
import java.util.List;

@WebServlet("/ListUserServlet")
public class ListUserServlet extends HttpServlet {

    ISistema s = Sistema.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

            List<Cliente> c = s.listarClientes();

            request.setAttribute("clientes", c);
            request.getRequestDispatcher("/WEB-INF/listUser.jsp").forward(request, response);
    }
}
