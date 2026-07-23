# LABORATORIO 2 ARQUITECTURA DATALAKE 
## Prerequisitos 
# 1.- Actualizar cambios de repositorio
1. Click en el repositorio , click en commit ahead o sync fork 
2. Entrar al codespace 
3. Instalar la extendsion de DOCKER EXPLORER
4. Abrir terminal de codespace
   
   ```    >git fetch origin     ``` <br>
   ```    >git reset --hard origin/master     ``` <br>
   
6. Ejecutar el siguiente comando para desplegar los contenedores<br>

```    >docker compose -f docker-compose-hive.yml up     ``` <br>

Validar la practica 2_PracticaIngesta-Hive
Validar la archivo docker-compose-hive.yml
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

# 3 Sqoop para Ingesta de Datos

### Entrar a un contenedor "datanode"  -> docker exec -it xxxx bash
Para poder trabajar con hadoop ingresamos al contenedor del datanode. <br>
Abrimos un terminal nuevo y ejecutamos lo siguiente

```     >_ docker exec -it datanode bash     ``` <br> 

Asi para cada contenedor con el que queremos trabajar. <br>


## Sqoop instalación y permisos 
Para utilizar sqoop en el datanode debemos ejecutar lo siguiente

```     >_ sh /datanode/scripts/script.sh     ``` <br> 

# 4.- Docker Hive
Validar los serviciso de la arquitectura 

# CAPA INGESTA / RAW /LANDING 

###  Exportar tablas de mysql - hdfs con sqoop
Para exportar las tabla de la base de datos retail con sqoop ejecutar lo siguiente:<br>

```     >_ sh /datanode/scripts/sqoop/script_sqoop_textfile_import.sh     ```<br>
```     >_ sh /datanode/scripts/sqoop/script_sqoop_avro.sh     ``` <br>

# CAPA PROCESAMIENTO / CLEANSED / TRUSTED
## B . Hive
Para poder trabajar con hive, asumimos que ya existe datos en HDFS y creams tablas externas, 
a partir de un archivo HDFS. Para ello debemos :

Abrir un terminal y copiar el archivo hive.hql a hive-server<br> 

```     >_ docker cp datanode/scripts/hive/hive.hql hive-server:/opt      ``` <br> 
```     >_ docker cp datanode/scripts/hive/hive_avro.hql hive-server:/opt      ``` <br> 

Abrimos un terminal nuevo y ejecutamos lo siguiente

```     >_ docker exec -it hive-server bash     ``` <br> 

Para crear tablas externas en base a los datos importados con sqoop ejecutamos los siguientes pasos:<br>

En el terminal de hive-server ejecutamos lo siguiente para crear las tablas. <br> 

```     >_ hive -f /opt/hive.hql    ``` <br> 
```     >_ hive -f /opt/hive_avro.hql    ``` <br> 

En el terminal de hive-server ejecutamos
```     >_ hive     ``` <br> 
```     >_ USE retail_db_raw;         ```   <br> 
```     >_SELECT p.product_name, SUM(oi.order_item_quantity * oi.order_item_product_price) AS total_ventas FROM retail_db_raw.order_items oi JOIN retail_db_raw.products p ON oi.order_item_product_id = p.product_id GROUP BY p.product_name ORDER BY total_ventas DESC LIMIT 10; ```   <br> 

La respuesta puede ser guardada en la capa de procesamiento
Para ello creamos una tabla externa: 

```     >_CREATE DATABASE retail_db_cleansed; ```   <br>
```     >_USE DATABASE retail_db_cleansed; ```   <br>
La tabla puede estar en formato parquet: 

```     >_CREATE EXTERNAL TABLE retail_db_cleansed.top10_productos ( product_name STRING, total_ventas DOUBLE ) STORED AS PARQUET LOCATION '/cleansed/top10_productos_parquet'; ```   <br>

La tabla puede estar en formato textfile: 

```     >_CREATE EXTERNAL TABLE retail_db_cleansed.top10_productos_text (product_name STRING,total_ventas DOUBLE) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE LOCATION '/cleansed/top10_productos_text';```   <br>

Luego cargas los datos procesados para la tabla en parquet 

```     >_INSERT OVERWRITE TABLE retail_db_cleansed.top10_productos SELECT p.product_name, SUM(oi.order_item_subtotal) AS total_ventas FROM retail_db_raw.order_items oi JOIN retail_db_raw.products p ON oi.order_item_product_id = p.product_id GROUP BY p.product_name ORDER BY total_ventas DESC LIMIT 10; ```   <br>

Luego cargas los datos procesados para la tabla en textfile 

```     >_INSERT OVERWRITE TABLE retail_db_cleansed.top10_productos_text SELECT p.product_name, SUM(oi.order_item_subtotal) AS total_ventas FROM retail_db_raw.order_items oi JOIN retail_db_raw.products p ON oi.order_item_product_id = p.product_id GROUP BY p.product_name ORDER BY total_ventas DESC LIMIT 10; ```   <br>



# CAPA USUARIO / USER / PRESENTACION
###  Crear una base de datos emulando una capa de usuario en mysql
Entrar a contenedor de mysql 
```     >_ mysql -u root -p ```<br>

Crear una base de datos realcional para el usuario
```     >_ mysql>CREATE DATABASE retail_db_cleansed_rel;     ```<br>
```     >_ mysql> use retail_db_cleansed_rel;     ```<br>
```     >_ mysql> CREATE TABLE top10_productos (product_name VARCHAR(255),total_ventas DOUBLE);     ```<br>

Exportar el contenido de la capa cleansed a la capa usuario (mysql)
```     >_ sh /datanode/scripts/sqoop/script_sqoop_textfile_export.sh     ```<br>

# PRACTICA 2  PIPELINE DATALAKE

1 Descargar un set de datos o base de datos en formato csv

2 Crear base de datos en mysql de su preferencia

3 Importar la base de datos con la herramienta adminer

4 CAPA RAW: Importar la base de datos escogida a hdfs utilizando sqoop. 
Ayuda dentro de datanode
```     >_ sh /datanode/scripts/sqoop/script_sqoop_textfile_nombre_diplomante.sh    ``` <br> 
5 Crear una tabla externa con hive. 
Ayuda dentro de hive-server
```     >_ hive -f /opt/hive_nombre_diplomante.hql    ``` <br> 
6 CAPA CLEANSED: Construye una agregacion (procesamiento) para la tabla externa
```     >_ hive     ``` <br> 
```     >_ select ... groupby     ``` <br> 
7 CAPA USER: Exporte los agregados o procesamiento materizalizado en hdfs a mysql

