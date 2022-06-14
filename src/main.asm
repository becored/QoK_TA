	; 未使用っぽいRAM
	; $00D0					; タイマーパレット(1:黄、2:白)
	; $00D1					; タイマー(秒)
	; $00D2					; タイマー(フレーム)
	; $00D3					: タイムオーバーフラグ
	; $00D4					: タイマー停止フラグ(ゴール済、上限など)
	; $00D5					: ゴール(ワープ)時ディレイ調整用1
	; $00D6					: ゴール(ワープ)時ディレイ調整用2
	; $00D7					: ゴール(ワープ)時ディレイ調整用3
	; $00D8					: フロア保管(ワープ後に復元)
	; $00D9					; 入力タイマー(長押し判定)
	; $00DA					; デバッグモード(ROUND SELECT)入力用
	; $00DB					: タイム保管(リスタート時に復元)

	; タイトル「ROUND SELECT」
	BANKORG_D $001407		; PC:$1407
	db $1B,$18,$1E,$17		; 元:$17,$18,$1B,$16
	db $0D,$24,$1C,$0E		; 元:$0A,$15,$24,$1C
	db $15,$0E,$0C,$1D		; 元:$1D,$0A,$1B,$1D
	db $24,$24,$24,$24		; 元:$24,$24,$24,$24

	; タイトル「CONTINUE START」非表示
	BANKORG_D $001420		; PC:$1420
	db $24,$24,$24,$24		; 元:$0C,$18,$17,$1D(CONT)
	db $24,$24,$24,$24		; 元:$12,$17,$1E,$0E(INUE)
	db $24,$24,$24,$24		; 元:$24,$1C,$1D,$0A( STA)
	db $24,$24,$24,$24		; 元:$1B,$1D,$24,$24(RT  )

	; タイトル「TA PRACTICE EDITION」
	BANKORG_D $001435		; PC:$1435
	db $24,$1D,$0A,$24		; 元:$24,$24,$19,$1E(  PU)
	db $19,$1B,$0A,$0C		; 元:$1C,$11,$24,$1C(SH S)
	db $1D,$12,$0C,$0E		; 元:$1D,$0A,$1B,$1D(TART)
	db $24,$0E,$0D,$12		; 元:$24,$0B,$1E,$1D( BUT)
	db $1D,$12,$18,$17		; 元:$1D,$18,$17,$24(TON )

	; イシター画面スキップ
	BANKORG_D $0252BB		; PC:$52BB
	db $EA,$EA				; 元:LDA <$08
	db $EA,$EA				; 元:AND #$30
	db $EA,$EA				; 元:BEQ Loc_B2C2_IshtarScreen

	; ワープ画面スキップ
	BANKORG_D $025579		; PC:$5579
	db $EA,$EA				; 元:LDA <$08
	db $EA,$EA				; 元:AND #$30
	db $EA,$EA				; 元:BEQ Loc_B586_WarpScreen

	; namcoロゴスキップ
	BANKORG_D $037F5D		; PC:$7F5D
	db $EA,$EA,$EA			; 元:JSR $FFEB

	; リザルト画面 タイル生成(フレーム、TIME OVER)
	BANKORG_D $08B390		; PC:$11390(空領域)
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

	; ゴール(ワープ)時ディレイ調整1
	BANKORG_D $081804		; PC:$11804
	LDA <$D5				; 元:LDA #$20

	; ゴール(ワープ)時ディレイ調整2
	BANKORG_D $081833		; PC:$11833
	LDA <$D6				; 元:LDA #8

	; ゴール(ワープ)時ディレイ調整3
	BANKORG_D $081866		; PC:$11866
	LDA <$D7				; 元:LDA #0

	; リザルト画面 ボーナスタイル(5桁目)
	BANKORG_D $081992		; PC:$11992
	LDA #$84				; 元:LDA #$84

	; リザルト画面 ボーナス換算スキップ
	BANKORG_D $0818E0		; PC:$118E0
	JMP $990F				; JSR $998B

	; リザルト画面 タイム参照先
	BANKORG_D $081A5C		; PC:$11A5C
	LDA <$D1				; 元:LDA <$5F

	; リザルト画面 タイル(ボーナス)非表示
	BANKORG_D $081A27		; PC:$11A27
	CPY #39					; 元:CPY #58

	BANKORG_D $081A2D		; PC:$11A2D
	db $EA,$EA,$EA			; 元:JSR $B98B

	; リザルト画面 タイル生成(フレーム)
	BANKORG_D $081A82		; PC:$11A82
	JSR Result_Screen		; 元:JSR $B98B

	; リザルト画面 タイル属性(゛)
	BANKORG_D $081A98		; PC:$11A98
	db $22,$14,$01,$85		; 元:$22,$14,$01,$F7

	; リザルト画面 タイル属性(のこりタイム：　　　ひょう)
	BANKORG_D $081A9C		; PC:$11A9C
	db $22,$29,$0E,$8F		; 元:$22,$29,$0E,$D8
	db $AF,$88,$97,$89		; 元:$C9,$E7,$97,$89
	db $A8,$FE,$84,$84		; 元:$A8,$FE,$84,$84
	db $84,$FA,$84,$84		; 元:$84,$84,$DA,$F6
	db $84					; 元:$C2

	; 残機減少しない
	BANKORG_D $081C5F		; PC:$11C5F
	db $EA,$EA				; 元:DEC <$52

	; Level中に毎フレーム実行
	BANKORG_D $0EC1ED		; PC:$1C1ED
	db $EA,$EA,$EA			; 元:LDA $017F
	db $EA,$EA				; 元:BEQ loc_C1F5
	JSR LevelFrameASM		; 元:JSR $D7A6

	; 強制デバッグモード(ROUND SELECT)
	BANKORG_D $0EC2FF		; PC:$1C2FF
