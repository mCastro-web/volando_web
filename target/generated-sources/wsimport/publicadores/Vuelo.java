
package publicadores;

import java.util.ArrayList;
import java.util.List;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for vuelo complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>{@code
 * <complexType name="vuelo">
 *   <complexContent>
 *     <restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       <sequence>
 *         <element name="asientosEjecutivo" type="{http://www.w3.org/2001/XMLSchema}int"/>
 *         <element name="asientosTurista" type="{http://www.w3.org/2001/XMLSchema}int"/>
 *         <element name="contadorEjecutivo" type="{http://www.w3.org/2001/XMLSchema}int" minOccurs="0"/>
 *         <element name="contadorTurista" type="{http://www.w3.org/2001/XMLSchema}int" minOccurs="0"/>
 *         <element name="duracion" type="{http://publishers/}localTime" minOccurs="0"/>
 *         <element name="fecha" type="{http://publishers/}localDate" minOccurs="0"/>
 *         <element name="fechaAlta" type="{http://publishers/}localDate" minOccurs="0"/>
 *         <element name="nombre" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         <element name="reservaVuelo" type="{http://publishers/}reserva" maxOccurs="unbounded" minOccurs="0"/>
 *         <element name="ruta" type="{http://publishers/}rutaVuelo" minOccurs="0"/>
 *         <element name="urlImagen" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *       </sequence>
 *     </restriction>
 *   </complexContent>
 * </complexType>
 * }</pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "vuelo", propOrder = {
    "asientosEjecutivo",
    "asientosTurista",
    "contadorEjecutivo",
    "contadorTurista",
    "duracion",
    "fecha",
    "fechaAlta",
    "nombre",
    "reservaVuelo",
    "ruta",
    "urlImagen"
})
public class Vuelo {

    protected int asientosEjecutivo;
    protected int asientosTurista;
    protected Integer contadorEjecutivo;
    protected Integer contadorTurista;
    protected LocalTime duracion;
    protected LocalDate fecha;
    protected LocalDate fechaAlta;
    protected String nombre;
    @XmlElement(nillable = true)
    protected List<Reserva> reservaVuelo;
    protected RutaVuelo ruta;
    protected String urlImagen;

    /**
     * Gets the value of the asientosEjecutivo property.
     * 
     */
    public int getAsientosEjecutivo() {
        return asientosEjecutivo;
    }

    /**
     * Sets the value of the asientosEjecutivo property.
     * 
     */
    public void setAsientosEjecutivo(int value) {
        this.asientosEjecutivo = value;
    }

    /**
     * Gets the value of the asientosTurista property.
     * 
     */
    public int getAsientosTurista() {
        return asientosTurista;
    }

    /**
     * Sets the value of the asientosTurista property.
     * 
     */
    public void setAsientosTurista(int value) {
        this.asientosTurista = value;
    }

    /**
     * Gets the value of the contadorEjecutivo property.
     * 
     * @return
     *     possible object is
     *     {@link Integer }
     *     
     */
    public Integer getContadorEjecutivo() {
        return contadorEjecutivo;
    }

    /**
     * Sets the value of the contadorEjecutivo property.
     * 
     * @param value
     *     allowed object is
     *     {@link Integer }
     *     
     */
    public void setContadorEjecutivo(Integer value) {
        this.contadorEjecutivo = value;
    }

    /**
     * Gets the value of the contadorTurista property.
     * 
     * @return
     *     possible object is
     *     {@link Integer }
     *     
     */
    public Integer getContadorTurista() {
        return contadorTurista;
    }

    /**
     * Sets the value of the contadorTurista property.
     * 
     * @param value
     *     allowed object is
     *     {@link Integer }
     *     
     */
    public void setContadorTurista(Integer value) {
        this.contadorTurista = value;
    }

    /**
     * Gets the value of the duracion property.
     * 
     * @return
     *     possible object is
     *     {@link LocalTime }
     *     
     */
    public LocalTime getDuracion() {
        return duracion;
    }

    /**
     * Sets the value of the duracion property.
     * 
     * @param value
     *     allowed object is
     *     {@link LocalTime }
     *     
     */
    public void setDuracion(LocalTime value) {
        this.duracion = value;
    }

    /**
     * Gets the value of the fecha property.
     * 
     * @return
     *     possible object is
     *     {@link LocalDate }
     *     
     */
    public LocalDate getFecha() {
        return fecha;
    }

    /**
     * Sets the value of the fecha property.
     * 
     * @param value
     *     allowed object is
     *     {@link LocalDate }
     *     
     */
    public void setFecha(LocalDate value) {
        this.fecha = value;
    }

    /**
     * Gets the value of the fechaAlta property.
     * 
     * @return
     *     possible object is
     *     {@link LocalDate }
     *     
     */
    public LocalDate getFechaAlta() {
        return fechaAlta;
    }

    /**
     * Sets the value of the fechaAlta property.
     * 
     * @param value
     *     allowed object is
     *     {@link LocalDate }
     *     
     */
    public void setFechaAlta(LocalDate value) {
        this.fechaAlta = value;
    }

    /**
     * Gets the value of the nombre property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getNombre() {
        return nombre;
    }

    /**
     * Sets the value of the nombre property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setNombre(String value) {
        this.nombre = value;
    }

    /**
     * Gets the value of the reservaVuelo property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a {@code set} method for the reservaVuelo property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getReservaVuelo().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link Reserva }
     * 
     * 
     * @return
     *     The value of the reservaVuelo property.
     */
    public List<Reserva> getReservaVuelo() {
        if (reservaVuelo == null) {
            reservaVuelo = new ArrayList<>();
        }
        return this.reservaVuelo;
    }

    /**
     * Gets the value of the ruta property.
     * 
     * @return
     *     possible object is
     *     {@link RutaVuelo }
     *     
     */
    public RutaVuelo getRuta() {
        return ruta;
    }

    /**
     * Sets the value of the ruta property.
     * 
     * @param value
     *     allowed object is
     *     {@link RutaVuelo }
     *     
     */
    public void setRuta(RutaVuelo value) {
        this.ruta = value;
    }

    /**
     * Gets the value of the urlImagen property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getUrlImagen() {
        return urlImagen;
    }

    /**
     * Sets the value of the urlImagen property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setUrlImagen(String value) {
        this.urlImagen = value;
    }

}
