Class {
	#name : #LAntBoardTest,
	#superclass : #TestCase,
	#instVars : [
		'board',
		'ant'
	],
	#category : #MyLangton
}

{ #category : #running }
LAntBoardTest >> setUp [

	ant := LAnt new.
	board := LBoard new.
	board addAnt: ant
]

{ #category : #tests }
LAntBoardTest >> testAnt [
	self assert: ant board equals: board
]

{ #category : #tests }
LAntBoardTest >> testAntAndBoardValue [

	self assert: (board at: ant position) equals: 0
]

{ #category : #tests }
LAntBoardTest >> testAntMove [

	| caseInFront |
	self assert: ant position equals: 5 @ 5.
	caseInFront := ant boardValueInFront.
	self assert: caseInFront equals: 0.
	self assert: ant shouldTurnRight.
	self deny: ant shouldTurnLeft.
]

{ #category : #tests }
LAntBoardTest >> testCreation [

	self assert: LBoard new numberOfAnts equals: 0.
	self assert: board numberOfAnts equals: 1
]
