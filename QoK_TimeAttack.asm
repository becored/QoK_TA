	.inesprg $08 ; �v���O�����o���N��
	.ineschr $08 ; �L�����N�^�o���N��
	.inesmir 1 ;

	.inesmap 4;

	.bank 0
	.org $0000

	.incbin  "QoK.prg"
	.include "src/mylib.asm"
	.include "src/main.asm"