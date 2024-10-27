package modelo;

public class Productos {
	// Campos o atributos
	private String IdProducto;
	private String IdCategoria;
	private String Marca;
	private String Descripcion;
	private double PrecioUnidad;
	private int Stock;
	private String Imagen;
	private char Estado;
	
	// Métodos Constructores
	public Productos() {
	}
	public Productos(String idProducto, String idCategoria,String marca, String descripcion, double precioUnidad, int stock,
			String imagen, char estado) {
		IdProducto = idProducto;
		IdCategoria = idCategoria;
		Marca = marca;
		Descripcion = descripcion;
		PrecioUnidad = precioUnidad;
		Stock = stock;
		Imagen = imagen;
		Estado = estado;
	}
	
	// Propiedades get y set
	public String getIdProducto() {
		return IdProducto;
	}
	public void setIdProducto(String idProducto) {
		IdProducto = idProducto;
	}
	public String getIdCategoria() {
		return IdCategoria;
	}
	public void setIdCategoria(String idCategoria) {
		IdCategoria = idCategoria;
	}
	public String getDescripcion() {
		return Descripcion;
	}
	
	public String getMarca() {
		return Marca;
	}
	public void setMarca(String marca) {
		Marca = marca;
	}
	public void setDescripcion(String descripcion) {
		Descripcion = descripcion;
	}
	public double getPrecioUnidad() {
		return PrecioUnidad;
	}
	public void setPrecioUnidad(double precioUnidad) {
		PrecioUnidad = precioUnidad;
	}
	public int getStock() {
		return Stock;
	}
	public void setStock(int stock) {
		Stock = stock;
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
