Class {
	#name : #LAntTest,
	#superclass : #TestCase,
	#instVars : [
		'ant'
	],
	#category : #MyLangton
}

{ #category : #tests }
LAntTest >> setUp [

	super setUp.
	ant := LAnt antPosition: 5@5.
]

{ #category : #tests }
LAntTest >> testChangeDirection [
	" test failed "
	| oldAngle newAngle |
	oldAngle := ant angleDirection.
	ant changeAngleDirection: 90.
	newAngle := ant angleDirection.
	
	self assert: oldAngle ~= newAngle.
	self assert: newAngle equals: 90.
]

{ #category : #tests }
LAntTest >> testChangeDirectionAndMove [

	| oldPosition deltaPoint |
	oldPosition := ant position.
	ant changeAngleDirection: 90.
	ant moveForward.
	deltaPoint := ant deltaPoint.
	
	self assert: ant angleDirection equals: 90.
	self assert: ant position equals: oldPosition + deltaPoint
]

{ #category : #tests }
LAntTest >> testCreation [
	self assert: ant position equals: ant defaultPosition.
	self assert: ant angleDirection equals: ant defaultAngleDirection 
]

{ #category : #tests }
LAntTest >> testMove [
	| oldPosition newPosition oldAngleDirection |
	oldAngleDirection := ant angleDirection.
	oldPosition := ant position.
	ant moveForward.
	newPosition := ant position.
	
	self assert: newPosition ~= oldPosition.
	self assert: ant angleDirection equals: oldAngleDirection.
	self assert: ant deltaPoint equals: 1 @ 0
]
