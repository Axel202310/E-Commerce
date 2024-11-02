package controller;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;
import modelo.*;

public class CarritoBD {
	// Campos o atributos
	private String Driver = "com.mysql.cj.jdbc.Driver";
	private String URL = "jdbc:mysql://localhost:3306/EcomStore";
	private String Usuario = "root";
	private String Password = "password2424";
	
	private Connection Cn;
	private Statement Cmd;
	private CallableStatement Stmt;
	private ResultSet Rs;
	
	private List<Categorias> ListaC;
	private List<Productos> ListaP;
	
	// Método Constructor
	public CarritoBD() {
		try {
				Class.forName(Driver);
				Cn = DriverManager.getConnection(URL, Usuario, Password);
		} catch (Exception e) {
				System.out.println("ERROR EN LA CONEXION:" + e.getMessage());
		}
	}
	
	// Método ListarCategorias
	public List<Categorias> ListarCategorias(){
		String SQL = "CALL ListarCategorias()";
		ListaC = new ArrayList<Categorias>();
		try {
				Stmt = Cn.prepareCall(SQL);
				Rs = Stmt.executeQuery();
				while(Rs.next()) {
					ListaC.add(new Categorias(Rs.getString("IdCategoria"), 
											Rs.getString("Descripcion"),
											Rs.getString("Imagen"),
											Rs.getString("Estado").charAt(0)));
				}
				Rs.close();
		} catch (Exception e) {
				System.out.println("ERROR EN CARGA DE TABLA CATEGORIAS :" + e.getMessage());
		}
		return ListaC;
	}
	
	// Método para registrar categoria
	public boolean registrarCategoria(Categorias categoria) {
        boolean exito = false;
        String SQL = "{CALL registrarCategoria(?, ?, ?, ?)}"; // Se esperan 4 parámetros: 1 OUT y 3 IN
        try (CallableStatement cstmt = Cn.prepareCall(SQL)) {
            cstmt.registerOutParameter(1, java.sql.Types.CHAR); // Parámetro OUT: p_idCategoria

            // Asignar los parámetros de entrada en el orden correspondiente al procedimiento almacenado
            cstmt.setString(2, categoria.getDescripcion());  // Parámetro IN: p_descripcion
            cstmt.setString(3, categoria.getImagen());       // Parámetro IN: p_imagen
            cstmt.setString(4, String.valueOf(categoria.getEstado())); // Parámetro IN: p_estado

            // Ejecutar el procedimiento
            int filasAfectadas = cstmt.executeUpdate();
            if (filasAfectadas > 0) {
                // Obtener el ID generado
                String nuevoIdCategoria = cstmt.getString(1);
                categoria.setIdCategoria(nuevoIdCategoria); // Asignar el nuevo ID al objeto categoria
                exito = true;
            }
        } catch (Exception e) {
            System.out.println("***ERROR al registrar categoria: " + e.getMessage());
        }
        return exito;
    }

	// Método para obtener el siguiente ID de producto generado por el procedimiento almacenado
    public String generarNuevoIdCategoria() {
        String nuevoIdCategoria = null;
        String SQL = "{CALL obtenerSiguienteIdCategoria(?)}"; // Procedimiento almacenado con parámetro OUT
        try (CallableStatement cstmt = Cn.prepareCall(SQL)) {
            // Registrar el parámetro OUT
            cstmt.registerOutParameter(1, java.sql.Types.CHAR);

            // Ejecuta el procedimiento almacenado
            cstmt.execute();

            // Obtener el ID generado
            nuevoIdCategoria = cstmt.getString(1);
        } catch (SQLException e) {
            System.out.println("***ERROR al generar nuevo ID de categoria: " + e.getMessage());
        }
        return nuevoIdCategoria;
    }
    
	// Método para actualizar una categoría en la base de datos
	   public boolean actualizarCategoria(Categorias categoria) {
	       boolean exito = false;
	       String SQL = "{CALL actualizarCategoria(?, ?, ?, ?)}";
	       try {
	           // Preparar el llamado al procedimiento almacenado
	           Stmt = Cn.prepareCall(SQL);
	           Stmt.setString(1, categoria.getIdCategoria());
	           Stmt.setString(2, categoria.getDescripcion());
	           Stmt.setString(3, categoria.getImagen());  
	           Stmt.setString(4, Character.toString(categoria.getEstado()));
	           // Ejecutar el procedimiento
	           int filasAfectadas = Stmt.executeUpdate();
	           if (filasAfectadas > 0) {
	               exito = true;
	           }
	       } catch (Exception e) {
	           System.out.println("***ERROR al actualizar categoria: " + e.getMessage());
	       }
	       return exito;
	   }

