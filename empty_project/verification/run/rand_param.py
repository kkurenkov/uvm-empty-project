#!/usr/bin/python
from sys import argv
import random

random.seed(argv[1])
# print(argv)

result = []

for _low, _max in zip(argv[2::2], argv[3::2]):
    rand_var = random.randint(int(_low), int(_max))
    result.append(rand_var)

print(*result)
