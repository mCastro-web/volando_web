
package publicadores;

import java.util.ArrayList;
import java.util.List;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlSchemaType;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for reserva complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>{@code
 * <complexType name="reserva">
 *   <complexContent>
 *     <restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       <sequence>
 *         <element name="cantPasajes" type="{http://www.w3.org/2001/XMLSchema}int"/>
 *         <element name="cliente" type="{http://publishers/}cliente" minOccurs="0"/>
 *         <element name="costo" type="{http://www.w3.org/2001/XMLSchema}float"/>
 *         <element name="equipajeExtra" type="{http://www.w3.org/2001/XMLSchema}int"/>
 *         <element name="fecha" type="{http://publishers/}localDate" minOccurs="0"/>
 *         <element name="horaInicioEmbarque" type="{http://publishers/}localDateTime" minOccurs="0"/>
 *         <element name="identificador" type="{http://www.w3.org/2001/XMLSchema}long" minOccurs="0"/>
 *         <element name="paquete" type="{http://publishers/}paqueteVuelo" minOccurs="0"/>
 *         <element name="pasajes" type="{http://publishers/}pasaje" maxOccurs="unbounded" minOccurs="0"/>
 *         <element name="tipoAsiento" type="{http://publishers/}tipoAsiento" minOccurs="0"/>
 *         <element name="vencimiento" type="{http://publishers/}localDate" minOccurs="0"/>
 *         <element name="vuelo" type="{http://publishers/}vuelo" minOccurs="0"/>
 *       </sequence>
 *     </restriction>
 *   </complexContent>
 * </complexType>
 * }</pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "reserva", propOrder = {
    "cantPasajes",
    "cliente",
    "costo",
    "equipajeExtra",
    "fecha",
    "horaInicioEmbarque",
    "identificador",
    "paquete",
    "pasajes",
    "tipoAsiento",
    "vencimiento",
    "vuelo"
})
public class Reserva {

    protected int cantPasajes;
    protected Cliente cliente;
    protected float costo;
    protected int equipajeExtra;
    protected LocalDate fecha;
    protected LocalDateTime horaInicioEmbarque;
    protected Long identificador;
    protected PaqueteVuelo paquete;
    @XmlElement(nillable = true)
    protected List<Pasaje> pasajes;
    @XmlSchemaType(name = "string")
    protected TipoAsiento tipoAsiento;
    protected LocalDate vencimiento;
    protected Vuelo vuelo;

    /**
     * Gets the value of the cantPasajes property.
     * 
     */
    public int getCantPasajes() {
        return cantPasajes;
    }

    /**
     * Sets the value of the cantPasajes property.
     * 
     */
    public void setCantPasajes(int value) {
        this.cantPasajes = value;
    }

    /**
     * Gets the value of the cliente property.
     * 
     * @return
     *     possible object is
     *     {@link Cliente }
     *     
     */
    public Cliente getCliente() {
        return cliente;
    }

    /**
     * Sets the value of the cliente property.
     * 
     * @param value
     *     allowed object is
     *     {@link Cliente }
     *     
     */
    public void setCliente(Cliente value) {
        this.cliente = value;
    }

    /**
     * Gets the value of the costo property.
     * 
     */
    public float getCosto() {
        return costo;
    }

    /**
     * Sets the value of the costo property.
     * 
     */
    public void setCosto(float value) {
        this.costo = value;
    }

    /**
     * Gets the value of the equipajeExtra property.
     * 
     */
    public int getEquipajeExtra() {
        return equipajeExtra;
    }

    /**
     * Sets the value of the equipajeExtra property.
     * 
     */
    public void setEquipajeExtra(int value) {
        this.equipajeExtra = value;
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
     * Gets the value of the horaInicioEmbarque property.
     * 
     * @return
     *     possible object is
     *     {@link LocalDateTime }
     *     
     */
    public LocalDateTime getHoraInicioEmbarque() {
        return horaInicioEmbarque;
    }

    /**
     * Sets the value of the horaInicioEmbarque property.
     * 
     * @param value
     *     allowed object is
     *     {@link LocalDateTime }
     *     
     */
    public void setHoraInicioEmbarque(LocalDateTime value) {
        this.horaInicioEmbarque = value;
    }

    /**
     * Gets the value of the identificador property.
     * 
     * @return
     *     possible object is
     *     {@link Long }
     *     
     */
    public Long getIdentificador() {
        return identificador;
    }

    /**
     * Sets the value of the identificador property.
     * 
     * @param value
     *     allowed object is
     *     {@link Long }
     *     
     */
    public void setIdentificador(Long value) {
        this.identificador = value;
    }

    /**
     * Gets the value of the paquete property.
     * 
     * @return
     *     possible object is
     *     {@link PaqueteVuelo }
     *     
     */
    public PaqueteVuelo getPaquete() {
        return paquete;
    }

    /**
     * Sets the value of the paquete property.
     * 
     * @param value
     *     allowed object is
     *     {@link PaqueteVuelo }
     *     
     */
    public void setPaquete(PaqueteVuelo value) {
        this.paquete = value;
    }

    /**
     * Gets the value of the pasajes property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a {@code set} method for the pasajes property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getPasajes().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link Pasaje }
     * 
     * 
     * @return
     *     The value of the pasajes property.
     */
    public List<Pasaje> getPasajes() {
        if (pasajes == null) {
            pasajes = new ArrayList<>();
        }
        return this.pasajes;
    }

    /**
     * Gets the value of the tipoAsiento property.
     * 
     * @return
     *     possible object is
     *     {@link TipoAsiento }
     *     
     */
    public TipoAsiento getTipoAsiento() {
        return tipoAsiento;
    }

    /**
     * Sets the value of the tipoAsiento property.
     * 
     * @param value
     *     allowed object is
     *     {@link TipoAsiento }
     *     
     */
    public void setTipoAsiento(TipoAsiento value) {
        this.tipoAsiento = value;
    }

    /**
     * Gets the value of the vencimiento property.
     * 
     * @return
     *     possible object is
     *     {@link LocalDate }
     *     
     */
    public LocalDate getVencimiento() {
        return vencimiento;
    }

    /**
     * Sets the value of the vencimiento property.
     * 
     * @param value
     *     allowed object is
     *     {@link LocalDate }
     *     
     */
    public void setVencimiento(LocalDate value) {
        this.vencimiento = value;
    }

    /**
     * Gets the value of the vuelo property.
     * 
     * @return
     *     possible object is
     *     {@link Vuelo }
     *     
     */
    public Vuelo getVuelo() {
        return vuelo;
    }

    /**
     * Sets the value of the vuelo property.
     * 
     * @param value
     *     allowed object is
     *     {@link Vuelo }
     *     
     */
    public void setVuelo(Vuelo value) {
        this.vuelo = value;
    }

}