DebugMode:
	LDA $0147				; 元:BEQ loc_C32C
	BEQ NotWarpGoal			; 元:LDA <$08
	LDA $0503				; 元:AND #$C0
	STA $0144				; 元:CMP #$C0
NotWarpGoal:				; 元:BNE loc_C32C
	db $EA,$EA				; 元:LDA #1
	db $EA,$EA,$EA			; 元:STA $017F

	; Level情報画面スキップ
	BANKORG_D $0EDC2D		; PC:$1DC2D
	JSR ScreenTransition	; 元:JSR $C1B4

	BANKORG_D $0EDC38		; PC:$1DC38
	JSR ScreenTransition	; 元:JSR $C1B4

	BANKORG_D $0EDC40		; PC:$1DC40
	JSR ScreenTransition	; 元:JSR $C1B4

	; ゴール後ROUND SELECTに戻す
	BANKORG_D $0EC499		; PC:$1C499
	JMP $C4FE				; JMP Loc_C54D_BadEnding

	BANKORG_D $0EC519		; PC:$1C574
	JMP DebugMode			; 元:JMP Loc_C4FE_Goal

	; 100階クリア後は1階に戻す
	BANKORG_D $0EC564		; PC:$1C564
	LDA #$00				; 元:LDA #$1E
	STA $0144				; 元:STA <$58
	JMP DebugMode			; 元:JSR $C577

	; ワープ後ROUND SELECTに戻す
	BANKORG_D $0EC535		; PC:$1C535
	JSR WarpScreenSkip		; 元:JSR Sub_C663

	BANKORG_D $0EC54A		; PC:$1C54A
	JMP $C50F				; 元:JMP Loc_C345_NormalGoal

	BANKORG_D $0EC4D2		; PC:$1C4D2
