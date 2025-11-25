
package publicadores;

import java.util.ArrayList;
import java.util.List;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for DtPaqueteVuelo complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>{@code
 * <complexType name="DtPaqueteVuelo">
 *   <complexContent>
 *     <restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       <sequence>
 *         <element name="nombre" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         <element name="descripcion" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         <element name="diasValidez" type="{http://www.w3.org/2001/XMLSchema}int"/>
 *         <element name="descuento" type="{http://www.w3.org/2001/XMLSchema}float"/>
 *         <element name="costo" type="{http://www.w3.org/2001/XMLSchema}float"/>
 *         <element name="altaFecha" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         <element name="items" type="{http://publishers/}itemPaquete" maxOccurs="unbounded" minOccurs="0"/>
 *         <element name="reservas" type="{http://publishers/}reserva" maxOccurs="unbounded" minOccurs="0"/>
 *       </sequence>
 *     </restriction>
 *   </complexContent>
 * </complexType>
 * }</pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "DtPaqueteVuelo", propOrder = {
    "nombre",
    "descripcion",
    "diasValidez",
    "descuento",
    "costo",
    "altaFecha",
    "items",
    "reservas"
})
public class DtPaqueteVuelo {

    protected String nombre;
    protected String descripcion;
    protected int diasValidez;
    protected float descuento;
    protected float costo;
    protected String altaFecha;
    @XmlElement(nillable = true)
    protected List<ItemPaquete> items;
    @XmlElement(nillable = true)
    protected List<Reserva> reservas;

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
     * Gets the value of the descripcion property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getDescripcion() {
        return descripcion;
    }

    /**
     * Sets the value of the descripcion property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setDescripcion(String value) {
        this.descripcion = value;
    }

    /**
     * Gets the value of the diasValidez property.
     * 
     */
    public int getDiasValidez() {
        return diasValidez;
    }

    /**
     * Sets the value of the diasValidez property.
     * 
     */
    public void setDiasValidez(int value) {
        this.diasValidez = value;
    }

    /**
     * Gets the value of the descuento property.
     * 
     */
    public float getDescuento() {
        return descuento;
    }

    /**
     * Sets the value of the descuento property.
     * 
     */
    public void setDescuento(float value) {
        this.descuento = value;
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
     * Gets the value of the altaFecha property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAltaFecha() {
        return altaFecha;
    }

    /**
     * Sets the value of the altaFecha property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAltaFecha(String value) {
        this.altaFecha = value;
    }

    /**
     * Gets the value of the items property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a {@code set} method for the items property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getItems().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link ItemPaquete }
     * 
     * 
     * @return
     *     The value of the items property.
     */
    public List<ItemPaquete> getItems() {
        if (items == null) {
            items = new ArrayList<>();
        }
        return this.items;
    }

    /**
     * Gets the value of the reservas property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a {@code set} method for the reservas property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getReservas().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link Reserva }
     * 
     * 
     * @return
     *     The value of the reservas property.
     */
    public List<Reserva> getReservas() {
        if (reservas == null) {
            reservas = new ArrayList<>();
        }
        return this.reservas;
    }

}
