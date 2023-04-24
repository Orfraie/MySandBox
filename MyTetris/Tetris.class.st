"
This is a port of JTetris.java 1.0.0.

How to start:
choose new morph.../Games/Tetris

How to play:
1) using buttons
2) using keyboard:
	drop - spacebar
	move to left - left arrow
	move to right - right arrow
	rotate clockwise - up arrow
	rotate anticlockwise - down arrow
NOTE: mouse must be over Tetris
"
Class {
	#name : #Tetris,
	#superclass : #AlignmentMorph,
	#instVars : [
		'board',
		'scoreDisplay'
	],
	#category : #MyTetris
}

{ #category : #'as yet unclassified' }
Tetris class >> colors [

	^{
		Color r: 0.5 g: 0 b: 0.
		Color r: 0 g: 0.5 b: 0.
		Color r: 0 g: 0 b: 0.5.
		Color r: 0.5 g: 0.5 b: 0.
		Color r: 0.5 g: 0 b: 0.5.
		Color r: 0 g: 0.5 b: 0.5
	}

]

{ #category : #initialization }
Tetris >> buildButtonTarget: aTarget label: aLabel selector: aSelector help: aString [

	^self rowForButtons
		addMorph: (
			SimpleButtonMorph new 
				target: aTarget;
				label: aLabel;
				actionSelector: aSelector;
				borderColor: #raised;
				borderWidth: 2;
				color: color
		)


]

{ #category : #events }
Tetris >> handlesKeyboard: evt [
	^true
]

{ #category : #events }
Tetris >> handlesMouseOver: evt [
	^ true

]

{ #category : #initialization }
Tetris >> initialize [

	super initialize.
	board := TetrisBoard new game: self.
	color := Color lightGray.
	self listDirection: #topToBottom.
	self wrapCentering: #center.
	self vResizing: #shrinkWrap.
	self hResizing: #shrinkWrap.
	self layoutInset: 3.
	self 
		addMorphBack: self makeGameControls;
		addMorphBack: self makeMovementControls;
		addMorphBack: self showScoreDisplay;
		addMorphBack: board.
	board newGame.


]

{ #category : #events }
Tetris >> keyStroke: evt [

	| charValue |
	charValue := evt keyCharacter asciiValue.
	charValue = 28 ifTrue: [board moveLeft].
	charValue = 29 ifTrue: [board moveRight].
	charValue = 30 ifTrue: [board rotateClockWise].
	charValue = 31 ifTrue: [board rotateAntiClockWise].
	charValue = 32 ifTrue: [board dropAllTheWay].

]

{ #category : #initialization }
Tetris >> makeGameControls [

	^self rowForButtons
		addMorph:
			(self
				buildButtonTarget: self
				label: 'Quit'
				selector: #delete
				help: 'quit');
		addMorph:
			(self
				buildButtonTarget: board
				label: 'Pause'
				selector: #pause
				help: 'pause');
		addMorph:
			(self
				buildButtonTarget: board
				label: 'New game'
				selector: #newGame
				help: 'new game')
]

{ #category : #initialization }
Tetris >> makeMovementControls [

	^self rowForButtons
		addMorph:
			(self
				buildButtonTarget: board
				label: '->'
				selector: #moveRight
				help: 'move to the right');
		addMorph:
			(self
				buildButtonTarget: board
				label: ' ) '
				selector: #rotateClockWise
				help: 'rotate clockwise');
		addMorph:
			(self
				buildButtonTarget: board
				label: ' | '
				selector: #dropAllTheWay
				help: 'drop');
		addMorph:
			(self
				buildButtonTarget: board
				label: ' ( '
				selector: #rotateAntiClockWise
				help: 'rotate anticlockwise');
		addMorph:
			(self
				buildButtonTarget: board
				label: '<-'
				selector: #moveLeft
				help: 'move to the left')
]

{ #category : #events }
Tetris >> mouseEnter: evt [
        evt hand newKeyboardFocus: self
]

{ #category : #initialization }
Tetris >> rowForButtons [

	^AlignmentMorph newRow
		color: color;
		borderWidth: 0;
		layoutInset: 3;
		vResizing: #shrinkWrap;
		wrapCentering: #center

]

{ #category : #events }
Tetris >> score: anInteger [

	scoreDisplay value: anInteger
]

{ #category : #initialization }
Tetris >> showScoreDisplay [

	^ self rowForButtons
		hResizing: #shrinkWrap;
		addMorph: (self wrapPanel: ((scoreDisplay := LedMorph new) digits: 5; extent: (4*10@15)) 
						label: 'Score:')

]

{ #category : #initialization }
Tetris >> wrapPanel: anLedPanel label: aLabel [
	"wrap an LED panel in an alignmentMorph with a label to its left"

	^self rowForButtons
		color: color lighter;
		addMorph: anLedPanel;
		addMorph: (StringMorph contents: aLabel)

]
