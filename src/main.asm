	; ���g�p���ۂ�RAM
	; $00D0					; �^�C�}�[�p���b�g(1:���A2:��)
	; $00D1					; �^�C�}�[(�b)
	; $00D2					; �^�C�}�[(�t���[��)
	; $00D3					: �^�C���I�[�o�[�t���O
	; $00D4					: �^�C�}�[��~�t���O(�S�[���ρA����Ȃ�)
	; $00D5					: �S�[��(���[�v)���f�B���C�����p1
	; $00D6					: �S�[��(���[�v)���f�B���C�����p2
	; $00D7					: �S�[��(���[�v)���f�B���C�����p3
	; $00D8					: �t���A�ۊ�(���[�v��ɕ���)
	; $00D9					; ���̓^�C�}�[(����������)
	; $00DA					; �f�o�b�O���[�h(ROUND SELECT)���͗p
	; $00DB					: �^�C���ۊ�(���X�^�[�g���ɕ���)

	; �^�C�g���uROUND SELECT�v
	BANKORG_D $001407		; PC:$1407
	db $1B,$18,$1E,$17		; ��:$17,$18,$1B,$16
	db $0D,$24,$1C,$0E		; ��:$0A,$15,$24,$1C
	db $15,$0E,$0C,$1D		; ��:$1D,$0A,$1B,$1D
	db $24,$24,$24,$24		; ��:$24,$24,$24,$24

	; �^�C�g���uCONTINUE START�v��\��
	BANKORG_D $001420		; PC:$1420
	db $24,$24,$24,$24		; ��:$0C,$18,$17,$1D(CONT)
	db $24,$24,$24,$24		; ��:$12,$17,$1E,$0E(INUE)
	db $24,$24,$24,$24		; ��:$24,$1C,$1D,$0A( STA)
	db $24,$24,$24,$24		; ��:$1B,$1D,$24,$24(RT  )

	; �^�C�g���uTA PRACTICE EDITION�v
	BANKORG_D $001435		; PC:$1435
	db $24,$1D,$0A,$24		; ��:$24,$24,$19,$1E(  PU)
	db $19,$1B,$0A,$0C		; ��:$1C,$11,$24,$1C(SH S)
	db $1D,$12,$0C,$0E		; ��:$1D,$0A,$1B,$1D(TART)
	db $24,$0E,$0D,$12		; ��:$24,$0B,$1E,$1D( BUT)
	db $1D,$12,$18,$17		; ��:$1D,$18,$17,$24(TON )

	; �C�V�^�[��ʃX�L�b�v
	BANKORG_D $0252BB		; PC:$52BB
	db $EA,$EA				; ��:LDA <$08
	db $EA,$EA				; ��:AND #$30
	db $EA,$EA				; ��:BEQ Loc_B2C2_IshtarScreen

	; ���[�v��ʃX�L�b�v
	BANKORG_D $025579		; PC:$5579
	db $EA,$EA				; ��:LDA <$08
	db $EA,$EA				; ��:AND #$30
	db $EA,$EA				; ��:BEQ Loc_B586_WarpScreen

	; namco���S�X�L�b�v
	BANKORG_D $037F5D		; PC:$7F5D
	db $EA,$EA,$EA			; ��:JSR $FFEB

	; ���U���g��� �^�C������(�t���[���ATIME OVER)
	BANKORG_D $08B390		; PC:$11390(��̈�)
Result_Screen:
	LDA $D2
	JSR $BB01
	LDY #0
	LDX <$11
loc_BA65:
	LDA Result_FrameVram,Y
	STA <$80,X
	INX
	INY
	CPY #3
	BNE loc_BA65
	LDY #1
loc_BA72:
	LDA $00,Y
	CMP #$85
	BNE Result_NotBlank
	LDA #$60
Result_NotBlank:
	STA <$80,X
	INX
	INY
	CPY #3
	BNE loc_BA72
	STX <$11
	JSR $FFEB
	LDA <$D3
	BEQ Result_ScreenEnd
	LDY #0
	LDX <$11
Result_TimeOverLoop:
	LDA Result_TimeOverVram,Y
	STA <$80,X
	INX
	INY
	CPY #13
	BNE Result_TimeOverLoop
	STX <$11
	JSR $FFEB
	LDA #$07
	STA $0600
Result_ScreenEnd:
;	JSR $B98B
	RTS
Result_FrameVram:
	db $22,$34,$02
Result_TimeOverVram:
	db $22,$AB,$0A
	db $7D,$72,$76,$6E,$84,$78,$7F,$6E,$7B,$F9

	; �S�[��(���[�v)���f�B���C����1
	BANKORG_D $081804		; PC:$11804
	LDA <$D5				; ��:LDA #$20

	; �S�[��(���[�v)���f�B���C����2
	BANKORG_D $081833		; PC:$11833
	LDA <$D6				; ��:LDA #8

	; �S�[��(���[�v)���f�B���C����3
	BANKORG_D $081866		; PC:$11866
	LDA <$D7				; ��:LDA #0

	; ���U���g��� �{�[�i�X�^�C��(5����)
	BANKORG_D $081992		; PC:$11992
	LDA #$84				; ��:LDA #$84

	; ���U���g��� �{�[�i�X���Z�X�L�b�v
	BANKORG_D $0818E0		; PC:$118E0
	JMP $990F				; JSR $998B

	; ���U���g��� �^�C���Q�Ɛ�
	BANKORG_D $081A5C		; PC:$11A5C
	LDA <$D1				; ��:LDA <$5F

	; ���U���g��� �^�C��(�{�[�i�X)��\��
	BANKORG_D $081A27		; PC:$11A27
	CPY #39					; ��:CPY #58

	BANKORG_D $081A2D		; PC:$11A2D
	db $EA,$EA,$EA			; ��:JSR $B98B

	; ���U���g��� �^�C������(�t���[��)
	BANKORG_D $081A82		; PC:$11A82
	JSR Result_Screen		; ��:JSR $B98B

	; ���U���g��� �^�C������(�J)
	BANKORG_D $081A98		; PC:$11A98
	db $22,$14,$01,$85		; ��:$22,$14,$01,$F7

	; ���U���g��� �^�C������(�̂���^�C���F�@�@�@�Ђ傤)
	BANKORG_D $081A9C		; PC:$11A9C
	db $22,$29,$0E,$8F		; ��:$22,$29,$0E,$D8
	db $AF,$88,$97,$89		; ��:$C9,$E7,$97,$89
	db $A8,$FE,$84,$84		; ��:$A8,$FE,$84,$84
	db $84,$FA,$84,$84		; ��:$84,$84,$DA,$F6
	db $84					; ��:$C2

	; �c�@�������Ȃ�
	BANKORG_D $081C5F		; PC:$11C5F
	db $EA,$EA				; ��:DEC <$52

	; Level���ɖ��t���[�����s
	BANKORG_D $0EC1ED		; PC:$1C1ED
	db $EA,$EA,$EA			; ��:LDA $017F
	db $EA,$EA				; ��:BEQ loc_C1F5
	JSR LevelFrameASM		; ��:JSR $D7A6

	; �����f�o�b�O���[�h(ROUND SELECT)
	BANKORG_D $0EC2FF		; PC:$1C2FF
DebugMode:
	LDA $0147				; ��:BEQ loc_C32C
	BEQ NotWarpGoal			; ��:LDA <$08
	LDA $0503				; ��:AND #$C0
	STA $0144				; ��:CMP #$C0
NotWarpGoal:				; ��:BNE loc_C32C
	db $EA,$EA				; ��:LDA #1
	db $EA,$EA,$EA			; ��:STA $017F

	; Level����ʃX�L�b�v
	BANKORG_D $0EDC2D		; PC:$1DC2D
	JSR ScreenTransition	; ��:JSR $C1B4

	BANKORG_D $0EDC38		; PC:$1DC38
	JSR ScreenTransition	; ��:JSR $C1B4

	BANKORG_D $0EDC40		; PC:$1DC40
	JSR ScreenTransition	; ��:JSR $C1B4

	; �S�[����ROUND SELECT�ɖ߂�
	BANKORG_D $0EC499		; PC:$1C499
	JMP $C4FE				; JMP Loc_C54D_BadEnding

	BANKORG_D $0EC519		; PC:$1C574
	JMP DebugMode			; ��:JMP Loc_C4FE_Goal

	; 100�K�N���A���1�K�ɖ߂�
	BANKORG_D $0EC564		; PC:$1C564
	LDA #$00				; ��:LDA #$1E
	STA $0144				; ��:STA <$58
	JMP DebugMode			; ��:JSR $C577

	; ���[�v��ROUND SELECT�ɖ߂�
	BANKORG_D $0EC535		; PC:$1C535
	JSR WarpScreenSkip		; ��:JSR Sub_C663

	BANKORG_D $0EC54A		; PC:$1C54A
	JMP $C50F				; ��:JMP Loc_C345_NormalGoal

	BANKORG_D $0EC4D2		; PC:$1C4D2
loc_C4D2:					; �^�C���A�b�v����
	LDA #$FF				; ��:LDA #$FF
	STA <$D3				; ��:STA <$51

	; �f�o�b�O���[�h(ROUND SELECT) ���͉��P
	BANKORG_D $0ED71E		; PC:$1D71E
	JSR DebugImprove		; ��:JSR $C1B4
	LDA <$DA				; ��:LDA <$0B

	; CONTINUE START�I��s��
	BANKORG_D $0ED920		; PC:$1D920
	RTS						; ��:LDA <$67

	; �̂���̃J�C(�c�@)��\��
	BANKORG_D $0ED9A0		; PC:$1D9A0
	RTS						; ��:LDX <$11

	; ��e�G���������Ȃ�
	BANKORG_D $0EDCCC		; PC:$1DCCC
	db $EA
	LDA #$00				; ��:LDA $F6,X

	; �u�^�C���v��\��
	BANKORG_D $0EDD30		; PC:$1DD30
loc_DD30:
	JSR FrameTileUpdate_Lvl	; ��:LDA $DD20,Y
	db $EA,$EA,$EA			; ��:STA $700,X
	db $EA					; ��:INX
	db $EA					; ��:INY
	db $EA,$EA				; ��:CPY #12
	db $EA,$EA				; ��:BNE loc_DD30

	; �^�C��(�b)�X�v���C�g X���W
	BANKORG_D $0EDD5C		; PC:$1DD5C
	LDA #$C0				; ��:#$D8

	; �^�C��(�b)�X�v���C�g Y���W
	BANKORG_D $0EDD69		; PC:$1DD69
	LDA #$18				; ��:#$22

	; �^�C��(�b)�X�v���C�g ����
	BANKORG_D $0EDD6E		; PC:$1DD6E
	LDA <$D0				; ��:#2

	; �^�C��(�b)�X�v���C�g �^�C���Q�Ɛ�
	BANKORG_D $0EDD97		; PC:$1DD97
	LDA <$D1				; ��:$5F
	db $EA,$EA				; ��:CMP #$FF
	db $EA,$EA				; ��:BNE loc_DD9E
	db $EA					; ��:RTS

	; �^�C��(�b)�̏����l��0�ɕύX
	BANKORG_D $0EDDB9		; PC:$1DDB9
	JSR LevelInit			; ��:JSR $C698

	; �A�C�e���擾
	BANKORG_D $0FE903		; PC:$1E903
	JSR ItemGet				; ��:INC $2C0,X

	; �t���[��('xx)�\��
	BANKORG_D $0FFDA0		; PC:$1FDA0(��̈�)
FrameTileUpdate_Lvl:
	LDA <$D4
	BNE NotCountSec
	LDA <$54
	STA <$D4
	INC <$D2				; �J�E���g(�t���[��) ���Z
	LDA <$D2
	CMP #61
	BNE NotCountSec
	LDA #0
	STA <$D2				; �J�E���g(�t���[��) ������
	INC <$D1				; �J�E���g(�b) ���Z
	LDA <$D1
	CMP #$FF
	BNE NotCountSec
	INC <$D4
NotCountSec:
	LDY $0144
	LDX #2
	LDA <$D3
	BEQ NotTimeOver
	DEX						; �^�C���̃p���b�g�ύX(���ˉ�)
	LDA #0
	STA $5F
	STA $64
NotTimeOver:
	STX <$D0

	LDA #0
	STA <$00
	STA <$01
	STA <$02
	LDA <$D2
	JSR $DD99

	LDX #12
	LDA #$10
	STA $0700,X
	LDA #$9A
	STA $0701,X
	LDA <$D0
	STA $0702,X
	LDA #$D8
	STA $0703,X

	LDA <$01
	BNE loc_DD4F
	LDA #$00
	STA <$01
loc_DD4F:
	CLC
	ROL <$00
	CLC
	ROL <$01
	LDX #1
	LDY #$10
	LDA #$E0
	STA <$05
loc_DD60:
	LDA <$00,X
	BMI loc_DD85
	ORA #$80
	STA $0701,Y				; Sprite.Tile
	LDA #$18
	STA $0700,Y				; Sprite.Y
	LDA <$D0
	STA $0702,Y				; Sprite.Attribute
	LDA <$05
	STA $0703,Y				; Sprite.X
loc_DD78:
	CLC
	ADC #8
	STA <$05
	INY
	INY
	INY
	INY
	DEX
	BPL loc_DD60
	RTS

loc_DD85:
	LDA #$00
	STA $0700,Y
	LDA <$05
	JMP loc_DD78

LevelInit:
	JSR $C698				; ������
	LDA #0
	STA <$59
	STA <$D0
	STA <$D1
	STA <$D2
	STA <$D3
	STA <$D4
	STA <$D9
	LDA #$20
	STA <$D5
	LDA #8
	STA <$D6
	LDA #0
	STA <$D7
	LDA $0144
	STA <$D8
	RTS

WarpScreenSkip:
	JSR $C663
	LDA #0
	STA <$D5
	STA <$D6
	LDA #$0F
	STA <$D7
	LDA <$D8
	STA $0144
	RTS

ItemGet:
	LDA $0240,X
	CMP #$0F
	BNE NotWarpItem
	LDA #1
	STA <$D4
NotWarpItem:
	INC $02C0,X
	RTS

LevelFrameASM:
	LDA <$51
	BNE DeathMotionSkip		; ���S����
PauseMenu:
	LDA <$5A
	AND #$80				; �|�[�Y����
	BEQ PauseMenuEnd
	LDA <$D9
	CMP #30
	BCS ExitLevel			; �������ŗ��E
	LDA <$08
	AND #$20				; SELECT����
	BEQ NotHoldSelect
	INC <$D9
	RTS
NotHoldSelect:
	LDA <$D9
	BNE RestartLevel		; �Z�����Ń��X�^�[�g
PauseMenuEnd:
	RTS

ExitLevel:
	LDA #0
	STA $5A
	STA $0603
	JSR $DAB3				; Sprite Clear 
	LDA #$84
	STA <$02
	JSR $C5C2				; VRAM Clear
	PLA
	PLA
	PLA
	PLA
	JMP DebugMode
	RTS

DeathMotionSkip:
	LDA <$0B
	AND #$30				; START or SELECT�Ŏ��S���[�V�����X�L�b�v
	BEQ PauseMenuEnd
	LDA #0
	STA $51
	PLA
	PLA
	PLA
	PLA
	PLA
	PLA
RestartLevel:
	PLA
	PLA
	PLA
	PLA
	LDA <$DB
	STA <$5F
	JSR LevelInit
	JMP $C382
	RTS

DebugImprove:
	JSR $C1B4				; ������
	LDA <$08
	BEQ DebugImproveEnd
	LDY <$08
	LDA <$D9
	BEQ StoreInput
	CMP #20					; �������ŉ���
	BCS StoreInput
	LDY #0
StoreInput:
	STY <$DA
	INC <$D9
	LDA <$D9
	CMP #$FF
	BNE NotInputLimit
	DEC <$D9
NotInputLimit:
	RTS
DebugImproveEnd:
	LDA #0
	STA <$D9
	STA <$DA
	RTS

ScreenTransition:
	JSR $C1B4				; ������
	LDA <$5F
	STA <$DB
	LDA <$0B
	AND #$30				; START or SELECT��Level����ʃX�L�b�v
	BNE RestartLevel
	RTS