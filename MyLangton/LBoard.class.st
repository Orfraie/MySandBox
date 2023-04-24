Class {
	#name : #LBoard,
	#superclass : #Object,
	#instVars : [
		'matrix',
		'ants'
	],
	#category : #MyLangton
}

{ #category : #accessing }
LBoard >> addAnt: anAnt [
	"Add an ant to the board"
	ants add: anAnt.
	anAnt id: (self ants size).
	anAnt board: self
]

{ #category : #accessing }
LBoard >> addSomeAnts: someAnts [
	"Add a number of ants to the board"
	someAnts do: [ :ant | self addAnt: ant ]
]

{ #category : #accessing }
LBoard >> ants [
^ ants
]

{ #category : #accessing }
LBoard >> at: aPoint [
	"Return the matrix value at a given position"
	^ matrix at: aPoint x at: aPoint y
]

{ #category : #accessing }
LBoard >> at: aPoint put: aValue [
	"Set a particular value at a given position"
	^ matrix at: aPoint x at: aPoint y put: aValue
]

{ #category : #defaults }
LBoard >> defaultSize [
	"This method returns the default size of a board, ie. the matrix used underneath"
	^ 10 @ 10
]

{ #category : #initialize }
LBoard >> initialize [
	super initialize.
	self initializeMatrix.
	ants := OrderedCollection new
]

{ #category : #initialize }
LBoard >> initializeMatrix [
	"Initialize the internal matrix with 0"
	matrix := Matrix rows: self defaultSize x columns: self defaultSize y.
	matrix atAllPut: 0
]

{ #category : #accessing }
LBoard >> numberOfAnts [
	"Return the number of ants running on the board"
	^ ants size
]

{ #category : #accessing }
LBoard >> size [
	"Return a point that represent the size of the board"
	^ matrix rowCount @ matrix columnCount
]
