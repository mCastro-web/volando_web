
package publicadores;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for ciudad complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>{@code
 * <complexType name="ciudad">
 *   <complexContent>
 *     <restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       <sequence>
 *         <element name="aeropuerto" type="{http://publishers/}aeropuerto" minOccurs="0"/>
 *         <element name="nombre" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *       </sequence>
 *     </restriction>
 *   </complexContent>
 * </complexType>
 * }</pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "ciudad", propOrder = {
    "aeropuerto",
    "nombre"
})
public class Ciudad {

    protected Aeropuerto aeropuerto;
    protected String nombre;

    /**
     * Gets the value of the aeropuerto property.
     * 
     * @return
     *     possible object is
     *     {@link Aeropuerto }
     *     
     */
    public Aeropuerto getAeropuerto() {
        return aeropuerto;
    }

    /**
     * Sets the value of the aeropuerto property.
     * 
     * @param value
     *     allowed object is
     *     {@link Aeropuerto }
     *     
     */
    public void setAeropuerto(Aeropuerto value) {
        this.aeropuerto = value;
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

}
