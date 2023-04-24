Class {
	#name : #LBoardTest,
	#superclass : #TestCase,
	#instVars : [
		'board'
	],
	#category : #MyLangton
}

{ #category : #running }
LBoardTest >> setUp [
	super setUp.
	board := LBoard new
]

{ #category : #tests }
LBoardTest >> testAnts [
|ants ant|
ants := OrderedCollection new.
ant := LAnt new.
self assert: board numberOfAnts equals: 0.
ants add: ant.
board addSomeAnts: ants.
self assert: board numberOfAnts equals: 1.
]

{ #category : #tests }
LBoardTest >> testBoardValue [
	self assert: (board at: 1 @ 1) equals: 0.
	board at: 1 @ 1 put: 1. 
	self assert: (board at: 1 @ 1) equals: 1.
	board at: 1 @ 1 put: 0.
	self assert: (board at: 1 @ 1) equals: 0.
]

{ #category : #tests }
LBoardTest >> testCreation [

	self assert: board size equals: board defaultSize.
]
