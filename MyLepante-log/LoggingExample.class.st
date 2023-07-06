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
		'aButtonMorph',
		'aTextMorph',
		'aLog'
	],
	#category : #'MyLepante-log'
}

{ #category : #adding }
LoggingExample >> add [

	" Rajoute an Object dans le dictionnaire ,..."

	nameSelected := 'key-' , Time now printString.
	dict at: nameSelected put: 'aStringValueEqualTo-' , Time now printString.
	indexSelected := 0. " deselecting any item"
	debug ifTrue: [ 
		aLog
			logit: 'aLog'
			msg: 'New key ' , nameSelected , ' added into the dict,....' ].
	self changed: #list
]

{ #category : #'selecting text' }
LoggingExample >> copieNameSelected [

	"retourne un text recopiant namedSelected"
	| v |
	dict at: nameSelected ifAbsent: [ ^ 'nil' ].
	v := dict at: nameSelected.
	debug ifTrue: [ 
		aLog
			logit: 'aLog'
			msg: 'At key ' , nameSelected , ' finding value ',v ].
	^v
]

{ #category : #'selecting text' }
LoggingExample >> getValue [

	"retourne un text recopiant la value associée à la clé 'namedSelected'"

	| v |
	dict at: nameSelected ifAbsent: [ ^ 'nil' ].
	v := dict at: nameSelected.
	aTextMorph contents: v.
	debug ifTrue: [ 
		aLog
			logit: 'aLog'
			msg: 'getValue :: At key ' , nameSelected , ' finding value ' , v ].
	^ v
]

{ #category : #notification }
LoggingExample >> idle [

	"   "

	aLog logit: 'aLog' msg: 'idle , called et ne fait rien.'
]

{ #category : #initalize }
LoggingExample >> initializeLDict [

	""

	dict := Dictionary new.
	indexSelected := 0.
	nameSelected := nil
]

{ #category : #list }
LoggingExample >> list [

	debug ifTrue: [ 
		aLog logit: 'aLog' msg: 'list ,Returning the list keys to the aListMorph' ].
	^ dict keys asSortedCollection
]

{ #category : #list }
LoggingExample >> listIndex [

	" "

	debug ifTrue: [ 
		aLog
			logit: 'aLog'
			msg: 'ListIndex, indexSelected is ' , indexSelected printString
				, ' and the key=' , nameSelected printString ].
	^ indexSelected
]

{ #category : #update }
LoggingExample >> listIndex: anInteger [

	""

	indexSelected := anInteger.
	indexSelected = 0
		ifTrue: [ nameSelected := nil ]
		ifFalse: [ nameSelected := dict keys asSortedCollection at: indexSelected ].
	debug ifTrue: [ 
		aLog
			logit: 'aLog'
			msg: 'ListIndex: indexSelected is ' , indexSelected printString
				, ',  nameSelected=' , nameSelected printString
				, ',  sizeList is ' , dict size printString ].
	self changed: #listIndex.
	self changed: #copieNameSelected
]

{ #category : #list }
LoggingExample >> listMenu: aMenu [
	| differentMenu |
	debug ifTrue: [ 
		aLog
			logit: 'aLog'
			msg:
				'Menu: index is ' , indexSelected printString
				, ',  namedSelected is ' , nameSelected printString
				, ',   sizeDict is ' , dict size printString ].
	differentMenu := MenuMorph new.
	differentMenu add: 'Add' target: self selector: #add.
	differentMenu add: 'Idle' target: self selector: #idle.
	^ differentMenu
]

{ #category : #'as yet unclassified' }
LoggingExample >> logQQueChose [
	"Active par un menu directement, ca log qque chose"
	aLog logit: 'aLog' msg: 'LogQQueChose a propos de [' , nameSelected printString,']'
]

{ #category : #initalize }
LoggingExample >> openViewWithRubric [

	"
		LoggingExample new openViewWithRubric
	"

	| aTextMorphOLD  |
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


	aTextMorphOLD := RubPluggableTextMorph
		                 on: Workspace new
		                 text: #contents
		                 accept: #acceptContents:
		                 readSelection: nil
		                 menu: nil.
	aTextMorph := RubPluggableTextMorph
		              on: (Workspace new)
		              text: #contents
		              accept: #acceptContents:
		              readSelection: nil
		              menu: nil. "#aPaneMenu:shifted:."
	" On dit que c'est un workspace alors chacun des arguments est une méthode comprise par un workspace?"
	" Troisieme essai,... un Bide.
	aTextMorphOLD2 := RubPluggableTextMorph
		on: self
		text: #copieNameSelected
		accept: nil
		readSelection: nil
		menu: nil."
		
	aButtonMorph := PluggableButtonMorph
		                on: [ 
			                Transcript
				                show: 'Button bip onTranscript created.';
				                cr ]
		                getState: nil
		                action: #value.
	aButtonMorph label: 'Bip!!'.


	window := StandardWindow labelled:
		          'LoggingExample Written with Morph and Rubric'.
	window
		addMorph: aButtonMorph frame: (0 @ 0 extent: 0.15 @ 0.6);
		addMorph: aListMorph frame: (0.15 @ 0 extent: 0.15 @ 0.6);
		addMorph: aLog logMorph frame: (0 @ 0.6 extent: 1 @ 0.4);
		addMorph: aTextMorph frame: (0.3 @ 0 extent: 0.7 @ 0.6).
	^ window openInWorld
]

{ #category : #initalize }
LoggingExample >> openViewWithSpec2 [

	"
		LoggingExample new openViewWithSpec2
	"

	| presenter listPresenter textPresenter d l | 
	debug := true.
	self initializeLDict.

	"le logging, un peu particulier, on initialize et on cree une instance"
	Logging initClassVariables.
	Logging dumpLoggingClassVariables.
	aLog := Logging new.
	aLog init.
	"End of init Logging,..."
	
	"Pour debugger seulement et avoir a qquechose a lister,..."
	d := Dictionary  new.
	( $a to: $z ) do: [ :aChar | d at: aChar put: 'Value is ', aChar asUppercase asString ].
	l := d keys. "asSortedCollection."
	
	"On initialize les panes,..."
	presenter := SpPresenter new.
	listPresenter := presenter newList
		items: l ;
		yourself.
	textPresenter := presenter newText.
	
	"On les arrange dans le presenter,..."
	presenter layout: (SpBoxLayout newTopToBottom   " ou newLeftToRight pour presenter cote a cote"
		add: listPresenter ;
		add: textPresenter ;
		yourself).
		
	"On dit quoi faire a listPresenter quand on clique sur un item dans la liste,..."
	listPresenter transmitTo: textPresenter transform: [ :aKey | ( d at: aKey ) asString ].
	
	"On ouvre le tout dans le vaste monde,..."
	presenter open.
	
	
"
	indexSelected := 0.
	aListMorph := PluggableListMorph
		              on: self
		              list: #list
		              selected: #listIndex
		              changeSelected: #listIndex:
		              menu: #listMenu:.


	aTextMorphOLD := RubPluggableTextMorph
		                 on: Workspace new
		                 text: #contents
		                 accept: #acceptContents:
		                 readSelection: nil
		                 menu: nil.
	aTextMorph := RubPluggableTextMorph
		              on: (Workspace new)
		              text: #contents
		              accept: #acceptContents:
		              readSelection: nil
		              menu: nil. #aPaneMenu:shifted:."
	" On dit que c'est un workspace alors chacun des arguments est une méthode comprise par un workspace?"
	" Troisieme essai,... un Bide.
	aTextMorphOLD2 := RubPluggableTextMorph
		on: self
		text: #copieNameSelected
		accept: nil
		readSelection: nil
		menu: nil."
	"	
	aButtonMorph := PluggableButtonMorph
		                on: [ 
			                Transcript
				                show: 'Button bip onTranscript created.';
				                cr ]
		                getState: nil
		                action: #value.
	aButtonMorph label: 'Bip!!'.


	window := StandardWindow labelled:
		          'LoggingExample with a simple Dictionary  based on <Key|StrValue>'.
	window
		addMorph: aButtonMorph frame: (0 @ 0 extent: 0.15 @ 0.6);
		addMorph: aListMorph frame: (0.15 @ 0 extent: 0.15 @ 0.6);
		addMorph: aLog logMorph frame: (0 @ 0.6 extent: 1 @ 0.4);
		addMorph: aTextMorph frame: (0.3 @ 0 extent: 0.7 @ 0.6).
	^ window openInWorld"
]
