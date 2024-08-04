Class {
	#name : #ViewDB,
	#superclass : #Object,
	#instVars : [
		'list',
		'selectedItemInList'
	],
	#category : #'MyAsset-MGT'
}

{ #category : #'accessing - view' }
ViewDB >> idleAction [
	"comment stating purpose of message"

	| |
	Transcript show: 'idleAction == Rien a faire.' ;cr. 
	^self
]

{ #category : #'as yet unclassified' }
ViewDB >> initializeLlist [ 
	""

list := (Transcript class withAllSubclasses collect: [:each | each name])
	asSortedCollection: [:a :b | a < b].
	selectedItemInList  := 1 .

Transcript nextPutAll: '-InitializeList selectedItemInList is ' ; nextPutAll: selectedItemInList  printString ; cr ; endEntry.
]

{ #category : #'as yet unclassified' }
ViewDB >> list [ 	
	" Ici on retourne la liste  "
	^list 
]

{ #category : #accessing }
ViewDB >> listIndex [
	"comment stating purpose of message"

	| |
	Transcript nextPutAll: '-ListIndex selectedItemInList is ';nextPutAll: selectedItemInList printString ;nextPutAll:' sizeList is ' ;nextPutAll: ( list size ) printString ; cr.
	^selectedItemInList  
]

{ #category : #'as yet unclassified' }
ViewDB >> listIndex: anInteger [
	"comment stating purpose of message"

	||
	Transcript nextPutAll: '-listIndex: ' ; nextPutAll: selectedItemInList printString ; cr.
	selectedItemInList  := anInteger.
	self changed: #listIndex.
]

{ #category : #'as yet unclassified' }
ViewDB >> listMenu: aMenu [
" yes , a menu "
| targetClass differentMenu className dummyUnusedValue yesAnOther |
className := list at: selectedItemInList 
	ifAbsent: [^aMenu add: 'rien n''est sectionne' target: self selector: #beep].
targetClass := Smalltalk at: className
	ifAbsent: [^aMenu add: 'Cette classe n''existe plus' target: self selector: #beep].
differentMenu := MenuMorph new.
differentMenu
	add: 'browse'	
	target: targetClass
	selector: #browse;
	
	add: 'inspect'
	target: targetClass
	selector: #inspect;
	
	add: 'explore'
	target: targetClass
	selector: #explore.
	
^differentMenu
]

{ #category : #'as yet unclassified' }
ViewDB >> openView [

"
ViewDB new openView
"

| window aListMorph |
self initializeLlist.
aListMorph := PluggableListMorph
	on: self
	list: #list
	selected: #listIndex
	changeSelected: #listIndex:
	menu: #listMenu:.
aListMorph color: Color white.
window := SystemWindow labelled: 'AssetDB with a collection'.
window color: Color blue ;
addMorph: aListMorph frame: (0 @ 0 corner: 1 @ 1).
^window openInWorld "Extent: 380 @ 120"

]
