Class {
	#name : 'LDummyAnt',
	#superclass : 'LAnt',
	#category : 'MyLangton',
	#package : 'MyLangton'
}

{ #category : 'factories' }
LDummyAnt class >> antPosition: aPoint [
|dummyAnt|
dummyAnt := LDummyAnt new.
dummyAnt position: aPoint. 
^ dummyAnt
]

{ #category : 'actions' }
LDummyAnt >> degreesForBack [
	^ 180
]

{ #category : 'actions' }
LDummyAnt >> move [
	self changeAngleDirection: self moveTest. 
	self moveForward
]

{ #category : 'actions' }
LDummyAnt >> moveTest [
	self shouldTurnLeft
		ifTrue: [ ^ self degreesForBack ]
		ifFalse: [ ^ self degreesForLeft ].
]

{ #category : 'actions' }
LDummyAnt >> moveTestDirection [
	self shouldTurnLeft
		ifTrue: [ ^ #pi]
		ifFalse: [ ^ #left ].
]
