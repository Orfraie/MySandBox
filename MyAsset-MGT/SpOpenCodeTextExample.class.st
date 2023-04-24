"
Nouvel essai pour enfin faire marcher un textPane a la ST/V, tout simple, simple , .. S I M P l E,,,.. bordel
On y arrive ,...
Avec le finder rechercher Spec2-Examples puis choisir Standalone
C'est la qu'il y a plain de PETITS exemples simples.
"
Class {
	#name : #SpOpenCodeTextExample,
	#superclass : #SpPresenter,
	#instVars : [
		'text'
	],
	#category : #'MyAsset-MGT'
}

{ #category : #examples }
SpOpenCodeTextExample class >> example [
" "
	^ self new 
		extent: 100@100 ;
		open ;
		yourself 
		

]

{ #category : #layout }
SpOpenCodeTextExample >> defaultLayout [ 

	^ SpBoxLayout newTopToBottom
		  add: text expand: false;
		  yourself
]

{ #category : #layout }
SpOpenCodeTextExample >> initialize: aText [
	text label: aText asString
]

{ #category : #accessing }
SpOpenCodeTextExample >> initializePresenters [
	text := self instantiate: SpTextPresenter .
	text
		text: 'This is a text';
		enabled: false.
]

{ #category : #updating }
SpOpenCodeTextExample >> logIt: aString [
	"
	Formate et envoi le message dans aTextMorph et dans le fichier Log 
	Add astring at the end of the text in aTextMorph and force it to be shown
	"
	| theMsg |
	theMsg := self text.
	self halt.
	theMsg := theMsg , String cr, 
		Time now printString, ' [', String space, '] ', aString.
	self text: theMsg
]

{ #category : #accessing }
SpOpenCodeTextExample >> text [ 
	^text
]

{ #category : #accessing }
SpOpenCodeTextExample >> title [ 
	 
	^'aTitle'
]
