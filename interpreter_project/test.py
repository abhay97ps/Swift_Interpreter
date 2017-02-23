import sys
from token_def import *

input_string = " int a = 3; "
tokens = tokenize(input_string)
for token in tokens:
    print(token)
