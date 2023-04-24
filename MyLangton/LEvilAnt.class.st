Class {
	#name : #LEvilAnt,
	#superclass : #LAnt,
	#category : #MyLangton
}

{ #category : #factories }
LEvilAnt class >> antPosition: aPoint [
|evilAnt|
evilAnt := LEvilAnt new.
evilAnt position: aPoint. 
^ evilAnt
]

{ #category : #action }
LEvilAnt >> move [
	self changeAngleDirection: self moveTest.
	self moveForward
]

{ #category : #action }
LEvilAnt >> moveTest [
	self shouldTurnLeft
		ifTrue: [ ^ self degreesForRight ]
		ifFalse: [ ^ self degreesForLeft ].
]

{ #category : #action }
LEvilAnt >> moveTestDirection [
	self shouldTurnLeft
		ifTrue: [ ^ #right ]
		ifFalse: [ ^ #left].
]
