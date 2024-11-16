# Usar la imagen oficial de Tomcat con JDK 11
FROM tomcat:9.0-jdk11

# Establecer el directorio de trabajo en Tomcat
WORKDIR /usr/local/tomcat

# Copiar tu aplicación web al directorio webapps de Tomcat
COPY src/main/webapp/ /usr/local/tomcat/webapps/ROOT/

# Exponer el puerto 8080 para acceso HTTP
EXPOSE 8080

# Comando para iniciar Tomcat
CMD ["catalina.sh", "run"]
