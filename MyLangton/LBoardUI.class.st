Class {
	#name : #LBoardUI,
	#superclass : #Object,
	#instVars : [
		'board',
		'view',
		'antUIs',
		'colors'
	],
	#classInstVars : [
		'ants',
		'ant',
		'evilAnt',
		'board',
		'antUIs',
		'bugForm'
	],
	#category : #MyLangton
}

{ #category : #initialization }
LBoardUI >> addAnt [
|antUIElement|
	antUIElement := self createAntUI: self createAnt.
	antUIs add: antUIElement.
	self updateAntUIList.
]

{ #category : #utility }
LBoardUI >> boardColorAtPosition: position [
	^ colors  at: (board at: position) + self colorIndex.
]

{ #category : #utility }
LBoardUI >> cellShape [
	"Return the shape used to paint a cell. The color is given by the value of the board cell, a number"
	^ RTBox new
		size: self defaultCellSize;
		color: [ :position| self boardColorAtPosition: position ]
]

{ #category : #utility }
LBoardUI >> colorIndex [
	^ 1
]

{ #category : #initialization }
LBoardUI >> createAnt [
	"Adds a new LAnt element to the list and adds it to the board"
	|tempAnt|
	tempAnt := LAnt antPosition: 10 atRandom @ 10 atRandom.
	board addAnt: tempAnt.
	colors add: (Color random).
	^ tempAnt
]

{ #category : #initialization }
LBoardUI >> createAntUI: antElement [
|antUI|
	antUI := (RTBitmap new
		size: self defaultCellSize;
		form: self defaultBugForm) elementOn: antElement.
	view add: antUI.
	^ antUI
]

{ #category : #configuration }
LBoardUI >> defaultBugForm [
	^ (Form fromFileNamed: '/Users/ignaciosImaelMac/Desktop/ant.png') scaledToSize: 20 @ 20
]

{ #category : #configuration }
LBoardUI >> defaultCellSize [
	"Size of a board cell in pixels"
	^ 20
]

{ #category : #initialization }
LBoardUI >> fillBoard [
	| e shape |
	shape := self cellShape.
	1 to: board size x do: [ :x | 
		1 to: board size y do: [ :y | 
			e := shape elementOn: x @ y.
			view add: e.
			e translateTo: (x * self defaultCellSize) @ (y * self defaultCellSize) ] ]
]

{ #category : #initialization }
LBoardUI >> initialize [
	super initialize.
	self initializeBoard.
	self initializeView.
	self initializeOrderedCollections
]

{ #category : #initialization }
LBoardUI >> initializeBoard [
	board := LBoard new.

]

{ #category : #initialization }
LBoardUI >> initializeMenu [
	view addMenu: 'Inspect Board' callback: [ board inspect ].
	view addMenu: 'Add Ant' callback: [ self addAnt ]
]

{ #category : #initialization }
LBoardUI >> initializeOrderedCollections [
	antUIs := OrderedCollection new.
	colors := OrderedCollection new.
	colors add: Color blue
]

{ #category : #initialization }
LBoardUI >> initializeView [
	view := RTView new
]

{ #category : #'menu callback' }
LBoardUI >> moveAntUI: antUIElement [
	| bugForm rotatedBugForm ant|
	ant := antUIElement model.
	bugForm := antUIElement shape form value: antUIElement.
	rotatedBugForm := bugForm rotateBy: ant moveTestDirection centerAt: 0 @ 0.
	antUIElement shape form: rotatedBugForm.
	^ ant move
]

{ #category : #'menu callback' }
LBoardUI >> numberOfAntUI [
^ antUIs size
]

{ #category : #'instance creation' }
LBoardUI >> open [
	"
	self new open
	"
	self fillBoard.
	self initializeMenu.
	self setAutomaticRefresh.
	self updateAntUIList.
	^ view
]

{ #category : #'menu callback' }
LBoardUI >> setAutomaticRefresh [
|anim|
	anim := RTActiveAnimation new.
	anim intervalInMilliseconds: 500.
	anim
		blockToExecute: [ 
			antUIs do: [ :antUIElement | self moveAntUI: antUIElement].
			self updateAntUIList.
			view elements do: #update.
			view signalUpdate ].
	anim inView: view
]

{ #category : #boardUpdate }
LBoardUI >> updateAntUI: antUIElement [
	^ antUIElement translateTo: antUIElement model position * self defaultCellSize
]

{ #category : #boardUpdate }
LBoardUI >> updateAntUIList [
	"Move the ants"
	antUIs do: [ :antUIElement | self updateAntUI: antUIElement ]
]
