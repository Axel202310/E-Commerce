# Usar la imagen oficial de Tomcat con JDK 11
FROM tomcat:9.0-jdk11

# Establecer el directorio de trabajo
WORKDIR /usr/local/tomcat

# Copiar el código fuente y compilar los archivos Java
COPY src/main/java/ /usr/src/app/java/
RUN javac -d /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/ /usr/src/app/java/controller/*.java /usr/src/app/java/modelo/*.java

# Copiar la aplicación web al directorio webapps de Tomcat
COPY src/main/webapp/ /usr/local/tomcat/webapps/ROOT/

# Exponer el puerto 8080 para acceso HTTP
EXPOSE 8080

# Comando para iniciar Tomcat
CMD ["catalina.sh", "run"]

