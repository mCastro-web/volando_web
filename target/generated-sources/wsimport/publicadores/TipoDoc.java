
package publicadores;

import jakarta.xml.bind.annotation.XmlEnum;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for tipoDoc.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * <pre>{@code
 * <simpleType name="tipoDoc">
 *   <restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *     <enumeration value="CEDULA"/>
 *     <enumeration value="PASAPORTE"/>
 *   </restriction>
 * </simpleType>
 * }</pre>
 * 
 */
@XmlType(name = "tipoDoc")
@XmlEnum
public enum TipoDoc {

    CEDULA,
    PASAPORTE;

    public String value() {
        return name();
    }

    public static TipoDoc fromValue(String v) {
        return valueOf(v);
    }

}
