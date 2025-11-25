
package publicadores;

import java.util.ArrayList;
import java.util.List;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlSchemaType;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for DtReserva complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>{@code
 * <complexType name="DtReserva">
 *   <complexContent>
 *     <restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       <sequence>
 *         <element name="fecha" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         <element name="tipoAsiento" type="{http://publishers/}tipoAsiento" minOccurs="0"/>
 *         <element name="equipajeExtra" type="{http://www.w3.org/2001/XMLSchema}int"/>
 *         <element name="costo" type="{http://www.w3.org/2001/XMLSchema}float"/>
 *         <element name="cliente" type="{http://publishers/}dtCliente" minOccurs="0"/>
 *         <element name="vuelo" type="{http://publishers/}dtVuelo" minOccurs="0"/>
 *         <element name="paquete" type="{http://publishers/}DtPaqueteVuelo" minOccurs="0"/>
 *         <element name="pasajes" type="{http://publishers/}DtPasaje" maxOccurs="unbounded" minOccurs="0"/>
 *         <element name="validez" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         <element name="checkin" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/>
 *       </sequence>
 *     </restriction>
 *   </complexContent>
 * </complexType>
 * }</pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "DtReserva", propOrder = {
    "fecha",
    "tipoAsiento",
    "equipajeExtra",
    "costo",
    "cliente",
    "vuelo",
    "paquete",
    "pasajes",
    "validez",
    "checkin"
})
public class DtReserva {

    protected String fecha;
    @XmlSchemaType(name = "string")
    protected TipoAsiento tipoAsiento;
    protected int equipajeExtra;
    protected float costo;
    protected DtCliente cliente;
    protected DtVuelo vuelo;
    protected DtPaqueteVuelo paquete;
    @XmlElement(nillable = true)
    protected List<DtPasaje> pasajes;
    protected String validez;
    protected Boolean checkin;

    /**
     * Gets the value of the fecha property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getFecha() {
        return fecha;
    }

    /**
     * Sets the value of the fecha property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setFecha(String value) {
        this.fecha = value;
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
     * Gets the value of the cliente property.
     * 
     * @return
     *     possible object is
     *     {@link DtCliente }
     *     
     */
    public DtCliente getCliente() {
        return cliente;
    }

    /**
     * Sets the value of the cliente property.
     * 
     * @param value
     *     allowed object is
     *     {@link DtCliente }
     *     
     */
    public void setCliente(DtCliente value) {
        this.cliente = value;
    }

    /**
     * Gets the value of the vuelo property.
     * 
     * @return
     *     possible object is
     *     {@link DtVuelo }
     *     
     */
    public DtVuelo getVuelo() {
        return vuelo;
    }

    /**
     * Sets the value of the vuelo property.
     * 
     * @param value
     *     allowed object is
     *     {@link DtVuelo }
     *     
     */
    public void setVuelo(DtVuelo value) {
        this.vuelo = value;
    }

    /**
     * Gets the value of the paquete property.
     * 
     * @return
     *     possible object is
     *     {@link DtPaqueteVuelo }
     *     
     */
    public DtPaqueteVuelo getPaquete() {
        return paquete;
    }

    /**
     * Sets the value of the paquete property.
     * 
     * @param value
     *     allowed object is
     *     {@link DtPaqueteVuelo }
     *     
     */
    public void setPaquete(DtPaqueteVuelo value) {
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
     * {@link DtPasaje }
     * 
     * 
     * @return
     *     The value of the pasajes property.
     */
    public List<DtPasaje> getPasajes() {
        if (pasajes == null) {
            pasajes = new ArrayList<>();
        }
        return this.pasajes;
    }

    /**
     * Gets the value of the validez property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getValidez() {
        return validez;
    }

    /**
     * Sets the value of the validez property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setValidez(String value) {
        this.validez = value;
    }

    /**
     * Gets the value of the checkin property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isCheckin() {
        return checkin;
    }

    /**
     * Sets the value of the checkin property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setCheckin(Boolean value) {
        this.checkin = value;
    }

}
