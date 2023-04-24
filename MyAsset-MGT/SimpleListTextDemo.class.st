Class {
	#name : #SimpleListTextDemo,
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
		'aTextMorph'
	],
	#category : #'MyAsset-MGT'
}

{ #category : #'as yet unclassified' }
SimpleListTextDemo >> add [
	" Rajoute an Object dans le dictionnaire ,..."
	||
	nameSelected := 'key-',Time now printString.
	dict at: nameSelected put: 'String-',Time now printString.
	indexSelected := 0. " deselecting any item"
	LogV1 logit: 'add' msg: 'a message from add'.
	self changed: #list.
]

{ #category : #'as yet unclassified' }
SimpleListTextDemo >> copieNameSelected [
	"retourne un text recopiant namedSelected"

	| temporary variable names |
	dict at: nameSelected ifAbsent:  [ ^'nil']. 
	^ dict at: nameSelected
	"^'Donnees bidon a logger qaund selectedName Change ' , nameSelected printString" 
]

{ #category : #'as yet unclassified' }
SimpleListTextDemo >> idle [
	"   " 
	| |
	debug ifTrue: [ Transcript show: 'idle Called et ne fait rien.' ;cr. ].
]

{ #category : #'as yet unclassified' }
SimpleListTextDemo >> initializeLDict [
	""
| indexSelectedInKeys |
dict := Dictionary new.
indexSelected := 0.
nameSelected := nil.
]

{ #category : #'as yet unclassified' }
SimpleListTextDemo >> initializeLlist [ 
	""

| selectedItemInList |
list := (Collection withAllSubclasses collect: [:each | each name])
	asSortedCollection: [:a :b | a < b].
	selectedItemInList  := 1 .
" 
list := Array new: 5.
1 to: (list size ) do: [ :i | list at: i put: (i printString)].

list := Dictionary new.
list at: 'tt' put: Dictionary new.
1 to: (dict size) do: [ :i | list at: 'key-', (i printString) put: 'aString', (i printString) ].
selectedIndex := 1.
" 
Transcript show: '-InitializeList selectedItemInList is ',selectedItemInList  printString ; cr .
"Transcript show: list printString ; cr ."
]

{ #category : #'as yet unclassified' }
SimpleListTextDemo >> list [

	debug ifTrue: [Transcript show: 'List' ; cr .].
	^dict keys asSortedCollection
]

{ #category : #'as yet unclassified' }
SimpleListTextDemo >> listIndex [
	" "

	| s |
	debug ifTrue: [
	Transcript
		show: 'ListIndex,      indexSelected is ' , indexSelected printString;
		show: ',  key=' , nameSelected printString ; cr .
	].
	^ indexSelected
]

{ #category : #'as yet unclassified' }
SimpleListTextDemo >> listIndex: anInteger [
	" "

	| t |
	indexSelected  := anInteger.

	indexSelected  = 0 
		ifFalse: [ nameSelected  := ( dict keys asSortedCollection) at: indexSelected ]
		ifTrue: [ nameSelected := nil ].
	
	debug ifTrue: [ Transcript
		show: 'ListIndex:      indexSelected is ' , indexSelected printString ;
		show: ',  nameSelected=', nameSelected printString ;
		show: ',  sizeList is ' , dict size printString;
		cr.
	].
	self changed: #listIndex.
	self changed: #copieNameSelected.

]

{ #category : #'as yet unclassified' }
SimpleListTextDemo >> listMenu: aMenu [
	| targetClass differentMenu className s |
	debug ifTrue: [ 
		Transcript
		show: 'Menu: indexSelected is ' , indexSelected printString;
		show: ',  namedSelected is ' , nameSelected printString;
		show: ',  sizeDict is ' , dict size printString;
		cr. ].
	differentMenu := MenuMorph new.		
	differentMenu add: 'Idle' target: self selector: #idle.
	differentMenu add: 'LogqqueChose' target: self selector: #logQQueChose.
	differentMenu add: 'Add' target: self selector: #add.		
	^ differentMenu	
		
		
	"
	differentMenu := MenuMorph new.
	( dict size = 0 ) ifTrue: [
		differentMenu 
		add: 'Add' target: self selector: #addItem ;
		add: 'Load' target: self selector: #load ;
		add: 'Import' target: self selector: #importPrPo.
		].
	( dict size > 0 and: [ indexSelected = 0 ]) ifTrue: [
		differentMenu 
		add: 'Add' target: self selector: #addItem ;
		add: 'Store' target: self selector: #store ;
		add: 'DeleteAll' target: self selector: #removeAllItem .
		].
	( indexSelected > 0 and: [ nameSelected notNil  ]) ifTrue: [
		differentMenu 
		add: 'Del' target: self selector: #removeItem;
		add: 'Inspect' target: ( dict at: nameSelected ) selector: #inspect.
		].
	^differentMenu 
	
	s := dict size.
	s = 0 ifFalse: [Transcript show: 'false' ].
	s > 0 ifFalse: [ Transcript show: 'true'] .
	s > 0 ifFalse: [ 
			differentMenu
				add: 'Add' target: self selector: #addItem;
				add: 'Load' target: self selector: #idleAction;
				add: 'Import' target: self selector: #idleAction. 
				].
 
	( s > 0 and: [ nameSelected isNil not ] )
	ifTrue: [ 
			differentMenu
				add: 'Add' target: self selector: #addItem;
				add: 'Remove' target: self selector: #removeItem;
				add: 'Load' target: self selector: #idleAction;
				add: 'Save' target: self selector: #idleAction;
				add: 'ViewItem on Transcript' target: self selector: #viewItemOnTranscript;
				add: 'explore' target: nameSelected selector: #explore;
				add: 'inspect' target: (dict at: nameSelected) selector: #inspect ]
	ifFalse: [ differentMenu add: 'Add' target: self selector: #addItem].
			
	^ differentMenu
	"
]

{ #category : #logging }
SimpleListTextDemo >> logQQueChose [
	"retourne un text recopiant namedSelected "

	|  |
	debug ifTrue: [Transcript show: ( 'LogQQueChose , ', Time now printString, ' ,nameSelected = ' , nameSelected printString) ; cr . ].
	^Time now printString, ' ,nameSelected = ' , nameSelected printString
]

{ #category : #initialize }
SimpleListTextDemo >> openView [
"
SimpleListTextDemo new openView
"

|  |
debug := true.
self initializeLDict.  
Transcript show: 'Init dict done, debug is ', debug printString; cr . 

indexSelected := 0.
aListMorph := PluggableListMorph
	on: self
	list: #list
	selected: #listIndex
	changeSelected: #listIndex:
	menu: #listMenu:.

" le logging, un peu particulier "
LogV1 reset ; init. 
window := SystemWindow labelled: 'SimpleListTextDemo with a simple Dictionary  based on <Key|IntegerValue>'.
window color: Color blue ;
	addMorph: aListMorph frame: (0 @ 0 extent: 0.2 @ 1) ;
	addMorph: ( LogV1 aTM )  frame: ( 0.2@0.4 extent: 0.8@0.6).
^window openInWorld extent: 800 @ 200
]
