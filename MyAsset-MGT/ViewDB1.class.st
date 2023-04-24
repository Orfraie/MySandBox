Class {
	#name : #ViewDB1,
	#superclass : #Object,
	#instVars : [
		'window',
		'dict',
		'nameSelected',
		'indexSelectedInList'
	],
	#category : #'MyAsset-MGT'
}

{ #category : #adding }
ViewDB1 >> addItem [
	" Rajoute un item dans la base,..."
	||
	nameSelected := 'key-',Time now printString.
	dict at: nameSelected put: 'String-',Time now printString.
	nameSelected := nil .
	indexSelectedInList := 0.
	self changed: #listIndex.
	self changed: #list.
]

{ #category : #'exit code handling' }
ViewDB1 >> exitAction [
	"On ferme le morph puis la fenetre"

	Transcript nextPutAll: 'exitAction ==> on sort en detruisant l''IHM.' ;cr. 
	Transcript nextPutAll: 'self class = '; nextPutAll: self printString ;cr. 
	Transcript nextPutAll: 'self class dependents = ' ; nextPutAll: self dependents printString ;cr. 
	Transcript nextPutAll: 'self class dependents first = '; nextPutAll: self dependents first printString ;cr. 
	self dependents first delete. " c'est le Morph qui est dans la window "
	window delete "C'est la window."
]

{ #category : #'action handling' }
ViewDB1 >> idleAction [
	"comment stating purpose of message"

	|  |
	Transcript show: 'Attente de 1 seconde,.....' ; cr.
	( Delay forSeconds: 1 ) wait. 
	Transcript show:  'idle ne fait rien.' ; cr.
]

{ #category : #initalize }
ViewDB1 >> initializeLlist [ 
	""
dict := Dictionary new.
indexSelectedInList := 0.


]

{ #category : #list }
ViewDB1 >> list [ 	
	" "
	||
	^(dict keys asSortedCollection) 
		
]

{ #category : #list }
ViewDB1 >> listIndex [
	"comment stating purpose of message"

	||
	Transcript
		nextPutAll: '-listIndex indexSelectedInList is ' ; nextPutAll: indexSelectedInList printString;
		nextPutAll: ',  key=' ; nextPutAll: nameSelected printString ; 
		cr .
	^ indexSelectedInList 

]

{ #category : #list }
ViewDB1 >> listIndex: anInteger [
	"comment stating purpose of message"

	|  |
	indexSelectedInList  := anInteger.

	( indexSelectedInList  = 0 )
		ifFalse: [ nameSelected  := ( dict keys asSortedCollection) at: indexSelectedInList ]
		ifTrue: [ nameSelected := nil ].
	"Transcript
		nextPutAll: '  -listIndex: indexSelectedInList is ' ; 
		nextPutAll: indexSelectedInList printString ;
		nextPutAll: ',  nameSelected='; nextPutAll: nameSelected printString ;
		nextPutAll: ',  sizeList is ' ; nextPutAll: dict size printString;
		cr.
	"
	self changed: #listIndex.
]

{ #category : #menu }
ViewDB1 >> listMenu: aMenu [
	|  differentMenu  s |
"	( indexSelectedInList = 0 )
		ifFalse: [ nameSelected := dict keys asSortedCollection at: indexSelectedInList ].
	dict 
		at: nameSelected
		ifAbsent: [ ^ aMenu add: 'BUG!!!!rien n''est sectionne' target: self selector: #idleAction ].
"	Transcript
		nextPutAll: '-listMenu: indexSelectedInList is ' ;nextPutAll: indexSelectedInList printString;
		nextPutAll: ',  key=' ;nextPutAll: nameSelected printString;
		nextPutAll: ',  namedSelected is ' ; nextPutAll: nameSelected printString;
		nextPutAll: ',  sizeDict is ' ; nextPutAll: dict size printString;
		cr.
	differentMenu := MenuMorph new.
	s := dict size.
	s = 0 ifFalse: [ Transcript show: 'listMenu: false' ; cr ].
	s > 0 ifFalse: [ Transcript show: 'listMenu: true' ; cr ] .
	s > 0 ifFalse: [ 
			differentMenu
				add: 'Add' target: self selector: #addItem;
				add: 'Idle3' target: self selector: #idleAction;
				add: 'Exit' target: self selector: #exitAction;
				add: 'Import' target: self selector: #idleAction. 
				].
 
	( s > 0 and: [ nameSelected isNil not ] )
	ifTrue: [ 
			differentMenu
				add: 'Add' target: self selector: #addItem;
				add: 'Remove' target: self selector: #removeItem;
				add: 'Exit' target: self selector: #exitAction;
				add: 'Idle1' target: self selector: #idleAction;
				add: 'Idle2' target: self selector: #idleAction;
				add: 'ViewItem on Transcript' target: self selector: #viewItemOnTranscript;
				add: 'inspect' target: (dict at: nameSelected) selector: #inspect ]
	ifFalse: [ differentMenu add: 'Add' target: self selector: #addItem].
			
	^ differentMenu
]

{ #category : #loading }
ViewDB1 >> loadDict [
	"  "

	
dict := Dictionary new.
dict at: 'tt' put: Dictionary new.
"1 to: (dict size) do: [ :i | dict at: 'key-', (i printString) put: 'aString', (i printString) ]."
1 to: (dict size) do: 
	[ :i | dict at: ('key-' nextPutAll:  (i printString)) put: ('aString' nextPutAll: (i printString))].
indexSelectedInList := 1.


]

{ #category : #initializing }
ViewDB1 >> openView [

"
ViewDB1 new openView
"

| aListMorph |
self initializeLlist.  

Transcript cr ; nextPutAll: 'self is a '; nextPutAll: (self class printString ); 
nextPutAll: ' class Object is ' ; nextPutAll: (self dependents printString) ; 
nextPutAll: ', init Dict Done.'; cr .

indexSelectedInList := 0.
aListMorph := PluggableListMorph
	on: self
	list: #list
	selected: #listIndex
	changeSelected: #listIndex:
	menu: #listMenu:.
aListMorph color: Color white.
window := SystemWindow labelled: 'AssetDB with a Dictionary'.
window color: Color blue ;
addMorph: aListMorph frame: (0 @ 0 corner: 1 @ 1).
^window openInWorld extent: 380 @ 380

]

{ #category : #'add-remove' }
ViewDB1 >> removeItem [
	" remove un item dans la base,..."
	||
	dict removeKey: nameSelected ifAbsent: [].
	self changed: #listIndex.
	self changed: #list.
]

{ #category : #view }
ViewDB1 >> viewItemOnTranscript [
	"	"
	|	|
	Transcript cr ; nextPutAll: 'Viewing '; nextPutAll:  (dict at: nameSelected) printString ; cr ; endEntry  .
]
