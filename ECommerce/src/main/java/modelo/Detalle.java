package modelo;

public class Detalle {
    // Campos o Atributos
	private String IdDetalle;
    private String IdVenta;
    private String IdProducto;
    private int Cantidad;
    private double PrecioUnidad;


    // Métodos Constructores
    public Detalle() {
    }

	public Detalle(String idDetalle, String idVenta, String idProducto, int cantidad, double precioUnidad) {
		IdDetalle = idDetalle;
		IdVenta = idVenta;
		IdProducto = idProducto;
		Cantidad = cantidad;
		PrecioUnidad = precioUnidad;
		
	}

	public String getIdDetalle() {
		return IdDetalle;
	}

	public void setIdDetalle(String idDetalle) {
		IdDetalle = idDetalle;
	}

	public String getIdVenta() {
		return IdVenta;
	}

	public void setIdVenta(String idVenta) {
		IdVenta = idVenta;
	}

	public String getIdProducto() {
		return IdProducto;
	}

	public void setIdProducto(String idProducto) {
		IdProducto = idProducto;
	}

	public int getCantidad() {
		return Cantidad;
	}

	public void setCantidad(int cantidad) {
		Cantidad = cantidad;
	}

	public double getPrecioUnidad() {
		return PrecioUnidad;
	}

	public void setPrecioUnidad(double precioUnidad) {
		PrecioUnidad = precioUnidad;
	}


}
