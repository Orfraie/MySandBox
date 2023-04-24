Class {
	#name : #LogV1,
	#superclass : #Object,
	#classVars : [
		'aTextMorph',
		'debugLevel',
		'rootLogFileName',
		'text'
	],
	#category : #MyLogVersions
}

{ #category : #accessing }
LogV1 class >> aTM [
	^TextMorph new.
]

{ #category : #'class initialization' }
LogV1 class >> init [
	" Initialize tout ce qu'il faut pour faire tourner le logging'
	
	LogV1 reset; init .
	LogV1 logit: 'UIO' msg: Time now printString , ' , start1,...'.
	
	"
	| lf |
	debugLevel := true .
	debugLevel 
	ifTrue: [
		Transcript cr;
		show: 'INIT started, atextMorph is ', aTextMorph printString ; cr ; 
		show:  ' debugLevel is ', debugLevel printString ;cr ;
		show:  ' rootLogFileName is ', rootLogFileName printString ; cr.
	].
	
	( ( aTextMorph isNil ) and: [ debugLevel isNil and: [rootLogFileName isNil ]] )
	ifTrue: [
		rootLogFileName := 'la-',Time now asSeconds printString,'.log'.
		aTextMorph := RubScrolledTextMorph on: self text: #text accept: nil.
		""self logit: '123' string: 'blabla,...'.""
		
	].

	debugLevel 
	ifTrue: [
		Transcript cr;
		show: 'INIT ended, aTextMorph is ', aTextMorph printString ; cr ; 
		show:  ' debugLevel is ', debugLevel printString ;cr ;
		show:  ' rootLogFileName is ', rootLogFileName printString ; cr .
	].
	aTextMorph openInWorld 
		
	
]

{ #category : #updating }
LogV1 class >> logit: code msg: aMsg [
	" ca update le log pane et le fichier log avec le message en fonction du trigramme
	LogV1 reset.
	LogV1 init.
	LogV1 logit: 'UIO' msg: ' , start1,...'.
	LogV1 logit: 'UIO' msg: ' , start2,...'.
	LogV1 logit: 'UIO' msg: ' , start3,...'.
	"
	| lf s t  |
	self init.
	lf := 10 asCharacter asString.
	debugLevel  ifTrue: [
		Transcript cr;
		show: 'LOGIT started, aTextMorph is ', aTextMorph printString ; cr ; 
		show:  ' debugLevel is ', debugLevel printString ;cr ;
		show:  ' rootLogFileName is ', rootLogFileName printString ; cr ;
		show:  ' lf is ', lf printString ; cr .
		].
	"aMsg ne peut pas contenir de ; "
	"le code est un string et contient le nom simplifie de la methode generant le log"
	(code isString and: [aMsg isString ])  ifFalse: [self error: 'unsupported class for code or aMsg in logit'].
	code isString ifFalse: [self error: 'unsupported class for a code'].
	( aMsg select: [ :i | i = $; ] )  size = 0  ifFalse: [self error: 'no ; inside aMsg, thanks'].
	s := Date today yyyymmdd ,';', Time now hhmm24,';', code ,';', aMsg.
	"
	aTextMorph  appendText: s.
	aTextMorph  appendText: lf.
	"

]

{ #category : #'class initialization' }
LogV1 class >> reset [
	"comment stating purpose of message"

	| |
	aTextMorph := nil.
	rootLogFileName := nil .
	debugLevel := nil .
]

{ #category : #setting }
LogV1 class >> resetDebug [
	debugLevel := false
]

{ #category : #accessing }
LogV1 class >> text [
	^text
	
]

{ #category : #setting }
LogV1 class >> text: aString [
	| |
	text := aString.
	^self changed: #text.
	
]
