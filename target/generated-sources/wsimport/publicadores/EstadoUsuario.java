
package publicadores;

import jakarta.xml.bind.annotation.XmlEnum;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for estadoUsuario.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * <pre>{@code
 * <simpleType name="estadoUsuario">
 *   <restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *     <enumeration value="INGRESADO"/>
 *     <enumeration value="CERRADO"/>
 *   </restriction>
 * </simpleType>
 * }</pre>
 * 
 */
@XmlType(name = "estadoUsuario")
@XmlEnum
public enum EstadoUsuario {

    INGRESADO,
    CERRADO;

    public String value() {
        return name();
    }

    public static EstadoUsuario fromValue(String v) {
        return valueOf(v);
    }

}
