Class {
	#name : #LDummyAntTest,
	#superclass : #TestCase,
	#instVars : [
		'ant',
		'board'
	],
	#category : #MyLangton
}

{ #category : #running }
LDummyAntTest >> setUp [

ant := LDummyAnt antPosition: 5@5.
board := LBoard new
]

{ #category : #tests }
LDummyAntTest >> testCreation [

self assert: ant position equals: ant defaultPosition.
self assert: ant angleDirection equals: ant defaultAngleDirection
]

{ #category : #tests }
LDummyAntTest >> testMove [

|oldPosition newPosition oldAngle newAngle|
oldPosition := ant position.
oldAngle := ant angleDirection.
ant move.
newPosition := ant position.
newAngle := ant angleDirection.

self assert: newPosition equals: oldPosition + ant deltaPoint.
self assert: newAngle equals: oldAngle + ant moveTest.
self assert: ant moveTestDirection equals: #left.
self assert: ant degreesForBack equals: 180
]
