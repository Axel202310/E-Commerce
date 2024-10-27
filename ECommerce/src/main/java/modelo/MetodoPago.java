package modelo;

public class MetodoPago {
    private int IdMetodoPago;
    private String TipoPago;
    private String Nombre;
    private String Numero;
    private String Expiracion;
    private String Codigo;

    public MetodoPago(int idMetodoPago, String tipoPago, String nombre, 
                       String numero, String expiracion, String codigo) {
        IdMetodoPago = idMetodoPago;
        TipoPago = tipoPago;
        Nombre = nombre;
        Numero = numero;
        Expiracion = expiracion;
        Codigo = codigo;
    }
    public MetodoPago() {
    }
    public int getIdMetodoPago() {
        return IdMetodoPago;
    }
    public void setIdMetodoPago(int idMetodoPago) {
        IdMetodoPago = idMetodoPago;
    }
    public String getTipoPago() {
        return TipoPago;
    }
    public void setTipoPago(String tipoPago) {
        TipoPago = tipoPago;
    }
    public String getNombre() {
        return Nombre;
    }
    public void setNombre(String nombre) {
        Nombre = nombre;
    }
    public String getNumero() {
        return Numero;
    }
    public void setNumero(String numero) {
        Numero = numero;
    }
    public String getExpiracion() {
        return Expiracion;
    }
    public void setExpiracion(String expiracion) {
        Expiracion = expiracion;
    }
    public String getCodigo() {
        return Codigo;
    }
    public void setCodigo(String codigo) {
        Codigo = codigo;
    }

} 