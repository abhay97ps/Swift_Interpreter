import sys
import re

def tokenizer(input_string, token_exprs):
    pos = 0
    tokens = []
    while pos < len(input_string):
        match = None
        for token_expr in token_exprs:
            pattern, tag = token_expr
            regex = re.compile(pattern)
            match = regex.match(input_string, pos)
            if match:
                text = match.group(0)
                if tag:
                    token = (text, tag)
                    tokens.append(token)
                break
        if not match:
            sys.stderr.write('Illegal character: %s\n' % input_string[pos])
            sys.exit(1)
        else:
            pos = match.end(0)
    return tokens