loc_C4D2:					; タイムアップ処理
	LDA #$FF				; 元:LDA #$FF
	STA <$D3				; 元:STA <$51

	; デバッグモード(ROUND SELECT) 入力改善
	BANKORG_D $0ED71E		; PC:$1D71E
	JSR DebugImprove		; 元:JSR $C1B4
	LDA <$DA				; 元:LDA <$0B

	; CONTINUE START選択不可
	BANKORG_D $0ED920		; PC:$1D920
	RTS						; 元:LDA <$67

	; のこりのカイ(残機)非表示
	BANKORG_D $0ED9A0		; PC:$1D9A0
	RTS						; 元:LDX <$11

	; 被弾敵を消去しない
	BANKORG_D $0EDCCC		; PC:$1DCCC
	db $EA
	LDA #$00				; 元:LDA $F6,X

	; 「タイム」非表示
	BANKORG_D $0EDD30		; PC:$1DD30
loc_DD30:
	JSR FrameTileUpdate_Lvl	; 元:LDA $DD20,Y
	db $EA,$EA,$EA			; 元:STA $700,X
	db $EA					; 元:INX
	db $EA					; 元:INY
	db $EA,$EA				; 元:CPY #12
	db $EA,$EA				; 元:BNE loc_DD30

	; タイム(秒)スプライト X座標
	BANKORG_D $0EDD5C		; PC:$1DD5C
	LDA #$C0				; 元:#$D8

	; タイム(秒)スプライト Y座標
	BANKORG_D $0EDD69		; PC:$1DD69
	LDA #$18				; 元:#$22

	; タイム(秒)スプライト 属性
	BANKORG_D $0EDD6E		; PC:$1DD6E
	LDA <$D0				; 元:#2

	; タイム(秒)スプライト タイム参照先
	BANKORG_D $0EDD97		; PC:$1DD97
	LDA <$D1				; 元:$5F
	db $EA,$EA				; 元:CMP #$FF
	db $EA,$EA				; 元:BNE loc_DD9E
	db $EA					; 元:RTS

	; タイム(秒)の初期値を0に変更
	BANKORG_D $0EDDB9		; PC:$1DDB9
	JSR LevelInit			; 元:JSR $C698

	; アイテム取得
	BANKORG_D $0FE903		; PC:$1E903
	JSR ItemGet				; 元:INC $2C0,X

	; フレーム('xx)表示
	BANKORG_D $0FFDA0		; PC:$1FDA0(空領域)
FrameTileUpdate_Lvl:
	LDA <$D4
	BNE NotCountSec
	LDA <$54
	STA <$D4
	INC <$D2				; カウント(フレーム) 加算
	LDA <$D2
	CMP #61
	BNE NotCountSec
	LDA #0
	STA <$D2				; カウント(フレーム) 初期化
	INC <$D1				; カウント(秒) 加算
	LDA <$D1
	CMP #$FF
	BNE NotCountSec
	INC <$D4
NotCountSec:
	LDY $0144
	LDX #2
	LDA <$D3
	BEQ NotTimeOver
	DEX						; タイムのパレット変更(白⇒黄)
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
	JSR $C698				; 元処理
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
	BNE DeathMotionSkip		; 死亡判定
PauseMenu:
	LDA <$5A
	AND #$80				; ポーズ判定
	BEQ PauseMenuEnd
	LDA <$D9
	CMP #30
	BCS ExitLevel			; 長押しで離脱
	LDA <$08
	AND #$20				; SELECT判定
	BEQ NotHoldSelect
	INC <$D9
	RTS
NotHoldSelect:
	LDA <$D9
	BNE RestartLevel		; 短押しでリスタート
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
	AND #$30				; START or SELECTで死亡モーションスキップ
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
	JSR $C1B4				; 元処理
	LDA <$08
	BEQ DebugImproveEnd
	LDY <$08
	LDA <$D9
	BEQ StoreInput
	CMP #20					; 長押しで加速
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
	JSR $C1B4				; 元処理
	LDA <$5F
	STA <$DB
	LDA <$0B
	AND #$30				; START or SELECTでLevel情報画面スキップ
	BNE RestartLevel
	RTS