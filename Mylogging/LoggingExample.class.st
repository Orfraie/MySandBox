Class {
	#name : #LoggingExample,
	#superclass : #Object,
	#instVars : [
		'list',
		'debug',
		'dict',
		'indexSelected',
		'nameSelected',
		'logSelected',
		'window',
		'aListMorph',
		'aTextMorph',
		'aLog'
	],
	#category : #Mylogging
}

{ #category : #adding }
LoggingExample >> add [
	" Rajoute an Object dans le dictionnaire ,..."
	||
	debug ifTrue: [ aLog logit: 'aLog' msg: 'Something is added into the dict,....' ].
	nameSelected := 'key-',Time now printString.
	dict at: nameSelected put: 'String-',Time now printString.
	indexSelected := 0. " deselecting any item"
	self changed: #list.
]

{ #category : #accessing }
LoggingExample >> copieNameSelected [
	"retourne un text recopiant namedSelected"

	|  |
	dict at: nameSelected ifAbsent:  [ ^'nil']. 
	^ dict at: nameSelected

]

{ #category : #idle }
LoggingExample >> idle [
	"   " 
	| |
	aLog logit: 'aLog' msg:  'idle Called et ne fait rien.' .
]

{ #category : #initalize }
LoggingExample >> initializeLDict [
	""
|  |
dict := Dictionary new.
indexSelected := 0.
nameSelected := nil.
]

{ #category : #accessing }
LoggingExample >> list [

	debug ifTrue: [aLog logit: 'aLog' msg: 'Returning the list keys to the pane'].
	^dict keys asSortedCollection
]

{ #category : #list }
LoggingExample >> listIndex [
	" "

	| |
	debug ifTrue: [
	aLog logit: 'aLog' msg:  'ListIndex,      indexSelected is ' , indexSelected printString, ',  key=' , nameSelected printString .
	].
	^ indexSelected
]

{ #category : #list }
LoggingExample >> listIndex: anInteger [ 
	""
	|  |
	indexSelected := anInteger.
	indexSelected = 0
		ifTrue: [nameSelected := nil]
		ifFalse: [nameSelected := dict keys asSortedCollection at: indexSelected].
	debug
		ifTrue: [aLog logit: 'aLog' msg: 'ListIndex: indexSelected is ' , indexSelected printString , ',  nameSelected=' , nameSelected printString , ',  sizeList is ' , dict size printString].
	self changed: #listIndex.
	self changed: #copieNameSelected
]

{ #category : #'building-menu' }
LoggingExample >> listMenu: aMenu [
	| differentMenu  |
	debug ifTrue: [ 
		aLog logit: 'aLog' msg: 'Menu: index is ', indexSelected printString, ',  namedSelected is ' , nameSelected printString, ',   sizeDict is ' , dict size printString .
		].
	differentMenu := MenuMorph new.	
	differentMenu add: 'Add' target: self selector: #add.		
	differentMenu add: 'Idle' target: self selector: #idle.
	differentMenu add: 'LogqqueChose' target: self selector: #logQQueChose.
	^ differentMenu	
		
		
]

{ #category : #setting }
LoggingExample >> logQQueChose [
	"Active par un menu directement, ca log qque chose"
	aLog logit: 'aLog' msg: 'LogQQueChose a propos de [' , nameSelected printString,']'
]

{ #category : #initalize }
LoggingExample >> openView [
	"
	LoggingExample new openView
	"
	debug := true.
	self initializeLDict.
	"le logging, un peu particulier, on initialize et on cree une instance"
	Logging initClassVariables.
	Logging dumpLoggingClassVariables.
	aLog := Logging new.
	aLog init.
	"End of init Logging,..."
	indexSelected := 0.
	aListMorph := PluggableListMorph
				on: self
				list: #list
				selected: #listIndex
				changeSelected: #listIndex:
				menu: #listMenu:.
	aTextMorph := RubScrolledTextMorph new.
	aTextMorph setTextWith: #copieNameSelected.
	aTextMorph  extent: 300@250.
	window := SystemWindow labelled: 'LoggingExample with a simple Dictionary  based on <Key|StrValue>'.
	window
		addMorph: aListMorph
		frame: (0 @ 0 extent: 0.2 @ 1);
		
		addMorph: aLog logMorph
		frame: (0.2 @ 0.4 extent: 0.8 @ 0.6);
		
		addMorph: aTextMorph
		frame: (0.2 @ 0 extent: 0.8 @ 0.4).
	^ window openInWorld extent: 800 @ 300
]
