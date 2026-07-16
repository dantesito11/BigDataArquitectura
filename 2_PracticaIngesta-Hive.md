# LABORATORIO 2 ARQUITECTURA DATALAKE 
## Prerequisitos 
# 1.- Actualizar cambios de repositorio
1. Click en el repositorio , click en commit ahead o sync fork 
2. Entrar al codespace 
3. Instalar la extendsion de DOCKER EXPLORER
4. Abrir terminal de codespace
   ```    >git fetch origin     ``` <br>
   ```    >git reset --hard origin/master     ``` <br>
   
5. Ejecutar el siguiente comando para desplegar los contenedores<br>
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
```     >_ sh /datanode/scripts/sqoop/script_sqoop_textfile.sh     ```<br>
```     >_ sh /datanode/scripts/sqoop/script_sqoop_avro.sh     ``` <br>
```     >_ hdfs dfs -put *.avsc /user/datapath/datasets/avro/     ```

# CAPA PROCESAMIENTO / CLEANSED / TRUSTED
## B . Hive
Para poder trabajar con hive ingresamos al contenedor del hive-server. <br>

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
```     >_ USE retail_db;         ```   <br> 
```     >_SELECT  p.product_name, SUM(oi.quantity * oi.list_price) AS total_ventas FROM order_items oi JOIN products p ON oi.product_id = p.product_id GROUP BY p.product_name ORDER BY total_ventas DESC LIMIT 10; ```   <br> 

#### ----------------------------- PRACTICA 2  -------------------------------------## 

1 Descargar un set de datos en formato csv

2 crear base de datos en mysql de su preferencia

3 Importar la base de datos con la herramienta adminer

#### ---------------------------- PRACTICA 3 --------------------------------------##

1 Importar la base de datos escogida a hdfs utilizando sqoop. Ayuda dentro de datanode
```     >_ sh /datanode/scripts/sqoop/script_sqoop_textfile.sh    ``` <br> 
2 Crear una tabla externa con hive. Ayuda dentro de hive-server
```     >_ hive -f /opt/hive.hql    ``` <br> 
3 Construye una agragacion (procesamiento) para la tabla externa
```     >_ hive     ``` <br> 
```     >_ select ... groupby     ``` <br> 

