import struct

n = 3

arr = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
]

with open("input.bin", "wb") as file:
    file.write(struct.pack(n, 'i'))
    
    for i in range(n):
        for j in range(n):
            file.write(struct.pack(arr[i][j], 'i'))