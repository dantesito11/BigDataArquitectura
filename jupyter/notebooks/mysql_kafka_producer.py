import mysql.connector
from kafka import KafkaProducer
import json
import time
# ==================================================
# MYSQL
# ==================================================
cnx = mysql.connector.connect(
    host="172.27.1.15",
    port=3306,
    user="root",
    password="root",
    database="retail_db"
)
cursor = cnx.cursor(dictionary=True)
# ==================================================
# KAFKA
# ==================================================
producer = KafkaProducer(
    bootstrap_servers="kafka:9092",
    value_serializer=lambda x:
        json.dumps(x, default=str).encode("utf-8")
)
# ==================================================
# CONTROL DEL ULTIMO ID
# ==================================================
# ultimo_order_id = 68884
ultimo_order_id = 68884
ultimo_order_item_id = 172198

print("Kafka Producer iniciado...")
# ==================================================
# LOOP
# ==================================================
while True:
    # ----------------------------
    # Buscar nuevos orders
    # ----------------------------
    cursor.execute(
        """
        SELECT
            order_id,
            order_date,
            order_customer_id,
            order_status
        FROM orders
        WHERE order_id > %s
        ORDER BY order_id
        """,
        (ultimo_order_id,)
    )
    orders = cursor.fetchall()
    for order in orders:
        producer.send(
            "orders_topic",
            value=order
        )
        print(
            "Kafka orders:",
            order
        )
        ultimo_order_id = order["order_id"]
    # ----------------------------
    # Buscar order_items
    # ----------------------------
    cursor.execute(
        """
        SELECT
            order_item_id,
            order_item_order_id,
            order_item_product_id,
            order_item_quantity,
            order_item_subtotal,
            order_item_product_price
        FROM order_items
        WHERE order_item_id > %s
        ORDER BY order_item_id
        """,
        (ultimo_order_item_id,)
    )
    items = cursor.fetchall()
    for item in items:
        producer.send(
            "order_items_topic",
            value=item
        )
        print(
            "Kafka items:",
            item
        )
        ultimo_order_item_id = item["order_item_id"]
    producer.flush()
    time.sleep(1)
