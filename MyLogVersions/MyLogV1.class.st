"
MyLogV1 new openOn: 'MyLogV1 Pane' ; 
  0 to: 9 do: [ :i| logIt: 'MyFirstLogMSG.' sens: (i asCharacter )] ; 

closeLogPaneAndLogFile .
"
Class {
	#name : #MyLogV1,
	#superclass : #TextMorph,
	#instVars : [
		'aWindow'
	],
	#classVars : [
		'aFileLog',
		'aTextMorph'
	],
	#category : #MyLogVersions
}

{ #category : #updating }
MyLogV1 >> closeLogPaneAndLogFile [
	aTextMorph delete. " c'est le Morph qui est dans la window "
	"aWindow dependents first close."
	aWindow delete. "C'est la window elle même."
	aFileLog ifNotNil: [ aFileLog close ]
]

{ #category : #updating }
MyLogV1 >> logIt: aString [
	"
	Formate et envoi le message dans aTextMorph et dans le fichier Log
	Add astring at the end of the text in aTextMorph and force it to be shown
	"
	| theMsg |
	theMsg := aTextMorph  contents, String cr, 
		Time now printString, ' [', String space, '] ', aString.
	aTextMorph  contents: theMsg.
	aTextMorph refreshWorld 
]

{ #category : #updating }
MyLogV1 >> logIt: aString sens: aStartChar [
	"
	Formate et envoi le message dans aTextMorph et dans le fichier Log
	Add astring at the end of the text in aTextMorph and force it to be shown
	"
	| theMsg |
	theMsg := aTextMorph  contents, String cr, 
		Time now printString, ' [', aStartChar  asString, '] ', aString.
	aTextMorph  contents: theMsg .
	aTextMorph refreshWorld
	
]

{ #category : #'instance creation' }
MyLogV1 >> openOn: aTitle [
	"On cree la fenetre,..."
	|  |
	aTextMorph := TextMorph new.
	"wrapFlags provoque le retour a la ligne apres la largeur width (en caracteres)"
	aTextMorph wrapFlag: true.
	aTextMorph width: 400.
	aTextMorph height: 800.
	"aTextMorph color: Color white.
	aTextMorph backgroundColor: Color lightBlue. "
	aWindow := aTextMorph openInWindowLabeled: aTitle.
	self logIt: 'Start.' sens: $0.
]
