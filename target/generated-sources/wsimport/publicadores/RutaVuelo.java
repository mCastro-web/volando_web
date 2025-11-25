
package publicadores;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for rutaVuelo complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>{@code
 * <complexType name="rutaVuelo">
 *   <complexContent>
 *     <restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       <sequence>
 *         <element name="aerolinea" type="{http://publishers/}aerolinea" minOccurs="0"/>
 *         <element name="categoria" type="{http://publishers/}categoria" minOccurs="0"/>
 *         <element name="costoBaseEjecutivo" type="{http://www.w3.org/2001/XMLSchema}float"/>
 *         <element name="costoBaseTurista" type="{http://www.w3.org/2001/XMLSchema}float"/>
 *         <element name="descripcion" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         <element name="destino" type="{http://publishers/}ciudad" minOccurs="0"/>
 *         <element name="fechaAlta" type="{http://publishers/}localDate" minOccurs="0"/>
 *         <element name="nombre" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         <element name="origen" type="{http://publishers/}ciudad" minOccurs="0"/>
 *         <element name="urlImagen" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         <element name="urlVideo" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *       </sequence>
 *     </restriction>
 *   </complexContent>
 * </complexType>
 * }</pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "rutaVuelo", propOrder = {
    "aerolinea",
    "categoria",
    "costoBaseEjecutivo",
    "costoBaseTurista",
    "descripcion",
    "destino",
    "fechaAlta",
    "nombre",
    "origen",
    "urlImagen",
    "urlVideo"
})
public class RutaVuelo {

    protected Aerolinea aerolinea;
    protected Categoria categoria;
    protected float costoBaseEjecutivo;
    protected float costoBaseTurista;
    protected String descripcion;
    protected Ciudad destino;
    protected LocalDate fechaAlta;
    protected String nombre;
    protected Ciudad origen;
    protected String urlImagen;
    protected String urlVideo;

    /**
     * Gets the value of the aerolinea property.
     * 
     * @return
     *     possible object is
     *     {@link Aerolinea }
     *     
     */
    public Aerolinea getAerolinea() {
        return aerolinea;
    }

    /**
     * Sets the value of the aerolinea property.
     * 
     * @param value
     *     allowed object is
     *     {@link Aerolinea }
     *     
     */
    public void setAerolinea(Aerolinea value) {
        this.aerolinea = value;
    }

    /**
     * Gets the value of the categoria property.
     * 
     * @return
     *     possible object is
     *     {@link Categoria }
     *     
     */
    public Categoria getCategoria() {
        return categoria;
    }

    /**
     * Sets the value of the categoria property.
     * 
     * @param value
     *     allowed object is
     *     {@link Categoria }
     *     
     */
    public void setCategoria(Categoria value) {
        this.categoria = value;
    }

    /**
     * Gets the value of the costoBaseEjecutivo property.
     * 
     */
    public float getCostoBaseEjecutivo() {
        return costoBaseEjecutivo;
    }

    /**
     * Sets the value of the costoBaseEjecutivo property.
     * 
     */
    public void setCostoBaseEjecutivo(float value) {
        this.costoBaseEjecutivo = value;
    }

    /**
     * Gets the value of the costoBaseTurista property.
     * 
     */
    public float getCostoBaseTurista() {
        return costoBaseTurista;
    }

    /**
     * Sets the value of the costoBaseTurista property.
     * 
     */
    public void setCostoBaseTurista(float value) {
        this.costoBaseTurista = value;
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
     * Gets the value of the destino property.
     * 
     * @return
     *     possible object is
     *     {@link Ciudad }
     *     
     */
    public Ciudad getDestino() {
        return destino;
    }

    /**
     * Sets the value of the destino property.
     * 
     * @param value
     *     allowed object is
     *     {@link Ciudad }
     *     
     */
    public void setDestino(Ciudad value) {
        this.destino = value;
    }

    /**
     * Gets the value of the fechaAlta property.
     * 
     * @return
     *     possible object is
     *     {@link LocalDate }
     *     
     */
    public LocalDate getFechaAlta() {
        return fechaAlta;
    }

    /**
     * Sets the value of the fechaAlta property.
     * 
     * @param value
     *     allowed object is
     *     {@link LocalDate }
     *     
     */
    public void setFechaAlta(LocalDate value) {
        this.fechaAlta = value;
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

    /**
     * Gets the value of the origen property.
     * 
     * @return
     *     possible object is
     *     {@link Ciudad }
     *     
     */
    public Ciudad getOrigen() {
        return origen;
    }

    /**
     * Sets the value of the origen property.
     * 
     * @param value
     *     allowed object is
     *     {@link Ciudad }
     *     
     */
    public void setOrigen(Ciudad value) {
        this.origen = value;
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

    /**
     * Gets the value of the urlVideo property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getUrlVideo() {
        return urlVideo;
    }

    /**
     * Sets the value of the urlVideo property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setUrlVideo(String value) {
        this.urlVideo = value;
    }

}
