/* lexical grammar */
%lex
%%

\s+                   /* skip whitespace */
"0x"[0-9a-fA-F]{3}    return 'ADDRESS'
"0x"[0-9a-fA-F]{2}    return 'BYTE'
"0x"[0-9a-fA-F]       return 'NIBBLE'
"V0"                  return 'V0'
"V"[0-9a-fA-F]        return 'REGISTER'
"DT"                  return 'DT'
"K"                   return 'K'
"ST"                  return 'ST'
"I"                   return 'I'
"F"                   return 'F'
"B"                   return 'B'
"["                   return '['
"]"                   return ']'
","                   return ','
"CLS"                 return 'CLS'
"RET"                 return 'RET'
"SYS"                 return 'SYS'
"JP"                  return 'JP'
"CALL"                return 'CALL'
"LD"                  return 'LD'
"ADD"                 return 'ADD'
"SE"                  return 'SE'
"SNE"                 return 'SNE'
"RND"                 return 'RND'
"SHR"                 return 'SHR'
"SHL"                 return 'SHL'
"SKP"                 return 'SKP'
"SKNP"                return 'SKNP'
"OR"                  return 'OR'
"AND"                 return 'AND'
"XOR"                 return 'XOR'
"SUB"                 return 'SUB'
"SUBN"                return 'SUBN'
"DRW"                 return 'DRW'
<<EOF>>               return 'EOF'
.                     return 'INVALID'


/lex


%start line

%% /* language grammar */

line
    : instruction line
    | EOF
    ;

instruction
    : CLS
    | RET
    | SYS  address
    | JP   jp_operands
    | DRW  register ',' register ',' NIBBLE
    | CALL address
    | LD   ld_operands
    | ADD  add_operands
    | SE   se_operands
    | SNE  sne_operands
    | RND  register ',' byte
    | SHR  shr_operands
    | SHL  shl_operands
    | SKP  register
    | SKNP register
    | OR   register "," register
    | AND  register "," register
    | XOR  register "," register
    | SUB  register "," register
    | SUBN register "," register
    ;

register
    : 'V0'
    | REGISTER
    ;

address
    : ADDRESS
    | BYTE
    | NIBBLE
    ;

byte
    : BYTE
    | NIBBLE
    ;

jp_operands
    : address
    | VO ',' address
    ;

ld_operands
    : register ',' ld_second_operand
    | I  ',' address
    | DT ',' register
    | ST ',' register
    | F  ',' register
    | B  ',' register
    | '[' I ']' ',' register
    ;

ld_second_operand
    : byte
    | register
    | DT
    | K
    | '[' I ']'
    ;

add_operands
    : register ',' add_second_operand
    | I ',' register
    ;

add_second_operand
    : byte
    | register
    ;

se_operands
    : register ',' se_second_operand
    ;

se_second_operand
    : byte
    | register
    ;

sne_operands
    : register ',' sne_second_operand
    ;

sne_second_operand
    : byte
    | register
    ;

shr_operands
    : register
    | register ',' register
    ;

shl_operands
    : register
    | register ',' register
    ;
