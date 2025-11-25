
package publicadores;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for obtenerDtPaquetePorNombreResponse complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>{@code
 * <complexType name="obtenerDtPaquetePorNombreResponse">
 *   <complexContent>
 *     <restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       <sequence>
 *         <element name="return" type="{http://publishers/}DtPaqueteVuelo" minOccurs="0"/>
 *       </sequence>
 *     </restriction>
 *   </complexContent>
 * </complexType>
 * }</pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "obtenerDtPaquetePorNombreResponse", propOrder = {
    "_return"
})
public class ObtenerDtPaquetePorNombreResponse {

    @XmlElement(name = "return")
    protected DtPaqueteVuelo _return;

    /**
     * Gets the value of the return property.
     * 
     * @return
     *     possible object is
     *     {@link DtPaqueteVuelo }
     *     
     */
    public DtPaqueteVuelo getReturn() {
        return _return;
    }

    /**
     * Sets the value of the return property.
     * 
     * @param value
     *     allowed object is
     *     {@link DtPaqueteVuelo }
     *     
     */
    public void setReturn(DtPaqueteVuelo value) {
        this._return = value;
    }

}