	   public boolean eliminarCategoria(String idCategoria) {
		    boolean exito = false;
		    String SQL = "{CALL eliminarCategoria(?)}";
		    try {
		        System.out.println("ID de Categoría recibido: " + idCategoria);  // Debug
		        
		        // Preparar el llamado al procedimiento almacenado
		        Stmt = Cn.prepareCall(SQL);
		        // Establecer los valores de los parámetros
		        Stmt.setString(1, idCategoria);
		        // Ejecutar el procedimiento
		        int filasAfectadas = Stmt.executeUpdate();
		        if (filasAfectadas > 0) {
		            exito = true;
		        }
		    } catch (Exception e) {
		        System.out.println("***ERROR al eliminar categoría: " + e.getMessage());
		    }
		    return exito;
		}

	
	// Método ListarProductos
	public List<Productos> ListarProductos(String IdCat){
		String SQL = "CALL ListarProductosXCategoria(?)";
		ListaP = new ArrayList<Productos>();
		try {
				Stmt = Cn.prepareCall(SQL);
				Stmt.setString(1, IdCat);
				Rs = Stmt.executeQuery();
				while(Rs.next()) {
					ListaP.add(new Productos(Rs.getString("IdProducto"), 
											Rs.getString("IdCategoria"),
											Rs.getString("Marca"),
											Rs.getString("Descripcion"),
											Rs.getDouble("PrecioUnidad"),
											Rs.getInt("Stock"),
											Rs.getString("Imagen"),
											Rs.getString("Estado").charAt(0)));
				}
				Rs.close();
		} catch (Exception e) {
				System.out.println("ERROR EN CARGA DE TABLA PRODUCTOS :" + e.getMessage());
		}
		return ListaP;
	}
	
	// Método InfoProducto
	public Productos InfoProducto(String IdPro) {
		String SQL = "CALL InfoProducto(?)";
		Productos ObjP = null;
		try {
				Stmt = Cn.prepareCall(SQL);
				Stmt.setString(1, IdPro);
				Rs = Stmt.executeQuery();
				if(Rs.next()) {
					ObjP = new Productos(Rs.getString("IdProducto"), 
										Rs.getString("IdCategoria"),
										Rs.getString("Marca"),
										Rs.getString("Descripcion"),
										Rs.getDouble("PrecioUnidad"),
										Rs.getInt("Stock"),
										Rs.getString("Imagen"),
										Rs.getString("Estado").charAt(0));
				}
				Rs.close();
		} catch (Exception e) {
			System.out.println("ERROR EN CARGA DE TABLA PRODUCTOS :" + e.getMessage());
		}
		return ObjP;
	}
		
	
	// Método para registrar un nuevo producto
	public boolean registrarProducto(Productos producto) {
	    boolean exito = false;
	    String SQL = "{CALL registrarProducto(?, ?, ?, ?, ?, ?, ?, ?)}"; // Llamada al procedimiento almacenado
	    try (CallableStatement cstmt = Cn.prepareCall(SQL)) {
	        // El primer parámetro es el OUT (ID generado), no lo establecemos, lo registramos como de salida
	        cstmt.registerOutParameter(1, java.sql.Types.CHAR); // Parámetro p_idProducto OUT

	        // Los demás parámetros se asignan en el orden correspondiente al procedimiento almacenado
	        cstmt.setString(2, producto.getIdCategoria()); // Parámetro p_idCategoria
	        cstmt.setString(3, producto.getMarca());       // Parámetro p_marca
	        cstmt.setString(4, producto.getDescripcion()); // Parámetro p_descripcion
	        cstmt.setDouble(5, producto.getPrecioUnidad()); // Parámetro p_precioUnidad
	        cstmt.setInt(6, producto.getStock());          // Parámetro p_stock
	        cstmt.setString(7, producto.getImagen());      // Parámetro p_imagen
	        cstmt.setString(8, String.valueOf(producto.getEstado())); // Parámetro p_estado

	        // Ejecuta el procedimiento almacenado
	        int filasAfectadas = cstmt.executeUpdate();
	        if (filasAfectadas > 0) {
	            // Obtener el ID generado
	            String nuevoIdProducto = cstmt.getString(1);
	            producto.setIdProducto(nuevoIdProducto); // Asignar el nuevo ID al objeto producto
	            exito = true; // Si se afectaron filas, se considera éxito
	        }
	    } catch (SQLException e) {
	        System.out.println("***ERROR al registrar producto: " + e.getMessage());
	    }
	    return exito;
	}

