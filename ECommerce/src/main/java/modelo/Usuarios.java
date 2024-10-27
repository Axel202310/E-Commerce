package modelo;

public class Usuarios {

    // Campos o Atributos
    private int IdUsuario; // Cambiado a int
    private String Nombres;
    private String Apellidos;
    private String Direccion;
    private String FechaNacimiento;
    private char Sexo;
    private String Correo;
    private String Password;
    private String TipoUsuario;
    private char Estado; // Nuevo campo para el estado

    // Constructor vacío
    public Usuarios() {
    }

    // Constructor con todos los parámetros
    public Usuarios(int idUsuario, String nombres, String apellidos, String direccion, String fechaNacimiento,
                    char sexo, String correo, String password, String tipoUsuario, char estado) {
        IdUsuario = idUsuario;
        Nombres = nombres;
        Apellidos = apellidos;
        Direccion = direccion;
        FechaNacimiento = fechaNacimiento;
        Sexo = sexo;
        Correo = correo;
        Password = password;
        TipoUsuario = tipoUsuario;
        Estado = estado;
    }

    // Constructor sin IdUsuario (para nuevos registros) que incluye Estado
    public Usuarios(String nombres, String apellidos, String direccion, String fechaNacimiento,
                    char sexo, String correo, String password, String tipoUsuario, char estado) {
        this.Nombres = nombres;
        this.Apellidos = apellidos;
        this.Direccion = direccion;
        this.FechaNacimiento = fechaNacimiento;
        this.Sexo = sexo;
        this.Correo = correo;
        this.Password = password;
        this.TipoUsuario = tipoUsuario;
        this.Estado = estado;
    }

    // Constructor sin IdUsuario y sin Estado (para nuevos registros con Estado por defecto en la BD)
    public Usuarios(String nombres, String apellidos, String direccion, String fechaNacimiento,
                    char sexo, String correo, String password, String tipoUsuario) {
        this.Nombres = nombres;
        this.Apellidos = apellidos;
        this.Direccion = direccion;
        this.FechaNacimiento = fechaNacimiento;
        this.Sexo = sexo;
        this.Correo = correo;
        this.Password = password;
        this.TipoUsuario = tipoUsuario;
        // Estado se establece en la base de datos
    }

    // Getters y Setters
    public int getIdUsuario() {
        return IdUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        IdUsuario = idUsuario;
    }

    public String getNombres() {
        return Nombres;
    }

    public void setNombres(String nombres) {
        Nombres = nombres;
    }

    public String getApellidos() {
        return Apellidos;
    }

    public void setApellidos(String apellidos) {
        Apellidos = apellidos;
    }

    public String getDireccion() {
        return Direccion;
    }

    public void setDireccion(String direccion) {
        Direccion = direccion;
    }

    public String getFechaNacimiento() {
        return FechaNacimiento;
    }

    public void setFechaNacimiento(String fechaNacimiento) {
        FechaNacimiento = fechaNacimiento;
    }

    public char getSexo() {
        return Sexo;
    }

    public void setSexo(char sexo) {
        Sexo = sexo;
    }

    public String getCorreo() {
        return Correo;
    }

    public void setCorreo(String correo) {
        Correo = correo;
    }

    public String getPassword() {
        return Password;
    }

    public void setPassword(String password) {
        Password = password;
    }

    public String getTipoUsuario() {
        return TipoUsuario;
    }

    public void setTipoUsuario(String tipoUsuario) {
        TipoUsuario = tipoUsuario;
    }

    public char getEstado() {
        return Estado;
    }

    public void setEstado(char estado) {
        Estado = estado;
    }
}
