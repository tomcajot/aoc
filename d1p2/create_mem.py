mem = []
nums = []

with open("input_test.txt") as f:
    for l in f:
        n = int(l.strip()[1:])
        nums.append(n)
        number = str(bin(n))[2:].zfill(10)
        if (l.strip()[0] == "R"):
            mem.append("1" + str(number))
        else:
            mem.append("0" + str(number))

with open("input_test.vmem", "x") as out:
    for i in range(len(mem)):
        out.write(mem[i] + "\n")

print(max(nums))