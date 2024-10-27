package modelo;

public class Ventas {
    // Campos o Atributos
    private String IdVenta;
    private int IdCliente;
    private int IdMetodoPago;
    private String FechaVenta;
    private double MontoTotal;
    private char Estado;

    // Métodos Constructores
    public Ventas() {
    }
    
    public Ventas(String IdVenta, int IdCliente, int IdMetodoPago,String FechaVenta, double MontoTotal, char Estado) {
        this.IdVenta = IdVenta;
        this.IdCliente = IdCliente;
        this.IdMetodoPago = IdMetodoPago;
        this.FechaVenta = FechaVenta;
        this.MontoTotal = MontoTotal;
        this.Estado = Estado;
    }
    
    // Propiedades de Lectura y Escritura
    public String getIdVenta() {
        return IdVenta;
    }

    public void setIdVenta(String IdVenta) {
        this.IdVenta = IdVenta;
    }

    public int getIdCliente() {
        return IdCliente;
    }

    public void setIdCliente(int IdCliente) {
        this.IdCliente = IdCliente;
    }
    
    public int getIdMetodoPago() {
		return IdMetodoPago;
	}

	public void setIdMetodoPago(int idMetodoPago) {
		IdMetodoPago = idMetodoPago;
	}

	public String getFechaVenta() {
        return FechaVenta;
    }

    public void setFechaVenta(String FechaVenta) {
        this.FechaVenta = FechaVenta;
    }

    public double getMontoTotal() {
        return MontoTotal;
    }

    public void setMontoTotal(double MontoTotal) {
        this.MontoTotal = MontoTotal;
    }

    public char getEstado() {
        return Estado;
    }

    public void setEstado(char Estado) {
        this.Estado = Estado;
    }
    
}