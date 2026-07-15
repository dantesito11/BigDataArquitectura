# Laboratorio 1 Hadoop

## Descripción del Repositorio
Habilita el repositorio:
- Hadoop

Todo el contenido se ejecutara en codespace de github.

## Desplegar container
1. Crea un "fork": una copia independiente de un repositorio, dentro de tu propia cuenta: 'https://github.com/vanessagironda/BigDataArquitectura'
2. Crear un codespace para el repositorio
3. Instalar la extendsion de DOCKER EXPLORER
4. Abrir terminal de codespace
5. Ejecutar el siguiente comando para desplegar los contenedores<br>
```    >docker compose -f docker-compose-hadoop.yml up     ``` <br>

#### PRACTICA 1 ## 
0. Visuzalizar los puertos e intefaz grafica 
1. Descargar un set de datos en formato csv
2. Copiar el archivo a HDFS namenode con 
```    >docker cp archivo.csv id_namenode:/home/     ``` <br>
3. Entrar el namenode con click derecho sobre CONTAINERS, open in bash 
4. Copiar el archivo en HDFS a HDFS /temp
```    >hdfs dfs -put archivo.csv /temp     ``` <br>
5. Verificar el tipo de configuracion de replicas 
```    >hdfs getconf -confKey dfs.replication     ``` <br>
6. Verificar el tipo de configuracion de replicas por directorio 
```    >hdfs fsck /ruta/directorio -files -blocks     ``` <br>
7. Verificar el tipo de configuracion de replicas por directorio y nodos 
```    >hdfs fsck /ruta/del/archivo -files -blocks -locations     ``` <br>

8. Verificar el tipo de configuracion de replicas por directorio y nodos 
```    >hdfs getconf -confKey dfs.blocksize     ``` <br>

## Retos

1. Modificar el archivo  docker-compose-hadoop.yml para agregar un nodo datanode para tener 3 workers
2. Subir un archivo mayor a 128 MB a un sistema de srchivos distribuido (hdfs) 
```    >docker cp archivo.csv id_namenode:/home/     ``` <br>
3. Validar configuraciones : replicas cada bloque de datos , cuantos bloques tiene el archivo ( a nivel de comandos y a nivel de entorno grafico)
4. Validar comandos

### Error al subir cambios
```    $ git add . && git commit -m "update" && git push origin master     ``` <br>
```    error: failed to push some refs to xxxxxxxx ``` <br>
```    hint: Updates were rejected because the remote contains work that you do not``` <br>
```    hint: have locally. This is usually caused by another repository pushing to``` <br>
```    hint: the same ref. If you want to integrate the remote changes, use``` <br>
```    hint: 'git pull' before pushing again.``` <br>
```    hint: See the 'Note about fast-forwards' in 'git push --help' for details.``` <br>
```    $ git push origin master --force``` <br>
```    $ git add . && git commit -m "update" && git push origin master``` <br>