	// Método para obtener el siguiente ID de producto generado por el procedimiento almacenado
	public String generarNuevoIdProducto() {
	    String nuevoIdProducto = null;
	    String SQL = "{CALL obtenerSiguienteIdProducto(?)}"; // Procedimiento almacenado con parámetro OUT
	    try (CallableStatement cstmt = Cn.prepareCall(SQL)) {
	        // Registrar el parámetro OUT
	        cstmt.registerOutParameter(1, java.sql.Types.CHAR);

	        // Ejecuta el procedimiento almacenado
	        cstmt.execute();

	        // Obtener el ID generado
	        nuevoIdProducto = cstmt.getString(1);
	    } catch (SQLException e) {
	        System.out.println("***ERROR al generar nuevo ID de producto: " + e.getMessage());
	    }
	    return nuevoIdProducto;
	}

	   
	   public boolean actualizarProducto(Productos producto) {
		    boolean exito = false;
		    String SQL = "{CALL actualizarProducto(?, ?, ?, ?, ?, ?, ?, ?)}";  // Llamada al procedimiento almacenado

		    try (CallableStatement cstmt = Cn.prepareCall(SQL)) {
		        // Establecer los parámetros para la llamada al procedimiento almacenado
		        cstmt.setString(1, producto.getIdProducto());        // Parámetro 1: ID del producto
		        cstmt.setString(2, producto.getIdCategoria());       // Parámetro 2: ID de la categoría
		        cstmt.setString(3, producto.getMarca());             // Parámetro 3: Marca del producto
		        cstmt.setString(4, producto.getDescripcion());       // Parámetro 4: Descripción
		        cstmt.setDouble(5, producto.getPrecioUnidad());      // Parámetro 5: Precio por unidad
		        cstmt.setInt(6, producto.getStock());                // Parámetro 6: Stock
		        cstmt.setString(7, producto.getImagen());            // Parámetro 7: Imagen
		        cstmt.setString(8, String.valueOf(producto.getEstado())); // Parámetro 8: Estado (activo/inactivo)

		        // Ejecutar la actualización
		        int filasAfectadas = cstmt.executeUpdate();  // Ejecuta el procedimiento almacenado

		        // Comprobar si se actualizaron filas en la base de datos
		        if (filasAfectadas > 0) {
		            exito = true;  // Indica que la actualización fue exitosa
		        }

		    } catch (SQLException e) {
		        System.out.println("***ERROR al actualizar producto: " + e.getMessage());
		    }

		    return exito;  // Devuelve true si la actualización fue exitosa, false en caso contrario
		}
	   
	// Método para eliminar un producto
	   public boolean eliminarProducto(String idProducto) {
	       boolean exito = false;
	       String SQL = "{CALL eliminarProducto(?)}";
	       try (CallableStatement cstmt = Cn.prepareCall(SQL)) {
	           cstmt.setString(1, idProducto);
	          
	           int filasAfectadas = cstmt.executeUpdate();
	           if (filasAfectadas > 0) {
	               exito = true;
	           }
	       } catch (SQLException e) {
	           System.out.println("***ERROR al eliminar producto: " + e.getMessage());
	       }
	       return exito;
	   }
	   // Método para buscar productos por Descripción o ID en consultaStock.jsp**
	   public List<Productos> buscarProducto(String busqueda) {
	       List<Productos> productosEncontrados = new ArrayList<>();
	       String SQL = "{CALL buscarProducto(?)}";
	       try (CallableStatement cstmt = Cn.prepareCall(SQL)) {
	           cstmt.setString(1, busqueda);
	           try (ResultSet rs = cstmt.executeQuery()) {
	               while (rs.next()) {
	                   Productos producto = new Productos(
	                       rs.getString("IdProducto"),
	                       rs.getString("IdCategoria"),
	                       rs.getString("Marca"),
	                       rs.getString("Descripcion"),
	                       rs.getDouble("PrecioUnidad"),
	                       rs.getInt("Stock"),
	                       rs.getString("Imagen"),
	                       rs.getString("Estado").charAt(0)
	                   );
	                   productosEncontrados.add(producto);
	               }
	           }
	       } catch (SQLException e) {
	           System.out.println("***ERROR al buscar productos: " + e.getMessage());
	       }
	       return productosEncontrados;
	   }
	
	// Método para registrar un nuevo usuario en la base de datos
	    public boolean registrarUsuario(Usuarios usuario) {
	        boolean exito = false;
	        String SQL = "{CALL RegistrarUsuario(?, ?, ?, ?, ?, ?, ?)}";
	        try {
	            Stmt = Cn.prepareCall(SQL);
	            Stmt.setString(1, usuario.getNombres());
	            Stmt.setString(2, usuario.getApellidos());
	            Stmt.setString(3, usuario.getDireccion());
	            Stmt.setString(4, usuario.getFechaNacimiento());
	            Stmt.setString(5, String.valueOf(usuario.getSexo()));
	            Stmt.setString(6, usuario.getCorreo());
	            Stmt.setString(7, usuario.getPassword());

	            int filasAfectadas = Stmt.executeUpdate();
	            if (filasAfectadas > 0) {
	                exito = true;
	            }
	        } catch (Exception e) {
	            System.out.println("***ERROR al registrar usuario: " + e.getMessage());
	        }
	        return exito;
	    }
    
