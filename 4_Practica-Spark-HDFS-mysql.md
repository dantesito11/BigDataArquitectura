# LABORATORIO 4 SPARK-HDFS-MYSQL
## Prerequisitos 
# 1.- Actualizar cambios de repositorio
1. Click en el repositorio , click en commit ahead o sync fork 
2. Entrar al codespace 
3. Instalar la extendsion de DOCKER EXPLORER
4. Abrir terminal de codespace
   
   ```    >git fetch origin     ``` <br>
   ```    >git reset --hard origin/master     ``` <br>
   
6. Ejecutar el siguiente comando para desplegar los contenedores<br>

```    >docker compose -f docker-compose-actualizado.yml up     ``` <br>

# 2 Mysql
Este contenedor contiene una base de datos llamada retail_db y consta de las siguientes tablas: <br>
- customers
- orders
- order_items
- products
- categories
- departments
<br>
credenciales:
<br>
user: root
<br>
pass: root
<br>
port: 3310
<br>
Ejecutar ifconfig en terminal para obtener la ip (eth0)

# 3 Ayuda Docker
Para inicializar de nuevo 
1 Detén todos los contenedores:

```    >_ docker stop $(docker ps -q)     ``` <br>

2. Elimina todos los contenedores:
   
```    >_ docker rm -f $(docker ps -aq)     ``` <br>

3. Elimina todas las imágenes:
   
```    >_ docker network prune -f     ``` <br>

4. Elimina todos los volúmenes:

```    >_ docker volume rm $(docker volume ls -q)     ``` <br>

5. Elimina las redes no predeterminadas:

```    >_ docker network prune -f     ``` <br>

6. Finalmente limpia todo:

```    >_ docker system prune -a --volumes -f     ``` <br>

Validacion 

```    >_ docker ps -a     ``` <br>

```    >_ docker images     ``` <br>

```    >_ docker volume ls     ``` <br>

```    >_ docker network ls     ``` <br>

# 4 Ayuda Docker modificar Dockerfile
Forzar la reconstrucción en caso de modificar solo jupyter : 
Reconstruye la imagen de jupyter.
Recrea únicamente el contenedor jupyter.
No afecta a Hadoop, Kafka, MySQL, etc.
1. Opcion 1 LIviano , dado que solo reconstruye lo que fue adicionado 
   
```    >_ docker compose -f docker-compose-actualizado.yml up -d --build jupyter     ``` <br>

2. Opcion 2 Ignorar la caché, es decir si realmente reconstruyre todo lo que esta en el archivo DockerFIile 

```    >_ docker compose -f docker-compose-actualizado.yml build --no-cache jupyter     ``` <br>

```    >_ docker compose -f docker-compose-actualizado.yml up -d jupyter     ``` <br>

# 5 Ayuda Codespace
Para inicializar de nuevo por eeroores de abrir un puerto

1 Ejecuta:

```    >_ Ctrl + Shift + P     ``` <br>

2 Luego:

```    >_ Developer: Reload Window     ``` <br>



# 6 Abrir el notebook

