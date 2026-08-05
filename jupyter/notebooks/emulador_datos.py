import random
import time
from datetime import datetime

import mysql.connector

# ======================================================
# CONEXION
# ======================================================

cnx = mysql.connector.connect(
    host="172.27.1.15",      # mysql si el script corre dentro de Docker
    port=3306,
    user="root",
    password="root",
    database="retail_db"
)

cursor = cnx.cursor(dictionary=True)

# ======================================================
# CARGAR CLIENTES
# ======================================================

cursor.execute("""
SELECT customer_id
FROM customers
""")

clientes = [x["customer_id"] for x in cursor.fetchall()]

print(f"Clientes cargados: {len(clientes)}")

# ======================================================
# CARGAR PRODUCTOS
# ======================================================

cursor.execute("""
SELECT
    product_id,
    product_price
FROM products
WHERE product_price IS NOT NULL
""")

productos = cursor.fetchall()

print(f"Productos cargados: {len(productos)}")

# ======================================================
# ULTIMO ORDER_ID
# ======================================================

cursor.execute("""
SELECT IFNULL(MAX(order_id),0) ultimo
FROM orders
""")

order_id = cursor.fetchone()["ultimo"]

# ======================================================
# ULTIMO ORDER_ITEM_ID
# ======================================================

cursor.execute("""
SELECT IFNULL(MAX(order_item_id),0) ultimo
FROM order_items
""")

order_item_id = cursor.fetchone()["ultimo"]

print("Ultimo order_id:", order_id)
print("Ultimo order_item_id:", order_item_id)

print("\nSimulador iniciado...\n")

# ======================================================
# LOOP INFINITO
# ======================================================

while True:

    order_id += 1

    cliente = random.choice(clientes)

    estado = random.choice([
        "COMPLETE",
        "PENDING",
        "PROCESSING",
        "CLOSED"
    ])

    fecha = datetime.now()

    # -----------------------------------------------
    # INSERT ORDER
    # -----------------------------------------------

    sql = """
    INSERT INTO orders
    (
        order_id,
        order_date,
        order_customer_id,
        order_status
    )
    VALUES
    (
        %s,%s,%s,%s
    )
    """

    cursor.execute(
        sql,
        (
            order_id,
            fecha,
            cliente,
            estado
        )
    )

    # -----------------------------------------------
    # ENTRE 1 Y 5 PRODUCTOS
    # -----------------------------------------------

    cantidad_items = random.randint(1,5)

    total = 0

    for _ in range(cantidad_items):

        order_item_id += 1

        producto = random.choice(productos)

        product_id = producto["product_id"]

        precio = float(producto["product_price"])

        cantidad = random.randint(1,4)

        subtotal = round(precio*cantidad,2)

        total += subtotal

        sql = """
        INSERT INTO order_items
        (
            order_item_id,
            order_item_order_id,
            order_item_product_id,
            order_item_quantity,
            order_item_subtotal,
            order_item_product_price
        )
        VALUES
        (
            %s,%s,%s,%s,%s,%s
        )
        """

        cursor.execute(
            sql,
            (
                order_item_id,
                order_id,
                product_id,
                cantidad,
                subtotal,
                precio
            )
        )

    cnx.commit()

    print( "Para la tabla orders", 
        f"Orden {order_id} | "
        f"Fecha {fecha} | "
        f"Cliente {cliente} | "
        f"Estado {estado}"
    )
    print( "Para la tabla order_items", 
        f"Orden_item {order_item_id} | "
        f"Order_id {order_id} | "
        f"Producto_id {product_id} | "
        f"Subtotal ${subtotal:.2f}| "
        f"Total ${precio:.2f}"
    )

    time.sleep(random.randint(5,8))