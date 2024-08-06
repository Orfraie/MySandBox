Class {
	#name : 'LAnt',
	#superclass : 'Object',
	#instVars : [
		'position',
		'angleDirection',
		'board',
		'id'
	],
	#classInstVars : [
		'position'
	],
	#category : 'MyLangton',
	#package : 'MyLangton'
}

{ #category : 'factories' }
LAnt class >> antPosition: aPoint [
|ant|
ant := LAnt new.
ant position: aPoint. 
^ ant
]

{ #category : 'accessing' }
LAnt >> angleDirection [
	"Return the angle the ant is taking"
	^ angleDirection
]

{ #category : 'accessing' }
LAnt >> board [
	"Return the board I am in"
	^ board
]

{ #category : 'accessing' }
LAnt >> board: aBoard [
	board := aBoard.
	self updateBoardWithPreviousPosition.
]

{ #category : 'testing' }
LAnt >> boardValueForLeft [
	^ self id
]

{ #category : 'testing' }
LAnt >> boardValueForRight [
	^ 0
]

{ #category : 'accessing' }
LAnt >> boardValueInFront [
	"Return the value of the board in ant position"
	^ board at: self position
]

{ #category : 'actions' }
LAnt >> changeAngleDirection: anAngle [
	angleDirection := angleDirection + anAngle
]

{ #category : 'initialization' }
LAnt >> defaultAngleDirection [
	^ 0
]

{ #category : 'initialization' }
LAnt >> defaultPosition [
	^ 5 @ 5
]

{ #category : 'actions' }
LAnt >> degreesForLeft [
	^ -90
]

{ #category : 'actions' }
LAnt >> degreesForRight [
	^ 90
]

{ #category : 'actions' }
LAnt >> deltaPoint [
	"Return a point representing the direction of the ant. For example 1 @ 0 means the ant is moving to the right"
	^ angleDirection degreeCos asInteger @ angleDirection degreeSin asInteger
]

{ #category : 'actions' }
LAnt >> id [
	^ id.
]

{ #category : 'actions' }
LAnt >> id: anInteger [.
	id := anInteger.
]

{ #category : 'initialization' }
LAnt >> initialize [
	super initialize.
	angleDirection := self defaultAngleDirection.
	position := self defaultPosition.
	self board: LBoard new.
]

{ #category : 'actions' }
LAnt >> move [
	"Make the ant move, according to the value of the board in front of me"
	self changeAngleDirection: self moveTest. 
	self moveForward.

]

{ #category : 'actions' }
LAnt >> moveForward [
	"Move the ant by a delta corresponding to the direction"
	position := ((position +self deltaPoint + (board size-(1@1))) \\ (board size))+(1@1).
	
	self updateBoardWithPreviousPosition.
]

{ #category : 'actions' }
LAnt >> moveTest [
	self shouldTurnLeft
		ifTrue: [ ^ self degreesForLeft ]
		ifFalse: [ ^ self degreesForRight ].
]

{ #category : 'actions' }
LAnt >> moveTestDirection [
	self shouldTurnLeft
		ifTrue: [ ^ #left ]
		ifFalse: [ ^ #right ].
]

{ #category : 'accessing' }
LAnt >> position [ 
	"Return the position of the ant in the board"
	^ position
]

{ #category : 'accessing' }
LAnt >> position: aPoint [
	"Return the position of the ant in the board"
	position := aPoint
]

{ #category : 'actions' }
LAnt >> previousPosition [
	| p0 p1 p2 |
	p0 := self deltaPoint.
	p1 := (position - self deltaPoint ) . 
	p2 := (board size - (1 @ 1)).
	"self halt."
	^ (position - self deltaPoint + (board size - (1 @ 1))) \\ board size + (1 @ 1)
]

{ #category : 'testing' }
LAnt >> shouldTurnLeft [
	"Return true if the board value in front of me makes me turn left"

	^ self boardValueInFront ~= self boardValueForRight
]

{ #category : 'testing' }
LAnt >> shouldTurnRight [
	"Return true if the board value in front of me makes me turn right"

	^ self boardValueInFront = self boardValueForRight
]

{ #category : 'actions' }
LAnt >> updateBoardWithPreviousPosition [
	"self halt."
	(board at: self previousPosition) = self boardValueForLeft
		ifTrue: [ board at: self previousPosition put: self boardValueForRight ]
		ifFalse: [ board at: self previousPosition put: self boardValueForLeft ].
	"Transcript show: (self position) printString; cr."
]
