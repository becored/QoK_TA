	.inesprg $08 ; プログラムバンク数
	.ineschr $08 ; キャラクタバンク数
	.inesmir 1 ;

	.inesmap 4;

	.bank 0
	.org $0000

	.incbin  "QoK.prg"
	.include "src/mylib.asm"
	.include "src/main.asm"