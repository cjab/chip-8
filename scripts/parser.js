define([], function(){
var parser = {trace: function trace() { },
yy: {},
symbols_: {"error":2,"line":3,"instruction":4,"EOF":5,"CLS":6,"RET":7,"SYS":8,"address":9,"JP":10,"jp_operands":11,"DRW":12,"register":13,",":14,"NIBBLE":15,"CALL":16,"LD":17,"ld_operands":18,"ADD":19,"add_operands":20,"SE":21,"se_operands":22,"SNE":23,"sne_operands":24,"RND":25,"byte":26,"SHR":27,"shr_operands":28,"SHL":29,"shl_operands":30,"SKP":31,"SKNP":32,"OR":33,"AND":34,"XOR":35,"SUB":36,"SUBN":37,"V0":38,"REGISTER":39,"ADDRESS":40,"BYTE":41,"ld_first_operand":42,"ld_second_operand":43,"I":44,"DT":45,"ST":46,"F":47,"B":48,"[":49,"]":50,"K":51,"add_first_operand":52,"add_second_operand":53,"se_first_operand":54,"se_second_operand":55,"sne_first_operand":56,"sne_second_operand":57,"$accept":0,"$end":1},
terminals_: {2:"error",5:"EOF",6:"CLS",7:"RET",8:"SYS",10:"JP",12:"DRW",14:",",15:"NIBBLE",16:"CALL",17:"LD",19:"ADD",21:"SE",23:"SNE",25:"RND",27:"SHR",29:"SHL",31:"SKP",32:"SKNP",33:"OR",34:"AND",35:"XOR",36:"SUB",37:"SUBN",38:"V0",39:"REGISTER",40:"ADDRESS",41:"BYTE",44:"I",45:"DT",46:"ST",47:"F",48:"B",49:"[",50:"]",51:"K"},
productions_: [0,[3,2],[3,1],[4,1],[4,1],[4,2],[4,2],[4,6],[4,2],[4,2],[4,2],[4,2],[4,2],[4,4],[4,2],[4,2],[4,2],[4,2],[4,4],[4,4],[4,4],[4,4],[4,4],[13,1],[13,1],[9,1],[9,1],[9,1],[26,1],[26,1],[11,1],[11,3],[18,2],[18,3],[18,3],[18,3],[18,3],[18,3],[18,5],[42,2],[43,1],[43,1],[43,1],[43,1],[43,3],[20,2],[20,3],[52,2],[53,1],[53,1],[22,2],[54,2],[55,1],[55,1],[24,2],[56,2],[57,1],[57,1],[28,1],[28,3],[30,1],[30,3]],
performAction: function anonymous(yytext,yyleng,yylineno,yy,yystate,$$,_$) {

var $0 = $$.length - 1;
switch (yystate) {
case 3:this.$ = yy.cls();
break;
case 4:this.$ = yy.ret();
break;
case 5:this.$ = yy.sys($$[$0]);
break;
case 7:this.$ = yy.drw($$[$0-4], $$[$0-2], $$[$0]);
break;
case 8:this.$ = yy.call_addr($$[$0]);
break;
case 13:this.$ = yy.rnd($$[$0-2], $$[$0]);
break;
case 16:this.$ = yy.skp($$[$0]);
break;
case 17:this.$ = yy.sknp($$[$0]);
break;
case 18:this.$ = yy.or($$[$0-2], $$[$0]);
break;
case 19:this.$ = yy.and($$[$0-2], $$[$0]);
break;
case 20:this.$ = yy.xor($$[$0-2], $$[$0]);
break;
case 21:this.$ = yy.sub($$[$0-2], $$[$0]);
break;
case 22:this.$ = yy.subn($$[$0-2], $$[$0]);
break;
case 23:this.$ = 0x0;
break;
case 24:this.$ = parseInt($$[$0].slice(1), 16);
break;
case 30:this.$ = yy.jp_addr($$[$0]);
break;
case 31:this.$ = yy.jp_v0_addr($$[$0]);
break;
case 33:this.$ = yy.ld_i_addr($$[$0]);
break;
case 34:this.$ = yy.ld_dt_reg($$[$0]);
break;
case 35:this.$ = yy.ld_st_reg($$[$0]);
break;
case 36:this.$ = yy.ld_f_reg($$[$0]);
break;
case 37:this.$ = yy.ld_b_reg($$[$0]);
break;
case 38:this.$ = yy.ld_start_reg($$[$0]);
break;
case 39:this.$ = $$[$0-1];
break;
case 40:this.$ = yy.ld_reg_byte($$[$0-1], $$[$0]);
break;
case 41:this.$ = yy.ld_reg_reg($$[$0-1], $$[$0]);
break;
case 42:this.$ = yy.ld_reg_dt($$[$0-1]);
break;
case 43:this.$ = yy.ld_reg_k($$[$0-1]);
break;
case 44:this.$ = yy.ld_reg_start($$[$0-3]);
break;
case 46:this.$ = yy.add_i_reg($$[$0]);
break;
case 47:this.$ = $$[$0-1];
break;
case 48:this.$ = yy.add_reg_byte($$[$0-1], $$[$0]);
break;
case 49:this.$ = yy.add_reg_reg($$[$0-1], $$[$0]);
break;
case 51:this.$ = $$[$0-1];
break;
case 52:this.$ = yy.se_reg_byte($$[$0-1], $$[$0]);
break;
case 53:this.$ = yy.se_reg_reg($$[$0-1], $$[$0]);
break;
case 55:this.$ = $$[$0-1];
break;
case 56:this.$ = yy.sne_reg_byte($$[$0-1], $$[$0]);
break;
case 57:this.$ = yy.sne_reg_reg($$[$0-1], $$[$0]);
break;
case 58:this.$ = yy.shr($$[$0], 0);
break;
case 59:this.$ = yy.shr($$[$0-2], $$[$0]);
break;
case 60:this.$ = yy.shl($$[$0], 0);
break;
case 61:this.$ = yy.shl($$[$0-2], $$[$0]);
break;
}
},
table: [{3:1,4:2,5:[1,3],6:[1,4],7:[1,5],8:[1,6],10:[1,7],12:[1,8],16:[1,9],17:[1,10],19:[1,11],21:[1,12],23:[1,13],25:[1,14],27:[1,15],29:[1,16],31:[1,17],32:[1,18],33:[1,19],34:[1,20],35:[1,21],36:[1,22],37:[1,23]},{1:[3]},{3:24,4:2,5:[1,3],6:[1,4],7:[1,5],8:[1,6],10:[1,7],12:[1,8],16:[1,9],17:[1,10],19:[1,11],21:[1,12],23:[1,13],25:[1,14],27:[1,15],29:[1,16],31:[1,17],32:[1,18],33:[1,19],34:[1,20],35:[1,21],36:[1,22],37:[1,23]},{1:[2,2]},{5:[2,3],6:[2,3],7:[2,3],8:[2,3],10:[2,3],12:[2,3],16:[2,3],17:[2,3],19:[2,3],21:[2,3],23:[2,3],25:[2,3],27:[2,3],29:[2,3],31:[2,3],32:[2,3],33:[2,3],34:[2,3],35:[2,3],36:[2,3],37:[2,3]},{5:[2,4],6:[2,4],7:[2,4],8:[2,4],10:[2,4],12:[2,4],16:[2,4],17:[2,4],19:[2,4],21:[2,4],23:[2,4],25:[2,4],27:[2,4],29:[2,4],31:[2,4],32:[2,4],33:[2,4],34:[2,4],35:[2,4],36:[2,4],37:[2,4]},{9:25,15:[1,28],40:[1,26],41:[1,27]},{9:30,11:29,15:[1,28],38:[1,31],40:[1,26],41:[1,27]},{13:32,38:[1,33],39:[1,34]},{9:35,15:[1,28],40:[1,26],41:[1,27]},{13:44,18:36,38:[1,33],39:[1,34],42:37,44:[1,38],45:[1,39],46:[1,40],47:[1,41],48:[1,42],49:[1,43]},{13:48,20:45,38:[1,33],39:[1,34],44:[1,47],52:46},{13:51,22:49,38:[1,33],39:[1,34],54:50},{13:54,24:52,38:[1,33],39:[1,34],56:53},{13:55,38:[1,33],39:[1,34]},{13:57,28:56,38:[1,33],39:[1,34]},{13:59,30:58,38:[1,33],39:[1,34]},{13:60,38:[1,33],39:[1,34]},{13:61,38:[1,33],39:[1,34]},{13:62,38:[1,33],39:[1,34]},{13:63,38:[1,33],39:[1,34]},{13:64,38:[1,33],39:[1,34]},{13:65,38:[1,33],39:[1,34]},{13:66,38:[1,33],39:[1,34]},{1:[2,1]},{5:[2,5],6:[2,5],7:[2,5],8:[2,5],10:[2,5],12:[2,5],16:[2,5],17:[2,5],19:[2,5],21:[2,5],23:[2,5],25:[2,5],27:[2,5],29:[2,5],31:[2,5],32:[2,5],33:[2,5],34:[2,5],35:[2,5],36:[2,5],37:[2,5]},{5:[2,25],6:[2,25],7:[2,25],8:[2,25],10:[2,25],12:[2,25],16:[2,25],17:[2,25],19:[2,25],21:[2,25],23:[2,25],25:[2,25],27:[2,25],29:[2,25],31:[2,25],32:[2,25],33:[2,25],34:[2,25],35:[2,25],36:[2,25],37:[2,25]},{5:[2,26],6:[2,26],7:[2,26],8:[2,26],10:[2,26],12:[2,26],16:[2,26],17:[2,26],19:[2,26],21:[2,26],23:[2,26],25:[2,26],27:[2,26],29:[2,26],31:[2,26],32:[2,26],33:[2,26],34:[2,26],35:[2,26],36:[2,26],37:[2,26]},{5:[2,27],6:[2,27],7:[2,27],8:[2,27],10:[2,27],12:[2,27],16:[2,27],17:[2,27],19:[2,27],21:[2,27],23:[2,27],25:[2,27],27:[2,27],29:[2,27],31:[2,27],32:[2,27],33:[2,27],34:[2,27],35:[2,27],36:[2,27],37:[2,27]},{5:[2,6],6:[2,6],7:[2,6],8:[2,6],10:[2,6],12:[2,6],16:[2,6],17:[2,6],19:[2,6],21:[2,6],23:[2,6],25:[2,6],27:[2,6],29:[2,6],31:[2,6],32:[2,6],33:[2,6],34:[2,6],35:[2,6],36:[2,6],37:[2,6]},{5:[2,30],6:[2,30],7:[2,30],8:[2,30],10:[2,30],12:[2,30],16:[2,30],17:[2,30],19:[2,30],21:[2,30],23:[2,30],25:[2,30],27:[2,30],29:[2,30],31:[2,30],32:[2,30],33:[2,30],34:[2,30],35:[2,30],36:[2,30],37:[2,30]},{14:[1,67]},{14:[1,68]},{5:[2,23],6:[2,23],7:[2,23],8:[2,23],10:[2,23],12:[2,23],14:[2,23],16:[2,23],17:[2,23],19:[2,23],21:[2,23],23:[2,23],25:[2,23],27:[2,23],29:[2,23],31:[2,23],32:[2,23],33:[2,23],34:[2,23],35:[2,23],36:[2,23],37:[2,23]},{5:[2,24],6:[2,24],7:[2,24],8:[2,24],10:[2,24],12:[2,24],14:[2,24],16:[2,24],17:[2,24],19:[2,24],21:[2,24],23:[2,24],25:[2,24],27:[2,24],29:[2,24],31:[2,24],32:[2,24],33:[2,24],34:[2,24],35:[2,24],36:[2,24],37:[2,24]},{5:[2,8],6:[2,8],7:[2,8],8:[2,8],10:[2,8],12:[2,8],16:[2,8],17:[2,8],19:[2,8],21:[2,8],23:[2,8],25:[2,8],27:[2,8],29:[2,8],31:[2,8],32:[2,8],33:[2,8],34:[2,8],35:[2,8],36:[2,8],37:[2,8]},{5:[2,9],6:[2,9],7:[2,9],8:[2,9],10:[2,9],12:[2,9],16:[2,9],17:[2,9],19:[2,9],21:[2,9],23:[2,9],25:[2,9],27:[2,9],29:[2,9],31:[2,9],32:[2,9],33:[2,9],34:[2,9],35:[2,9],36:[2,9],37:[2,9]},{13:71,15:[1,76],26:70,38:[1,33],39:[1,34],41:[1,75],43:69,45:[1,72],49:[1,74],51:[1,73]},{14:[1,77]},{14:[1,78]},{14:[1,79]},{14:[1,80]},{14:[1,81]},{44:[1,82]},{14:[1,83]},{5:[2,10],6:[2,10],7:[2,10],8:[2,10],10:[2,10],12:[2,10],16:[2,10],17:[2,10],19:[2,10],21:[2,10],23:[2,10],25:[2,10],27:[2,10],29:[2,10],31:[2,10],32:[2,10],33:[2,10],34:[2,10],35:[2,10],36:[2,10],37:[2,10]},{13:86,15:[1,76],26:85,38:[1,33],39:[1,34],41:[1,75],53:84},{14:[1,87]},{14:[1,88]},{5:[2,11],6:[2,11],7:[2,11],8:[2,11],10:[2,11],12:[2,11],16:[2,11],17:[2,11],19:[2,11],21:[2,11],23:[2,11],25:[2,11],27:[2,11],29:[2,11],31:[2,11],32:[2,11],33:[2,11],34:[2,11],35:[2,11],36:[2,11],37:[2,11]},{13:91,15:[1,76],26:90,38:[1,33],39:[1,34],41:[1,75],55:89},{14:[1,92]},{5:[2,12],6:[2,12],7:[2,12],8:[2,12],10:[2,12],12:[2,12],16:[2,12],17:[2,12],19:[2,12],21:[2,12],23:[2,12],25:[2,12],27:[2,12],29:[2,12],31:[2,12],32:[2,12],33:[2,12],34:[2,12],35:[2,12],36:[2,12],37:[2,12]},{13:95,15:[1,76],26:94,38:[1,33],39:[1,34],41:[1,75],57:93},{14:[1,96]},{14:[1,97]},{5:[2,14],6:[2,14],7:[2,14],8:[2,14],10:[2,14],12:[2,14],16:[2,14],17:[2,14],19:[2,14],21:[2,14],23:[2,14],25:[2,14],27:[2,14],29:[2,14],31:[2,14],32:[2,14],33:[2,14],34:[2,14],35:[2,14],36:[2,14],37:[2,14]},{5:[2,58],6:[2,58],7:[2,58],8:[2,58],10:[2,58],12:[2,58],14:[1,98],16:[2,58],17:[2,58],19:[2,58],21:[2,58],23:[2,58],25:[2,58],27:[2,58],29:[2,58],31:[2,58],32:[2,58],33:[2,58],34:[2,58],35:[2,58],36:[2,58],37:[2,58]},{5:[2,15],6:[2,15],7:[2,15],8:[2,15],10:[2,15],12:[2,15],16:[2,15],17:[2,15],19:[2,15],21:[2,15],23:[2,15],25:[2,15],27:[2,15],29:[2,15],31:[2,15],32:[2,15],33:[2,15],34:[2,15],35:[2,15],36:[2,15],37:[2,15]},{5:[2,60],6:[2,60],7:[2,60],8:[2,60],10:[2,60],12:[2,60],14:[1,99],16:[2,60],17:[2,60],19:[2,60],21:[2,60],23:[2,60],25:[2,60],27:[2,60],29:[2,60],31:[2,60],32:[2,60],33:[2,60],34:[2,60],35:[2,60],36:[2,60],37:[2,60]},{5:[2,16],6:[2,16],7:[2,16],8:[2,16],10:[2,16],12:[2,16],16:[2,16],17:[2,16],19:[2,16],21:[2,16],23:[2,16],25:[2,16],27:[2,16],29:[2,16],31:[2,16],32:[2,16],33:[2,16],34:[2,16],35:[2,16],36:[2,16],37:[2,16]},{5:[2,17],6:[2,17],7:[2,17],8:[2,17],10:[2,17],12:[2,17],16:[2,17],17:[2,17],19:[2,17],21:[2,17],23:[2,17],25:[2,17],27:[2,17],29:[2,17],31:[2,17],32:[2,17],33:[2,17],34:[2,17],35:[2,17],36:[2,17],37:[2,17]},{14:[1,100]},{14:[1,101]},{14:[1,102]},{14:[1,103]},{14:[1,104]},{9:105,15:[1,28],40:[1,26],41:[1,27]},{13:106,38:[1,33],39:[1,34]},{5:[2,32],6:[2,32],7:[2,32],8:[2,32],10:[2,32],12:[2,32],16:[2,32],17:[2,32],19:[2,32],21:[2,32],23:[2,32],25:[2,32],27:[2,32],29:[2,32],31:[2,32],32:[2,32],33:[2,32],34:[2,32],35:[2,32],36:[2,32],37:[2,32]},{5:[2,40],6:[2,40],7:[2,40],8:[2,40],10:[2,40],12:[2,40],16:[2,40],17:[2,40],19:[2,40],21:[2,40],23:[2,40],25:[2,40],27:[2,40],29:[2,40],31:[2,40],32:[2,40],33:[2,40],34:[2,40],35:[2,40],36:[2,40],37:[2,40]},{5:[2,41],6:[2,41],7:[2,41],8:[2,41],10:[2,41],12:[2,41],16:[2,41],17:[2,41],19:[2,41],21:[2,41],23:[2,41],25:[2,41],27:[2,41],29:[2,41],31:[2,41],32:[2,41],33:[2,41],34:[2,41],35:[2,41],36:[2,41],37:[2,41]},{5:[2,42],6:[2,42],7:[2,42],8:[2,42],10:[2,42],12:[2,42],16:[2,42],17:[2,42],19:[2,42],21:[2,42],23:[2,42],25:[2,42],27:[2,42],29:[2,42],31:[2,42],32:[2,42],33:[2,42],34:[2,42],35:[2,42],36:[2,42],37:[2,42]},{5:[2,43],6:[2,43],7:[2,43],8:[2,43],10:[2,43],12:[2,43],16:[2,43],17:[2,43],19:[2,43],21:[2,43],23:[2,43],25:[2,43],27:[2,43],29:[2,43],31:[2,43],32:[2,43],33:[2,43],34:[2,43],35:[2,43],36:[2,43],37:[2,43]},{44:[1,107]},{5:[2,28],6:[2,28],7:[2,28],8:[2,28],10:[2,28],12:[2,28],16:[2,28],17:[2,28],19:[2,28],21:[2,28],23:[2,28],25:[2,28],27:[2,28],29:[2,28],31:[2,28],32:[2,28],33:[2,28],34:[2,28],35:[2,28],36:[2,28],37:[2,28]},{5:[2,29],6:[2,29],7:[2,29],8:[2,29],10:[2,29],12:[2,29],16:[2,29],17:[2,29],19:[2,29],21:[2,29],23:[2,29],25:[2,29],27:[2,29],29:[2,29],31:[2,29],32:[2,29],33:[2,29],34:[2,29],35:[2,29],36:[2,29],37:[2,29]},{9:108,15:[1,28],40:[1,26],41:[1,27]},{13:109,38:[1,33],39:[1,34]},{13:110,38:[1,33],39:[1,34]},{13:111,38:[1,33],39:[1,34]},{13:112,38:[1,33],39:[1,34]},{50:[1,113]},{15:[2,39],38:[2,39],39:[2,39],41:[2,39],45:[2,39],49:[2,39],51:[2,39]},{5:[2,45],6:[2,45],7:[2,45],8:[2,45],10:[2,45],12:[2,45],16:[2,45],17:[2,45],19:[2,45],21:[2,45],23:[2,45],25:[2,45],27:[2,45],29:[2,45],31:[2,45],32:[2,45],33:[2,45],34:[2,45],35:[2,45],36:[2,45],37:[2,45]},{5:[2,48],6:[2,48],7:[2,48],8:[2,48],10:[2,48],12:[2,48],16:[2,48],17:[2,48],19:[2,48],21:[2,48],23:[2,48],25:[2,48],27:[2,48],29:[2,48],31:[2,48],32:[2,48],33:[2,48],34:[2,48],35:[2,48],36:[2,48],37:[2,48]},{5:[2,49],6:[2,49],7:[2,49],8:[2,49],10:[2,49],12:[2,49],16:[2,49],17:[2,49],19:[2,49],21:[2,49],23:[2,49],25:[2,49],27:[2,49],29:[2,49],31:[2,49],32:[2,49],33:[2,49],34:[2,49],35:[2,49],36:[2,49],37:[2,49]},{13:114,38:[1,33],39:[1,34]},{15:[2,47],38:[2,47],39:[2,47],41:[2,47]},{5:[2,50],6:[2,50],7:[2,50],8:[2,50],10:[2,50],12:[2,50],16:[2,50],17:[2,50],19:[2,50],21:[2,50],23:[2,50],25:[2,50],27:[2,50],29:[2,50],31:[2,50],32:[2,50],33:[2,50],34:[2,50],35:[2,50],36:[2,50],37:[2,50]},{5:[2,52],6:[2,52],7:[2,52],8:[2,52],10:[2,52],12:[2,52],16:[2,52],17:[2,52],19:[2,52],21:[2,52],23:[2,52],25:[2,52],27:[2,52],29:[2,52],31:[2,52],32:[2,52],33:[2,52],34:[2,52],35:[2,52],36:[2,52],37:[2,52]},{5:[2,53],6:[2,53],7:[2,53],8:[2,53],10:[2,53],12:[2,53],16:[2,53],17:[2,53],19:[2,53],21:[2,53],23:[2,53],25:[2,53],27:[2,53],29:[2,53],31:[2,53],32:[2,53],33:[2,53],34:[2,53],35:[2,53],36:[2,53],37:[2,53]},{15:[2,51],38:[2,51],39:[2,51],41:[2,51]},{5:[2,54],6:[2,54],7:[2,54],8:[2,54],10:[2,54],12:[2,54],16:[2,54],17:[2,54],19:[2,54],21:[2,54],23:[2,54],25:[2,54],27:[2,54],29:[2,54],31:[2,54],32:[2,54],33:[2,54],34:[2,54],35:[2,54],36:[2,54],37:[2,54]},{5:[2,56],6:[2,56],7:[2,56],8:[2,56],10:[2,56],12:[2,56],16:[2,56],17:[2,56],19:[2,56],21:[2,56],23:[2,56],25:[2,56],27:[2,56],29:[2,56],31:[2,56],32:[2,56],33:[2,56],34:[2,56],35:[2,56],36:[2,56],37:[2,56]},{5:[2,57],6:[2,57],7:[2,57],8:[2,57],10:[2,57],12:[2,57],16:[2,57],17:[2,57],19:[2,57],21:[2,57],23:[2,57],25:[2,57],27:[2,57],29:[2,57],31:[2,57],32:[2,57],33:[2,57],34:[2,57],35:[2,57],36:[2,57],37:[2,57]},{15:[2,55],38:[2,55],39:[2,55],41:[2,55]},{15:[1,76],26:115,41:[1,75]},{13:116,38:[1,33],39:[1,34]},{13:117,38:[1,33],39:[1,34]},{13:118,38:[1,33],39:[1,34]},{13:119,38:[1,33],39:[1,34]},{13:120,38:[1,33],39:[1,34]},{13:121,38:[1,33],39:[1,34]},{13:122,38:[1,33],39:[1,34]},{5:[2,31],6:[2,31],7:[2,31],8:[2,31],10:[2,31],12:[2,31],16:[2,31],17:[2,31],19:[2,31],21:[2,31],23:[2,31],25:[2,31],27:[2,31],29:[2,31],31:[2,31],32:[2,31],33:[2,31],34:[2,31],35:[2,31],36:[2,31],37:[2,31]},{14:[1,123]},{50:[1,124]},{5:[2,33],6:[2,33],7:[2,33],8:[2,33],10:[2,33],12:[2,33],16:[2,33],17:[2,33],19:[2,33],21:[2,33],23:[2,33],25:[2,33],27:[2,33],29:[2,33],31:[2,33],32:[2,33],33:[2,33],34:[2,33],35:[2,33],36:[2,33],37:[2,33]},{5:[2,34],6:[2,34],7:[2,34],8:[2,34],10:[2,34],12:[2,34],16:[2,34],17:[2,34],19:[2,34],21:[2,34],23:[2,34],25:[2,34],27:[2,34],29:[2,34],31:[2,34],32:[2,34],33:[2,34],34:[2,34],35:[2,34],36:[2,34],37:[2,34]},{5:[2,35],6:[2,35],7:[2,35],8:[2,35],10:[2,35],12:[2,35],16:[2,35],17:[2,35],19:[2,35],21:[2,35],23:[2,35],25:[2,35],27:[2,35],29:[2,35],31:[2,35],32:[2,35],33:[2,35],34:[2,35],35:[2,35],36:[2,35],37:[2,35]},{5:[2,36],6:[2,36],7:[2,36],8:[2,36],10:[2,36],12:[2,36],16:[2,36],17:[2,36],19:[2,36],21:[2,36],23:[2,36],25:[2,36],27:[2,36],29:[2,36],31:[2,36],32:[2,36],33:[2,36],34:[2,36],35:[2,36],36:[2,36],37:[2,36]},{5:[2,37],6:[2,37],7:[2,37],8:[2,37],10:[2,37],12:[2,37],16:[2,37],17:[2,37],19:[2,37],21:[2,37],23:[2,37],25:[2,37],27:[2,37],29:[2,37],31:[2,37],32:[2,37],33:[2,37],34:[2,37],35:[2,37],36:[2,37],37:[2,37]},{14:[1,125]},{5:[2,46],6:[2,46],7:[2,46],8:[2,46],10:[2,46],12:[2,46],16:[2,46],17:[2,46],19:[2,46],21:[2,46],23:[2,46],25:[2,46],27:[2,46],29:[2,46],31:[2,46],32:[2,46],33:[2,46],34:[2,46],35:[2,46],36:[2,46],37:[2,46]},{5:[2,13],6:[2,13],7:[2,13],8:[2,13],10:[2,13],12:[2,13],16:[2,13],17:[2,13],19:[2,13],21:[2,13],23:[2,13],25:[2,13],27:[2,13],29:[2,13],31:[2,13],32:[2,13],33:[2,13],34:[2,13],35:[2,13],36:[2,13],37:[2,13]},{5:[2,59],6:[2,59],7:[2,59],8:[2,59],10:[2,59],12:[2,59],16:[2,59],17:[2,59],19:[2,59],21:[2,59],23:[2,59],25:[2,59],27:[2,59],29:[2,59],31:[2,59],32:[2,59],33:[2,59],34:[2,59],35:[2,59],36:[2,59],37:[2,59]},{5:[2,61],6:[2,61],7:[2,61],8:[2,61],10:[2,61],12:[2,61],16:[2,61],17:[2,61],19:[2,61],21:[2,61],23:[2,61],25:[2,61],27:[2,61],29:[2,61],31:[2,61],32:[2,61],33:[2,61],34:[2,61],35:[2,61],36:[2,61],37:[2,61]},{5:[2,18],6:[2,18],7:[2,18],8:[2,18],10:[2,18],12:[2,18],16:[2,18],17:[2,18],19:[2,18],21:[2,18],23:[2,18],25:[2,18],27:[2,18],29:[2,18],31:[2,18],32:[2,18],33:[2,18],34:[2,18],35:[2,18],36:[2,18],37:[2,18]},{5:[2,19],6:[2,19],7:[2,19],8:[2,19],10:[2,19],12:[2,19],16:[2,19],17:[2,19],19:[2,19],21:[2,19],23:[2,19],25:[2,19],27:[2,19],29:[2,19],31:[2,19],32:[2,19],33:[2,19],34:[2,19],35:[2,19],36:[2,19],37:[2,19]},{5:[2,20],6:[2,20],7:[2,20],8:[2,20],10:[2,20],12:[2,20],16:[2,20],17:[2,20],19:[2,20],21:[2,20],23:[2,20],25:[2,20],27:[2,20],29:[2,20],31:[2,20],32:[2,20],33:[2,20],34:[2,20],35:[2,20],36:[2,20],37:[2,20]},{5:[2,21],6:[2,21],7:[2,21],8:[2,21],10:[2,21],12:[2,21],16:[2,21],17:[2,21],19:[2,21],21:[2,21],23:[2,21],25:[2,21],27:[2,21],29:[2,21],31:[2,21],32:[2,21],33:[2,21],34:[2,21],35:[2,21],36:[2,21],37:[2,21]},{5:[2,22],6:[2,22],7:[2,22],8:[2,22],10:[2,22],12:[2,22],16:[2,22],17:[2,22],19:[2,22],21:[2,22],23:[2,22],25:[2,22],27:[2,22],29:[2,22],31:[2,22],32:[2,22],33:[2,22],34:[2,22],35:[2,22],36:[2,22],37:[2,22]},{15:[1,126]},{5:[2,44],6:[2,44],7:[2,44],8:[2,44],10:[2,44],12:[2,44],16:[2,44],17:[2,44],19:[2,44],21:[2,44],23:[2,44],25:[2,44],27:[2,44],29:[2,44],31:[2,44],32:[2,44],33:[2,44],34:[2,44],35:[2,44],36:[2,44],37:[2,44]},{13:127,38:[1,33],39:[1,34]},{5:[2,7],6:[2,7],7:[2,7],8:[2,7],10:[2,7],12:[2,7],16:[2,7],17:[2,7],19:[2,7],21:[2,7],23:[2,7],25:[2,7],27:[2,7],29:[2,7],31:[2,7],32:[2,7],33:[2,7],34:[2,7],35:[2,7],36:[2,7],37:[2,7]},{5:[2,38],6:[2,38],7:[2,38],8:[2,38],10:[2,38],12:[2,38],16:[2,38],17:[2,38],19:[2,38],21:[2,38],23:[2,38],25:[2,38],27:[2,38],29:[2,38],31:[2,38],32:[2,38],33:[2,38],34:[2,38],35:[2,38],36:[2,38],37:[2,38]}],
defaultActions: {3:[2,2],24:[2,1]},
parseError: function parseError(str, hash) {
    throw new Error(str);
},
parse: function parse(input) {
    var self = this,
        stack = [0],
        vstack = [null], // semantic value stack
        lstack = [], // location stack
        table = this.table,
        yytext = '',
        yylineno = 0,
        yyleng = 0,
        recovering = 0,
        TERROR = 2,
        EOF = 1;

    //this.reductionCount = this.shiftCount = 0;

    this.lexer.setInput(input);
    this.lexer.yy = this.yy;
    this.yy.lexer = this.lexer;
    if (typeof this.lexer.yylloc == 'undefined')
        this.lexer.yylloc = {};
    var yyloc = this.lexer.yylloc;
    lstack.push(yyloc);

    if (typeof this.yy.parseError === 'function')
        this.parseError = this.yy.parseError;

    function popStack (n) {
        stack.length = stack.length - 2*n;
        vstack.length = vstack.length - n;
        lstack.length = lstack.length - n;
    }

    function lex() {
        var token;
        token = self.lexer.lex() || 1; // $end = 1
        // if token isn't its numeric value, convert
        if (typeof token !== 'number') {
            token = self.symbols_[token] || token;
        }
        return token;
    }

    var symbol, preErrorSymbol, state, action, a, r, yyval={},p,len,newState, expected;
    while (true) {
        // retreive state number from top of stack
        state = stack[stack.length-1];

        // use default actions if available
        if (this.defaultActions[state]) {
            action = this.defaultActions[state];
        } else {
            if (symbol == null)
                symbol = lex();
            // read action for current state and first input
            action = table[state] && table[state][symbol];
        }

        // handle parse error
        _handle_error:
        if (typeof action === 'undefined' || !action.length || !action[0]) {

            if (!recovering) {
                // Report error
                expected = [];
                for (p in table[state]) if (this.terminals_[p] && p > 2) {
                    expected.push("'"+this.terminals_[p]+"'");
                }
                var errStr = '';
                if (this.lexer.showPosition) {
                    errStr = 'Parse error on line '+(yylineno+1)+":\n"+this.lexer.showPosition()+"\nExpecting "+expected.join(', ') + ", got '" + this.terminals_[symbol]+ "'";
                } else {
                    errStr = 'Parse error on line '+(yylineno+1)+": Unexpected " +
                                  (symbol == 1 /*EOF*/ ? "end of input" :
                                              ("'"+(this.terminals_[symbol] || symbol)+"'"));
                }
                this.parseError(errStr,
                    {text: this.lexer.match, token: this.terminals_[symbol] || symbol, line: this.lexer.yylineno, loc: yyloc, expected: expected});
            }

            // just recovered from another error
            if (recovering == 3) {
                if (symbol == EOF) {
                    throw new Error(errStr || 'Parsing halted.');
                }

                // discard current lookahead and grab another
                yyleng = this.lexer.yyleng;
                yytext = this.lexer.yytext;
                yylineno = this.lexer.yylineno;
                yyloc = this.lexer.yylloc;
                symbol = lex();
            }

            // try to recover from error
            while (1) {
                // check for error recovery rule in this state
                if ((TERROR.toString()) in table[state]) {
                    break;
                }
                if (state == 0) {
                    throw new Error(errStr || 'Parsing halted.');
                }
                popStack(1);
                state = stack[stack.length-1];
            }

            preErrorSymbol = symbol; // save the lookahead token
            symbol = TERROR;         // insert generic error symbol as new lookahead
            state = stack[stack.length-1];
            action = table[state] && table[state][TERROR];
            recovering = 3; // allow 3 real symbols to be shifted before reporting a new error
        }

        // this shouldn't happen, unless resolve defaults are off
        if (action[0] instanceof Array && action.length > 1) {
            throw new Error('Parse Error: multiple actions possible at state: '+state+', token: '+symbol);
        }

        switch (action[0]) {

            case 1: // shift
                //this.shiftCount++;

                stack.push(symbol);
                vstack.push(this.lexer.yytext);
                lstack.push(this.lexer.yylloc);
                stack.push(action[1]); // push state
                symbol = null;
                if (!preErrorSymbol) { // normal execution/no error
                    yyleng = this.lexer.yyleng;
                    yytext = this.lexer.yytext;
                    yylineno = this.lexer.yylineno;
                    yyloc = this.lexer.yylloc;
                    if (recovering > 0)
                        recovering--;
                } else { // error just occurred, resume old lookahead f/ before error
                    symbol = preErrorSymbol;
                    preErrorSymbol = null;
                }
                break;

            case 2: // reduce
                //this.reductionCount++;

                len = this.productions_[action[1]][1];

                // perform semantic action
                yyval.$ = vstack[vstack.length-len]; // default to $$ = $1
                // default location, uses first token for firsts, last for lasts
                yyval._$ = {
                    first_line: lstack[lstack.length-(len||1)].first_line,
                    last_line: lstack[lstack.length-1].last_line,
                    first_column: lstack[lstack.length-(len||1)].first_column,
                    last_column: lstack[lstack.length-1].last_column
                };
                r = this.performAction.call(yyval, yytext, yyleng, yylineno, this.yy, action[1], vstack, lstack);

                if (typeof r !== 'undefined') {
                    return r;
                }

                // pop off stack
                if (len) {
                    stack = stack.slice(0,-1*len*2);
                    vstack = vstack.slice(0, -1*len);
                    lstack = lstack.slice(0, -1*len);
                }

                stack.push(this.productions_[action[1]][0]);    // push nonterminal (reduce)
                vstack.push(yyval.$);
                lstack.push(yyval._$);
                // goto new state = table[STATE][NONTERMINAL]
                newState = table[stack[stack.length-2]][stack[stack.length-1]];
                stack.push(newState);
                break;

            case 3: // accept
                return true;
        }

    }

    return true;
}};
/* Jison generated lexer */
var lexer = (function(){
var lexer = ({EOF:1,
parseError:function parseError(str, hash) {
        if (this.yy.parseError) {
            this.yy.parseError(str, hash);
        } else {
            throw new Error(str);
        }
    },
setInput:function (input) {
        this._input = input;
        this._more = this._less = this.done = false;
        this.yylineno = this.yyleng = 0;
        this.yytext = this.matched = this.match = '';
        this.conditionStack = ['INITIAL'];
        this.yylloc = {first_line:1,first_column:0,last_line:1,last_column:0};
        return this;
    },
input:function () {
        var ch = this._input[0];
        this.yytext+=ch;
        this.yyleng++;
        this.match+=ch;
        this.matched+=ch;
        var lines = ch.match(/\n/);
        if (lines) this.yylineno++;
        this._input = this._input.slice(1);
        return ch;
    },
unput:function (ch) {
        this._input = ch + this._input;
        return this;
    },
more:function () {
        this._more = true;
        return this;
    },
less:function (n) {
        this._input = this.match.slice(n) + this._input;
    },
pastInput:function () {
        var past = this.matched.substr(0, this.matched.length - this.match.length);
        return (past.length > 20 ? '...':'') + past.substr(-20).replace(/\n/g, "");
    },
upcomingInput:function () {
        var next = this.match;
        if (next.length < 20) {
            next += this._input.substr(0, 20-next.length);
        }
        return (next.substr(0,20)+(next.length > 20 ? '...':'')).replace(/\n/g, "");
    },
showPosition:function () {
        var pre = this.pastInput();
        var c = new Array(pre.length + 1).join("-");
        return pre + this.upcomingInput() + "\n" + c+"^";
    },
next:function () {
        if (this.done) {
            return this.EOF;
        }
        if (!this._input) this.done = true;

        var token,
            match,
            tempMatch,
            index,
            col,
            lines;
        if (!this._more) {
            this.yytext = '';
            this.match = '';
        }
        var rules = this._currentRules();
        for (var i=0;i < rules.length; i++) {
            tempMatch = this._input.match(this.rules[rules[i]]);
            if (tempMatch && (!match || tempMatch[0].length > match[0].length)) {
                match = tempMatch;
                index = i;
                if (!this.options.flex) break;
            }
        }
        if (match) {
            lines = match[0].match(/\n.*/g);
            if (lines) this.yylineno += lines.length;
            this.yylloc = {first_line: this.yylloc.last_line,
                           last_line: this.yylineno+1,
                           first_column: this.yylloc.last_column,
                           last_column: lines ? lines[lines.length-1].length-1 : this.yylloc.last_column + match[0].length}
            this.yytext += match[0];
            this.match += match[0];
            this.yyleng = this.yytext.length;
            this._more = false;
            this._input = this._input.slice(match[0].length);
            this.matched += match[0];
            token = this.performAction.call(this, this.yy, this, rules[index],this.conditionStack[this.conditionStack.length-1]);
            if (this.done && this._input) this.done = false;
            if (token) return token;
            else return;
        }
        if (this._input === "") {
            return this.EOF;
        } else {
            this.parseError('Lexical error on line '+(this.yylineno+1)+'. Unrecognized text.\n'+this.showPosition(), 
                    {text: "", token: null, line: this.yylineno});
        }
    },
lex:function lex() {
        var r = this.next();
        if (typeof r !== 'undefined') {
            return r;
        } else {
            return this.lex();
        }
    },
begin:function begin(condition) {
        this.conditionStack.push(condition);
    },
popState:function popState() {
        return this.conditionStack.pop();
    },
_currentRules:function _currentRules() {
        return this.conditions[this.conditionStack[this.conditionStack.length-1]].rules;
    },
topState:function () {
        return this.conditionStack[this.conditionStack.length-2];
    },
pushState:function begin(condition) {
        this.begin(condition);
    }});
lexer.options = {};
lexer.performAction = function anonymous(yy,yy_,$avoiding_name_collisions,YY_START) {

var YYSTATE=YY_START
switch($avoiding_name_collisions) {
case 0:/* skip whitespace */
break;
case 1:return 40
break;
case 2:return 41
break;
case 3:return 15
break;
case 4:return 38
break;
case 5:return 39
break;
case 6:return 45
break;
case 7:return 51
break;
case 8:return 46
break;
case 9:return 44
break;
case 10:return 47
break;
case 11:return 48
break;
case 12:return 49
break;
case 13:return 50
break;
case 14:return 14
break;
case 15:return 6
break;
case 16:return 7
break;
case 17:return 8
break;
case 18:return 10
break;
case 19:return 16
break;
case 20:return 17
break;
case 21:return 19
break;
case 22:return 21
break;
case 23:return 23
break;
case 24:return 25
break;
case 25:return 27
break;
case 26:return 29
break;
case 27:return 31
break;
case 28:return 32
break;
case 29:return 33
break;
case 30:return 34
break;
case 31:return 35
break;
case 32:return 36
break;
case 33:return 37
break;
case 34:return 12
break;
case 35:return 5
break;
case 36:return 'INVALID'
break;
}
};
lexer.rules = [/^\s+/,/^0x[0-9a-fA-F]{3}/,/^0x[0-9a-fA-F]{2}/,/^0x[0-9a-fA-F]/,/^V0\b/,/^V[0-9a-fA-F]/,/^DT\b/,/^K\b/,/^ST\b/,/^I\b/,/^F\b/,/^B\b/,/^\[/,/^\]/,/^,/,/^CLS\b/,/^RET\b/,/^SYS\b/,/^JP\b/,/^CALL\b/,/^LD\b/,/^ADD\b/,/^SE\b/,/^SNE\b/,/^RND\b/,/^SHR\b/,/^SHL\b/,/^SKP\b/,/^SKNP\b/,/^OR\b/,/^AND\b/,/^XOR\b/,/^SUB\b/,/^SUBN\b/,/^DRW\b/,/^$/,/^./];
lexer.conditions = {"INITIAL":{"rules":[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36],"inclusive":true}};
return lexer;})()
parser.lexer = lexer;
return parser;
});