	    public List<Usuarios> ListarUsuarios() {
	        List<Usuarios> listaClientes = new ArrayList<>();
	        String SQL = "CALL ListarUsuarios()";
	        try {
	            PreparedStatement pstmt = Cn.prepareStatement(SQL);
	            ResultSet rs = pstmt.executeQuery();
	            while (rs.next()) {
	                Usuarios usuario = new Usuarios();
	                usuario.setIdUsuario(rs.getInt("IdUsuario"));
	                usuario.setApellidos(rs.getString("Apellidos"));
	                usuario.setNombres(rs.getString("Nombres"));
	                usuario.setDireccion(rs.getString("Direccion"));
	                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
	                String fechaNacimiento = formatter.format(rs.getDate("FechaNacimiento"));
	                usuario.setFechaNacimiento(fechaNacimiento);
	                usuario.setSexo(rs.getString("Sexo").charAt(0));
	                usuario.setCorreo(rs.getString("Correo"));
	                usuario.setPassword(rs.getString("Password"));
	                usuario.setTipoUsuario(rs.getString("tipoUsuario"));
	                usuario.setEstado(rs.getString("Estado").charAt(0)); // Agregar Estado
	                listaClientes.add(usuario);
	            }
	            pstmt.close();
	            rs.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return listaClientes;
	    }

    
    // Método para actualizar los datos del cliente
    public boolean actualizarUsuario(Usuarios usuario) {
        boolean exito = false;
        String SQL = "{CALL ActualizarUsuario(?, ?, ?, ?, ?, ?, ?)}";
        try {
            Stmt = Cn.prepareCall(SQL);
            Stmt.setInt(1, usuario.getIdUsuario()); // Cambiado a setInt
            Stmt.setString(2, usuario.getNombres());
            Stmt.setString(3, usuario.getApellidos());
            Stmt.setString(4, usuario.getDireccion());
            Stmt.setString(5, usuario.getFechaNacimiento());
            Stmt.setString(6, String.valueOf(usuario.getSexo()));
            Stmt.setString(7, usuario.getCorreo());

            ResultSet rs = Stmt.executeQuery();
            if (rs.next()) {
                String mensaje = rs.getString("Mensaje");
                if ("Usuario actualizado exitosamente.".equals(mensaje)) {
                    exito = true;
                }
            }
            rs.close();
        } catch (Exception e) {
            System.out.println("***ERROR al actualizar usuario: " + e.getMessage());
        }
        return exito;
    }
    
    public boolean VerificaUsuario(String correo, String contrasena) {
        boolean estado = false;
        String SQL = "SELECT * FROM Usuarios WHERE Correo=? AND Password=? AND Estado='1'";
        try {
            PreparedStatement pstmt = Cn.prepareStatement(SQL);
            pstmt.setString(1, correo);
            pstmt.setString(2, contrasena);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                estado = true;
            }
            pstmt.close();
        } catch (SQLException e) {
            System.out.println("***ERROR VERIFICAR USUARIO:" + e.getMessage());
        }
        return estado;
    }

