
package publicadores;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlSchemaType;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for DtItemPaquete complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>{@code
 * <complexType name="DtItemPaquete">
 *   <complexContent>
 *     <restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       <sequence>
 *         <element name="cant" type="{http://www.w3.org/2001/XMLSchema}int"/>
 *         <element name="tipoAsiento" type="{http://publishers/}tipoAsiento" minOccurs="0"/>
 *         <element name="nombreRutaVuelo" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *       </sequence>
 *     </restriction>
 *   </complexContent>
 * </complexType>
 * }</pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "DtItemPaquete", propOrder = {
    "cant",
    "tipoAsiento",
    "nombreRutaVuelo"
})
public class DtItemPaquete {

    protected int cant;
    @XmlSchemaType(name = "string")
    protected TipoAsiento tipoAsiento;
    protected String nombreRutaVuelo;

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
     * Gets the value of the nombreRutaVuelo property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getNombreRutaVuelo() {
        return nombreRutaVuelo;
    }

    /**
     * Sets the value of the nombreRutaVuelo property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setNombreRutaVuelo(String value) {
        this.nombreRutaVuelo = value;
    }

}
