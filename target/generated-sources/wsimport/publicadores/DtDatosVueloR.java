
package publicadores;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for DtDatosVueloR complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>{@code
 * <complexType name="DtDatosVueloR">
 *   <complexContent>
 *     <restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       <sequence>
 *         <element name="nombre" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         <element name="fecha" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         <element name="duracion" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         <element name="asientosTurista" type="{http://www.w3.org/2001/XMLSchema}int"/>
 *         <element name="asientosEjecutivo" type="{http://www.w3.org/2001/XMLSchema}int"/>
 *         <element name="fechaAlta" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         <element name="origen" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         <element name="destino" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         <element name="costoEjecutivo" type="{http://www.w3.org/2001/XMLSchema}float"/>
 *         <element name="costoTurista" type="{http://www.w3.org/2001/XMLSchema}float"/>
 *         <element name="costoEquipajeExtra" type="{http://www.w3.org/2001/XMLSchema}float"/>
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
@XmlType(name = "DtDatosVueloR", propOrder = {
    "nombre",
    "fecha",
    "duracion",
    "asientosTurista",
    "asientosEjecutivo",
    "fechaAlta",
    "origen",
    "destino",
    "costoEjecutivo",
    "costoTurista",
    "costoEquipajeExtra",
    "urlImagen"
})
public class DtDatosVueloR {

    protected String nombre;
    protected String fecha;
    protected String duracion;
    protected int asientosTurista;
    protected int asientosEjecutivo;
    protected String fechaAlta;
    protected String origen;
    protected String destino;
    protected float costoEjecutivo;
    protected float costoTurista;
    protected float costoEquipajeExtra;
    protected String urlImagen;

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
     * Gets the value of the duracion property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getDuracion() {
        return duracion;
    }

    /**
     * Sets the value of the duracion property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setDuracion(String value) {
        this.duracion = value;
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
     * Gets the value of the fechaAlta property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getFechaAlta() {
        return fechaAlta;
    }

    /**
     * Sets the value of the fechaAlta property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setFechaAlta(String value) {
        this.fechaAlta = value;
    }

    /**
     * Gets the value of the origen property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getOrigen() {
        return origen;
    }

    /**
     * Sets the value of the origen property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setOrigen(String value) {
        this.origen = value;
    }

    /**
     * Gets the value of the destino property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getDestino() {
        return destino;
    }

    /**
     * Sets the value of the destino property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setDestino(String value) {
        this.destino = value;
    }

    /**
     * Gets the value of the costoEjecutivo property.
     * 
     */
    public float getCostoEjecutivo() {
        return costoEjecutivo;
    }

    /**
     * Sets the value of the costoEjecutivo property.
     * 
     */
    public void setCostoEjecutivo(float value) {
        this.costoEjecutivo = value;
    }

    /**
     * Gets the value of the costoTurista property.
     * 
     */
    public float getCostoTurista() {
        return costoTurista;
    }

    /**
     * Sets the value of the costoTurista property.
     * 
     */
    public void setCostoTurista(float value) {
        this.costoTurista = value;
    }

    /**
     * Gets the value of the costoEquipajeExtra property.
     * 
     */
    public float getCostoEquipajeExtra() {
        return costoEquipajeExtra;
    }

    /**
     * Sets the value of the costoEquipajeExtra property.
     * 
     */
    public void setCostoEquipajeExtra(float value) {
        this.costoEquipajeExtra = value;
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
