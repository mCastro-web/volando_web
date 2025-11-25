
package publicadores;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlSchemaType;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for itemPaquete complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>{@code
 * <complexType name="itemPaquete">
 *   <complexContent>
 *     <restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       <sequence>
 *         <element name="cant" type="{http://www.w3.org/2001/XMLSchema}int"/>
 *         <element name="identificador" type="{http://www.w3.org/2001/XMLSchema}long" minOccurs="0"/>
 *         <element name="paqueteVuelo" type="{http://publishers/}paqueteVuelo" minOccurs="0"/>
 *         <element name="rutaVuelo" type="{http://publishers/}rutaVuelo" minOccurs="0"/>
 *         <element name="tipoAsiento" type="{http://publishers/}tipoAsiento" minOccurs="0"/>
 *       </sequence>
 *     </restriction>
 *   </complexContent>
 * </complexType>
 * }</pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "itemPaquete", propOrder = {
    "cant",
    "identificador",
    "paqueteVuelo",
    "rutaVuelo",
    "tipoAsiento"
})
public class ItemPaquete {

    protected int cant;
    protected Long identificador;
    protected PaqueteVuelo paqueteVuelo;
    protected RutaVuelo rutaVuelo;
    @XmlSchemaType(name = "string")
    protected TipoAsiento tipoAsiento;

    /**
     * Gets the value of the cant property.
     * 
     */
    public int getCant() {
        return cant;
    }

    /**
     * Sets the value of the cant property.
     * 
     */
    public void setCant(int value) {
        this.cant = value;
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
     * Gets the value of the paqueteVuelo property.
     * 
     * @return
     *     possible object is
     *     {@link PaqueteVuelo }
     *     
     */
    public PaqueteVuelo getPaqueteVuelo() {
        return paqueteVuelo;
    }

    /**
     * Sets the value of the paqueteVuelo property.
     * 
     * @param value
     *     allowed object is
     *     {@link PaqueteVuelo }
     *     
     */
    public void setPaqueteVuelo(PaqueteVuelo value) {
        this.paqueteVuelo = value;
    }

    /**
     * Gets the value of the rutaVuelo property.
     * 
     * @return
     *     possible object is
     *     {@link RutaVuelo }
     *     
     */
    public RutaVuelo getRutaVuelo() {
        return rutaVuelo;
    }

    /**
     * Sets the value of the rutaVuelo property.
     * 
     * @param value
     *     allowed object is
     *     {@link RutaVuelo }
     *     
     */
    public void setRutaVuelo(RutaVuelo value) {
        this.rutaVuelo = value;
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

}
