# memory_test.py
import time

increment = 10 * 1024 * 1024  # 10 MB
memory_hog = bytearray()

while True:
    memory_hog.extend(bytearray(increment))
    print(f"Used memory: {len(memory_hog)/1024/1024} MB")
    time.sleep(5)