 // Devolver Información del Usuario
    public Usuarios InfoUsuario(int IdUsuario) {
        Usuarios ObjP = null;
        try {
            // Establece el nombre del SP a invocar
            Stmt = Cn.prepareCall("CALL InfoUsuario(?)");
            // Asigna el valor del único parámetro del SP
            Stmt.setInt(1, IdUsuario);
            // Ejecuta el SP y almacena los resultados
            Rs = Stmt.executeQuery();
            // Si recuperó filas, guárdalo en un objeto de tipo Usuarios
            if (Rs.next()) {
                ObjP = new Usuarios(
                        Rs.getInt("IdUsuario"),
                        Rs.getString("Nombres"),
                        Rs.getString("Apellidos"),
                        Rs.getString("Direccion"),
                        Rs.getString("FechaNacimiento"),
                        Rs.getString("Sexo").charAt(0),
                        Rs.getString("Correo"),
                        Rs.getString("Password"),
                        Rs.getString("TipoUsuario"),
                        Rs.getString("Estado").charAt(0)  // Agrega el Estado aquí
                );
            }
        } catch (Exception e) {
            System.out.println("***ERROR INFO:" + e.getMessage());
        }
        return ObjP;
    }


    
    public boolean VerificaCorreo(String correo) {
        boolean existe = false;
        String SQL = "SELECT * FROM Usuarios WHERE Correo=?";
        try {
            PreparedStatement pstmt = Cn.prepareStatement(SQL);
            pstmt.setString(1, correo);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                existe = true;  // Si encuentra un resultado, el correo ya está registrado
            }
            pstmt.close();
        } catch (SQLException e) {
            System.out.println("***ERROR VERIFICAR CORREO:" + e.getMessage());
        }
        return existe;
    }
    
    // Obtener información del usuario por correo
    public Usuarios InfoUsuarioPorCorreo(String correo) {
        Usuarios usuario = null;
        String SQL = "SELECT * FROM Usuarios WHERE Correo=?";
        try {
            PreparedStatement pstmt = Cn.prepareStatement(SQL);
            pstmt.setString(1, correo);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                usuario = new Usuarios();
                usuario.setIdUsuario(rs.getInt("IdUsuario"));
                usuario.setNombres(rs.getString("Nombres"));
                usuario.setApellidos(rs.getString("Apellidos"));
                usuario.setDireccion(rs.getString("Direccion"));
                
                Date fecha = rs.getDate("FechaNacimiento");
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                String fechaNacimiento = formatter.format(fecha);
                usuario.setFechaNacimiento(fechaNacimiento);
                
                usuario.setSexo(rs.getString("Sexo").charAt(0));
                usuario.setCorreo(rs.getString("Correo"));
                usuario.setPassword(rs.getString("Password"));
                usuario.setTipoUsuario(rs.getString("tipoUsuario"));
                usuario.setEstado(rs.getString("Estado").charAt(0)); // Agregar Estado
            }
            pstmt.close();
        } catch (SQLException e) {
            System.out.println("***ERROR al obtener información del usuario:" + e.getMessage());
        }
        return usuario;
    }
    
    // Método para insertar filas en la tabla ventas
    public void InsertarVenta(Ventas ObjV)
    {
        try {
            Stmt = this.Cn.prepareCall("CALL InsertaVenta(?,?,?,?,?,?)");
            Stmt.setString(1, ObjV.getIdVenta());
            Stmt.setInt(2, ObjV.getIdCliente());
            Stmt.setInt(3, ObjV.getIdMetodoPago());
            Stmt.setString(4, ObjV.getFechaVenta());
            Stmt.setDouble(5, ObjV.getMontoTotal());
            Stmt.setString(6, ObjV.getEstado()+"");
            Stmt.executeUpdate(); // INSERT, DELETE o UPDATE
        } catch (Exception e) {
            System.out.println("***ERROR VENTA:"+e.getMessage());        
        }
    }
    
    // Método para insertar filas en la tabla detalle
    public void InsertarDetalle(Detalle ObjD)
    {
        try {
            Stmt = this.Cn.prepareCall("CALL InsertaDetalle(?,?,?,?,?)");
            Stmt.setString(1, ObjD.getIdDetalle());
            Stmt.setString(2, ObjD.getIdVenta());
            Stmt.setString(3, ObjD.getIdProducto());
            Stmt.setInt(4, ObjD.getCantidad());
            Stmt.setDouble(5, ObjD.getPrecioUnidad());
            Stmt.executeUpdate();
        } catch (Exception e) {
            System.out.println("***ERROR DETALLE:"+e.getMessage());  
        }
    }
    
    // Método para devolver el numero de filas de un tabla
    public int NumeroFilas(String NombreTabla)
    { int filas = 0;
      String SQL = "SELECT Count(*) FROM "+NombreTabla;
        try {
            this.Cmd = this.Cn.createStatement();
            this.Rs = this.Cmd.executeQuery(SQL);
            if(this.Rs.next()){
                filas = Rs.getInt(1);
            }
        } catch (Exception e) {
           System.out.println("***ERROR:"+e.getMessage());   
        }
      return filas;  
    }
        
 // Método para registrar un nuevo método de pago en la base de datos
    public boolean registrarMetodoPago(MetodoPago metodoPago) {
        boolean exito = false;
        String SQL = "{CALL RegistrarMetodoPago(?, ?, ?, ?, ?)}";  // Ajustar la cantidad de parámetros

        try {
            // Preparar el llamado al procedimiento almacenado
            Stmt = Cn.prepareCall(SQL);

            // Establecer los valores de los parámetros
            Stmt.setString(1, metodoPago.getTipoPago());
            Stmt.setString(2, metodoPago.getNombre());
            Stmt.setString(3, metodoPago.getNumero());
            Stmt.setString(4, metodoPago.getExpiracion());
            Stmt.setString(5, metodoPago.getCodigo());

            // Ejecutar el procedimiento
            int filasAfectadas = Stmt.executeUpdate();
            if (filasAfectadas > 0) {
                exito = true;

                // Recuperar el ID generado automáticamente
                ResultSet rs = Stmt.getGeneratedKeys();
                if (rs.next()) {
                    int generatedId = rs.getInt(1);  // Obtener el primer valor generado
                    metodoPago.setIdMetodoPago(generatedId);  // Asignar el ID al objeto
                }
            }
        } catch (Exception e) {
            System.out.println("ERROR al registrar método de pago: " + e.getMessage());
        } finally {
            // Cerrar recursos (opcional pero recomendado)
            try {
                if (Stmt != null) Stmt.close();
            } catch (Exception ex) {
                System.out.println("ERROR al cerrar el Statement: " + ex.getMessage());
            }
        }
        return exito;
    }
    
    
    
    // Método para listar las ventas por el ID DEL CLIENTE (PARA EL REPORTE Y ENVIO DE CORREO)
    public List<Ventas> listarVentas(int idCliente) {
        List<Ventas> listaVentas = new ArrayList<>();
        String sql = "SELECT * FROM Ventas WHERE IdCliente = ?";
        try {
            // Preparar la consulta SQL
            PreparedStatement pstmt = Cn.prepareStatement(sql);
            // Establecer el valor del parámetro
            pstmt.setInt(1, idCliente);
            // Ejecutar la consulta y obtener el resultado
            ResultSet rs = pstmt.executeQuery();
            // Iterar sobre el resultado y agregar cada venta a la lista
            while (rs.next()) {
                Ventas venta = new Ventas();
                venta.setIdVenta(rs.getString("IdVenta"));
                venta.setIdCliente(rs.getInt("IdCliente"));
                venta.setIdMetodoPago(rs.getInt("IdMetodoPago"));
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                String fechaVenta = formatter.format(rs.getDate("FechaVenta"));
                venta.setFechaVenta(fechaVenta);
                venta.setMontoTotal(rs.getDouble("MontoTotal"));
                venta.setEstado(rs.getString("Estado").charAt(0));
                listaVentas.add(venta);
            }
            // Cerrar el PreparedStatement y el ResultSet
            pstmt.close();
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listaVentas;
    }
    
    // Método para listar todos los productos
    public List<Productos> listarProductos() {
        List<Productos> listaProductos = new ArrayList<>();
        String sql = "CALL ListarProductos()";
        try {
            // Preparar la llamada al procedimiento almacenado
            CallableStatement cstmt = Cn.prepareCall(sql);
            // Ejecutar la llamada al procedimiento almacenado y obtener el resultado
            ResultSet rs = cstmt.executeQuery();
            // Iterar sobre el resultado y agregar cada producto a la lista
            while (rs.next()) {
                Productos producto = new Productos();
                producto.setIdProducto(rs.getString("IdProducto"));
                producto.setIdCategoria(rs.getString("IdCategoria"));
                producto.setMarca(rs.getString("Marca"));
                producto.setDescripcion(rs.getString("Descripcion"));
                producto.setPrecioUnidad(rs.getDouble("PrecioUnidad"));
                producto.setStock(rs.getInt("Stock"));
                producto.setImagen(rs.getString("Imagen"));
                producto.setEstado(rs.getString("Estado").charAt(0));
                listaProductos.add(producto);
            }
            // Cerrar el CallableStatement y el ResultSet
            cstmt.close();
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listaProductos;
    }

    // Método para actualizar el stock de un producto después de una compra
    public void actualizarStock(String idProducto, int cantidad) {
        try {
            CallableStatement cstmt = Cn.prepareCall("{CALL ActualizarStock(?, ?)}");
            cstmt.setString(1, idProducto);
            cstmt.setInt(2, cantidad);
            cstmt.executeUpdate();
            cstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    // Método para actualizar el stock de un producto después de una compra
    public void actualizarStockAdmin(String idProducto, int cantidad) {
        try {
            CallableStatement cstmt = Cn.prepareCall("{CALL ActualizarStockAdmin(?, ?)}");
            cstmt.setString(1, idProducto);
            cstmt.setInt(2, cantidad);
            cstmt.executeUpdate();
            cstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Método para actualizar el precio de venta de un producto
    public void actualizarPrecioVenta(String idProducto, double precio) {
        try {
            CallableStatement cstmt = Cn.prepareCall("{CALL ActualizarPrecioVenta(?, ?)}");
            cstmt.setString(1, idProducto);
            cstmt.setDouble(2, precio);
            cstmt.executeUpdate();
            cstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    // Método para eliminar un usuario de la base de datos
    public void EliminarUsuario(String IdUsuario) {
        try {
            CallableStatement cstmt = Cn.prepareCall("{CALL EliminarUsuario(?)}");
            cstmt.setString(1, IdUsuario);
            cstmt.executeUpdate();
            cstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    // Método para obtener el detalle y que salga en los reportes y correo.
    public List<Detalle> obtenerDetalleVenta(String idDetalle) {
        List<Detalle> detalleVentaList = new ArrayList<>();
        String SQL = "CALL DetalleVenta(?)"; // Llamadar al procedimiento DetalleVenta
        try {
            CallableStatement stmt = Cn.prepareCall(SQL);
            stmt.setString(1, idDetalle);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Detalle detalle = new Detalle();
                detalle.setIdVenta(rs.getString("IdDetalle"));
                detalle.setIdVenta(rs.getString("IdVenta"));
                detalle.setIdProducto(rs.getString("IdProducto"));
                detalle.setCantidad(rs.getInt("Cantidad"));
                detalle.setPrecioUnidad(rs.getDouble("PrecioUnidad"));
                detalleVentaList.add(detalle);
            }
            stmt.close();
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return detalleVentaList;
    }
    
    
    // Método para buscar los productos por su marca
    public List<Productos> buscarProductosPorMarca(String marcaBusqueda) {
        List<Productos> productosEncontrados = new ArrayList<>();
        String SQL = "{CALL BuscarProductoPorMarca(?)}";
        try {
            // Preparar la llamada al procedimiento almacenado
            CallableStatement cstmt = Cn.prepareCall(SQL);
            // Establecer el valor del parámetro
            cstmt.setString(1, marcaBusqueda);
            // Ejecutar la llamada y obtener el resultado
            ResultSet rs = cstmt.executeQuery();
            // Iterar sobre el resultado y agregar cada producto a la lista
            while (rs.next()) {
                Productos producto = new Productos();
                producto.setIdProducto(rs.getString("IdProducto"));
                producto.setIdCategoria(rs.getString("IdCategoria"));
                producto.setMarca(rs.getString("Marca"));
                producto.setDescripcion(rs.getString("Descripcion"));
                producto.setPrecioUnidad(rs.getDouble("PrecioUnidad"));
                producto.setStock(rs.getInt("Stock"));
                producto.setImagen(rs.getString("Imagen"));
                producto.setEstado(rs.getString("Estado").charAt(0));
                productosEncontrados.add(producto);
            }
            // Cerrar el CallableStatement y el ResultSet
            cstmt.close();
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productosEncontrados;
    }
    
 // Método para buscar los productos por su descripción
    public List<Productos> buscarProductosPorDescripcion(String descripcionBusqueda) {
        List<Productos> productosEncontrados = new ArrayList<>();
        String SQL = "{CALL BuscarProductoPorDescripcion(?)}"; // Llamada al procedimiento BuscarProductoPorDescripcion
        try {
            // Preparar la llamada al procedimiento almacenado
            CallableStatement cstmt = Cn.prepareCall(SQL);
            // Establecer el valor del parámetro
            cstmt.setString(1, descripcionBusqueda);
            // Ejecutar la llamada y obtener el resultado
            ResultSet rs = cstmt.executeQuery();
            // Iterar sobre el resultado y agregar cada producto a la lista
            while (rs.next()) {
                Productos producto = new Productos();
                producto.setIdProducto(rs.getString("IdProducto"));
                producto.setIdCategoria(rs.getString("IdCategoria"));
                producto.setMarca(rs.getString("Marca"));
                producto.setDescripcion(rs.getString("Descripcion"));
                producto.setPrecioUnidad(rs.getDouble("PrecioUnidad"));
                producto.setStock(rs.getInt("Stock"));
                producto.setImagen(rs.getString("Imagen"));
                producto.setEstado(rs.getString("Estado").charAt(0));
                productosEncontrados.add(producto);
            }
            // Cerrar el CallableStatement y el ResultSet
            cstmt.close();
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productosEncontrados;
    }
    
    public Categorias getCategoriaById(String idCategoria) {
        Categorias categoria = null;
        String SQL = "CALL ObtenerCategoriaPorId(?)";
        try {
            CallableStatement stmt = Cn.prepareCall(SQL);
            stmt.setString(1, idCategoria);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                categoria = new Categorias(
                    rs.getString("IdCategoria"),
                    rs.getString("Descripcion"),
                    rs.getString("Imagen"),
                    rs.getString("Estado").charAt(0)
                );
            }
            stmt.close();
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categoria;
    }   
    
    
    // Método para listar las ventas
    public List<Ventas> listarVentas1() {
        List<Ventas> listaVentas = new ArrayList<>();
        String sql = "CALL ListarVentas()";
        try {
            // Preparar la consulta SQL
            PreparedStatement pstmt = Cn.prepareStatement(sql);
            
            // Ejecutar la consulta y obtener el resultado
            ResultSet rs = pstmt.executeQuery();
            // Iterar sobre el resultado y agregar cada venta a la lista
            while (rs.next()) {
                Ventas venta = new Ventas();
                venta.setIdVenta(rs.getString("IdVenta"));
                venta.setIdCliente(rs.getInt("IdCliente"));
                venta.setIdMetodoPago(rs.getInt("IdMetodoPago"));
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                String fechaVenta = formatter.format(rs.getDate("FechaVenta"));
                venta.setFechaVenta(fechaVenta);
                venta.setMontoTotal(rs.getDouble("MontoTotal"));
                venta.setEstado(rs.getString("Estado").charAt(0));
                listaVentas.add(venta);
            }
            // Cerrar el PreparedStatement y el ResultSet
            pstmt.close();
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listaVentas;
    }
    
    // Método para obtener el detalle de una venta por su ID
    public List<Detalle> obtenerIdDetalle(String idDetalle) {
        
    	System.out.println("Buscando detalle para ID: " + idDetalle);
    	List<Detalle> detalleVentaList = new ArrayList<>();
        String SQL = "SELECT * FROM Detalle WHERE IdDetalle = ?"; // Llamada al procedimiento almacenado
        try {
            CallableStatement stmt = Cn.prepareCall(SQL);
            stmt.setString(1, idDetalle);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Detalle detalle = new Detalle();
                detalle.setIdDetalle(rs.getString("IdDetalle"));
                detalle.setIdVenta(rs.getString("IdVenta"));
                detalle.setIdProducto(rs.getString("IdProducto"));
                detalle.setCantidad(rs.getInt("Cantidad"));
                detalle.setPrecioUnidad(rs.getDouble("PrecioUnidad"));
                detalleVentaList.add(detalle);
            }
            stmt.close();
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return detalleVentaList;
    }
    
 // Método para obtener el nombre del método de pago por su ID
    public String obtenerMetodoPago(int idMetodoPago) {
        String metodoPago = null;
        String sql = "SELECT TipoPago FROM MetodoPago WHERE IdMetodoPago = ?";
        try {
            // Preparar la consulta
            PreparedStatement pstmt = Cn.prepareStatement(sql);
            pstmt.setInt(1, idMetodoPago);

            // Ejecutar la consulta
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                metodoPago = rs.getString("TipoPago");  // Obtener el tipo de método de pago (ej. "Tarjeta de crédito")
            }

            // Cerrar el PreparedStatement y el ResultSet
            pstmt.close();
            rs.close();
        } catch (SQLException e) {
            System.out.println("***ERROR al obtener método de pago: " + e.getMessage());
        }
        return metodoPago;
    }
    
    public boolean cambiarEstadoProducto(String idProducto, String nuevoEstado) {
        String sql = "UPDATE Productos SET Estado = ? WHERE IdProducto = ?";
        try (PreparedStatement ps = Cn.prepareStatement(sql)) {
            ps.setString(1, nuevoEstado);
            ps.setString(2, idProducto);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;  // Retorna true si se actualizó el estado
        } catch (SQLException e) {
            System.out.println("ERROR EN CAMBIO DE ESTADO DEL PRODUCTO: " + e.getMessage());
            return false;
        }
    }
    
    public boolean cambiarEstadoUsuario(String correoUsuario, char nuevoEstado) { 
        boolean resultado = false;
        CallableStatement stmt = null;

        try {
            // Preparar el llamado al procedimiento almacenado
            stmt = Cn.prepareCall("CALL CambiarEstadoCliente(?, ?)");
            stmt.setString(1, correoUsuario);
            stmt.setString(2, String.valueOf(nuevoEstado));

            // Ejecutar el procedimiento
            int filasAfectadas = stmt.executeUpdate();
            resultado = (filasAfectadas == 1);  // Verificar que solo se actualice un usuario

        } catch (Exception e) {
            System.out.println("ERROR CAMBIAR ESTADO USUARIO: " + e.getMessage() + " (Correo Usuario: " + correoUsuario + ", Nuevo Estado: " + nuevoEstado + ")");
        } finally {
            try {
                if (stmt != null) stmt.close();
            } catch (Exception e) {
                System.out.println("ERROR AL CERRAR RECURSOS: " + e.getMessage());
            }
        }

        return resultado;
    }
    
    public int obtenerIdUsuarioPorCorreo(String correo) {
        int idUsuario = -1;  // Valor predeterminado si no se encuentra el usuario
        String SQL = "SELECT IdUsuario FROM Usuarios WHERE Correo = ?";

        try (PreparedStatement pstmt = Cn.prepareStatement(SQL)) {
            pstmt.setString(1, correo);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                idUsuario = rs.getInt("IdUsuario");
            }

            rs.close();
        } catch (SQLException e) {
            System.out.println("***ERROR al obtener IdUsuario por correo: " + e.getMessage());
        }

        return idUsuario;
    }
   
}