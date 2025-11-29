import struct

n = 3

arr = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
]

with open("input.bin", "wb") as file:
    file.write(struct.pack('i', n))
    
    for i in range(n):
        for j in range(n):
            file.write(struct.pack('i', arr[i][j]))

with open("output.bin", "rb") as file:

    for _ in range(4):
        for i in range(n):
            for j in range(n):
                data = file.read(4)
                if len(data) >= 4:
                    print(struct.unpack('i', data)[0], end=" ")
            print("")
        print("")


