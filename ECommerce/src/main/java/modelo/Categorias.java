package modelo;

public class Categorias {
	// Campos o atributos
	private String IdCategoria;
	private String Descripcion;
	private String Imagen;
	private char Estado;
	
	// Métodos Constructores
	public Categorias(String idCategoria, String descripcion, String imagen, char estado) {
		IdCategoria = idCategoria;
		Descripcion = descripcion;
		Imagen = imagen;
		Estado = estado;
	}
	public Categorias() {
	}
	
	// Propiedades get/set
	public String getIdCategoria() {
		return IdCategoria;
	}
	public void setIdCategoria(String idCategoria) {
		IdCategoria = idCategoria;
	}
	public String getDescripcion() {
		return Descripcion;
	}
	public void setDescripcion(String descripcion) {
		Descripcion = descripcion;
	}
	public String getImagen() {
		return Imagen;
	}
	public void setImagen(String imagen) {
		Imagen = imagen;
	}
	public char getEstado() {
		return Estado;
	}
	public void setEstado(char estado) {
		Estado = estado;
	}
}
