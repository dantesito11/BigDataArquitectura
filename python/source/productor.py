from kafka import KafkaProducer
import json, time, random

producer = KafkaProducer(
    bootstrap_servers='kafka:9092',
    value_serializer=lambda v: json.dumps(v).encode('utf-8')
)

try:
    while True:
        data = {
            "sensor": random.randint(1, 5),
            "valor": round(random.random() * 100, 2),
            "timestamp": time.time()
        }

        producer.send('demo', value=data)
        print("Enviado:", data)
        time.sleep(2)

except KeyboardInterrupt:
    print("Detenido por usuario")

finally:
    producer.flush()
    producer.close()
