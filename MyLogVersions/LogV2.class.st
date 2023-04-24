Class {
	#name : #LogV2,
	#superclass : #Object,
	#instVars : [
		'list',
		'selectedItemInList'
	],
	#category : #MyLogVersions
}

{ #category : #'as yet unclassified' }
LogV2 >> idleAction [
	"comment stating purpose of message"

	| temporary variable names |
	Transcript show: 'idleAction == Rien ‚Äö√Ñ√∂‚àö√ë‚àö‚àÇ‚Äö√†√∂‚Äö√Ñ‚Ä†‚Äö√†√∂‚Äö√†√á‚Äö√Ñ√∂‚àö√ë‚àö‚àÇ‚Äö√†√∂‚àö√´‚Äö√Ñ√∂‚àö√ë‚Äö√Ñ‚Ä† faire.' ;cr. 
]

{ #category : #'as yet unclassified' }
LogV2 >> initializeLlist [ 
	""

list := (Magnitude withAllSubclasses collect: [:each | each name])
	asSortedCollection: [:a :b | a < b].
	selectedItemInList  := 1 .

Transcript show: '-InitializeList selectedItemInList is ',selectedItemInList  printString ; cr .
]

{ #category : #'as yet unclassified' }
LogV2 >> list [ 	
	" "
	^list 
]

{ #category : #accessing }
LogV2 >> listIndex [
	"comment stating purpose of message"

	| |
	Transcript show: '-listIndex selectedItemInList is ', selectedItemInList printString ,' sizeList is ' , ( list size ) printString ; cr.
	^selectedItemInList  
]

{ #category : #'as yet unclassified' }
LogV2 >> listIndex: anInteger [
	"comment stating purpose of message"

	||
	Transcript show: '-listIndex: ',selectedItemInList printString ; cr.
	selectedItemInList  := anInteger.
	self changed: #listIndex.
]

{ #category : #'as yet unclassified' }
LogV2 >> listMenu: aMenu [
| targetClass differentMenu className |
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

{ #category : #run }
LogV2 >> openView [

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
window := SystemWindow labelled: 'LogV2 :: with PluggableListMorph'.
window color: Color blue ;
addMorph: aListMorph frame: (0 @ 0 corner: 1 @ 1).
^window openInWorld "Extent: 380 @ 120"

]
