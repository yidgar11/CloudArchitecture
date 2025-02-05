import base64

input_string = "myuser"

encoded = base64.b64encode(input_string.encode("utf-8"))
encoded = encoded.decode("utf-8")
print(encoded)