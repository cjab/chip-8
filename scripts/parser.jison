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
    : CLS          -> yy.cls()
    | RET          -> yy.ret()
    | SYS  address -> yy.sys($address)
    | JP   jp_operands
    | DRW  register ',' register ',' NIBBLE -> yy.drw($register1, $register2, $NIBBLE)
    | CALL address -> yy.call_addr($address)
    | LD   ld_operands
    | ADD  add_operands
    | SE   se_operands
    | SNE  sne_operands
    | RND  register ',' byte -> yy.rnd($register, $byte)
    | SHR  shr_operands
    | SHL  shl_operands
    | SKP  register -> yy.skp($register)
    | SKNP register -> yy.sknp($register)
    | OR   register "," register -> yy.or($register1, $register2)
    | AND  register "," register -> yy.and($register1, $register2)
    | XOR  register "," register -> yy.xor($register1, $register2)
    | SUB  register "," register -> yy.sub($register1, $register2)
    | SUBN register "," register -> yy.subn($register1, $register2)
    ;

register
    : 'V0'     -> 0x0
    | REGISTER -> parseInt($REGISTER.slice(1), 16)
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
    : address        -> yy.jp_addr($address)
    | V0 ',' address -> yy.jp_v0_addr($address)
    ;

ld_operands
    : ld_first_operand ld_second_operand
    | I  ',' address         -> yy.ld_i_addr($address)
    | DT ',' register        -> yy.ld_dt_reg($register)
    | ST ',' register        -> yy.ld_st_reg($register)
    | F  ',' register        -> yy.ld_f_reg($register)
    | B  ',' register        -> yy.ld_b_reg($register)
    | '[' I ']' ',' register -> yy.ld_start_reg($register)
    ;

ld_first_operand
    : register ',' -> $register
    ;

ld_second_operand
    : byte      -> yy.ld_reg_byte($0, $byte)
    | register  -> yy.ld_reg_reg($0, $register)
    | DT        -> yy.ld_reg_dt($0)
    | K         -> yy.ld_reg_k($0)
    | '[' I ']' -> yy.ld_reg_start($0)
    ;

add_operands
    : add_first_operand add_second_operand
    | I ',' register -> yy.add_i_reg($register)
    ;

add_first_operand
    : register ',' -> $register
    ;

add_second_operand
    : byte     -> yy.add_reg_byte($0, $byte)
    | register -> yy.add_reg_reg($0, $register)
    ;

se_operands
    : se_first_operand se_second_operand
    ;

se_first_operand
    : register ',' -> $register
    ;

se_second_operand
    : byte     -> yy.se_reg_byte($0, $byte)
    | register -> yy.se_reg_reg($0, $register)
    ;

sne_operands
    : sne_first_operand sne_second_operand
    ;

sne_first_operand
    : register ',' -> $register
    ;

sne_second_operand
    : byte     -> yy.sne_reg_byte($0, $byte)
    | register -> yy.sne_reg_reg($0, $register)
    ;

shr_operands
    : register              -> yy.shr($register, 0)
    | register ',' register -> yy.shr($register1, $register2)
    ;

shl_operands
    : register              -> yy.shl($register, 0)
    | register ',' register -> yy.shl($register1, $register2)
    ;
