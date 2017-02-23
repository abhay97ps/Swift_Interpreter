import lexer

KEYWORD = 'KEYWORD'
NUMBER = 'NUMBER'
IDENTIFIER = 'IDENTIFIER'
OPERATOR = 'OPERATOR'

token_definitions = [
    (r'[ \n\t]+',               None),
    (r'\=',                     OPERATOR),
    (r'\(',                     OPERATOR),
    (r'\)',                     OPERATOR),
    (r'\;',                     OPERATOR),
    (r'\+',                     OPERATOR),
    (r'\-',                     OPERATOR),
    (r'\*',                     OPERATOR),
    (r'/',                      OPERATOR),
    (r'<=',                     OPERATOR),
    (r'<' ,                     OPERATOR),
    (r'>=',                     OPERATOR),
    (r'>',                      OPERATOR),
    (r'==',                     OPERATOR),
    (r'var',                    KEYWORD),
    (r'let',                    KEYWORD),
    (r'int',                    KEYWORD),
    (r'if',                     KEYWORD),
    (r'else',                   KEYWORD),
    (r'[0-9]+',                 NUMBER),
    (r'[A-Za-z][A-Za-z0-9_]*',  IDENTIFIER),

    ]
def tokenize(input_string):
    return lexer.tokenizer(input_string, token_definitions)
