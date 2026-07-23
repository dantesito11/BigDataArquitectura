# LABORATORIO 3 SPARK
## Prerequisitos 
# 1.- Actualizar cambios de repositorio
1. Click en el repositorio , click en commit ahead o sync fork 
2. Entrar al codespace 
3. Instalar la extendsion de DOCKER EXPLORER
4. Abrir terminal de codespace
   
   ```    >git fetch origin     ``` <br>
   ```    >git reset --hard origin/master     ``` <br>
   
6. Ejecutar el siguiente comando para desplegar los contenedores<br>

```    >docker compose -f docker-compose-spark.yml up     ``` <br>

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

Ayuda 
Recreamos la imagen de mysql     

```    >_ docker compose down mysql     ``` <br>
```    >_ docker compose up -d --build mysql     ``` <br>

# 3 Spark ingesta de Datos
