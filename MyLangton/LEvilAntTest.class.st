Class {
	#name : #LEvilAntTest,
	#superclass : #TestCase,
	#instVars : [
		'ant',
		'board'
	],
	#classInstVars : [
		'ant'
	],
	#category : #MyLangton
}

{ #category : #running }
LEvilAntTest >> setUp [

ant := LEvilAnt antPosition: 5@5.
board := LBoard new
]

{ #category : #tests }
LEvilAntTest >> testCreation [

self assert: ant position equals: ant defaultPosition.
self assert: ant angleDirection equals: ant defaultAngleDirection.
]

{ #category : #tests }
LEvilAntTest >> testMove [

|oldPoint newPoint oldAngle newAngle|
oldPoint := ant position.
oldAngle := ant angleDirection.
ant move.
newPoint := ant position.
newAngle := ant angleDirection.

self assert: newPoint equals: oldPoint + ant deltaPoint.
self assert: newAngle equals: oldAngle + ant moveTest.
self assert: ant moveTestDirection equals: #left.
]
