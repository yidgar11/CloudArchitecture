import time
from datetime import date

data = []
x = 1
while True:
    print(f"Iteration: {x}")
    x = x+1
    data.append(' ' * 10**6)  # Allocate 1 MB of spaces repeatedly
    time.sleep(1)