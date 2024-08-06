Class {
	#name : 'BatTest',
	#superclass : 'TestCase',
	#category : 'MyBat-Tests',
	#package : 'MyBat',
	#tag : 'Tests'
}

{ #category : 'tests' }
BatTest >> testDePrintOn [
	"  deuxieme copie et deuxieme version   "
	| aCanot aDummyVariable |
	Bat initClassVariable.
	aCanot := Canot new.
	Bat logIt: (aCanot printString).
	self assert: (aCanot isMemberOf: Canot ) equals: true
]

{ #category : 'tests' }
BatTest >> testVraimentSimple [ 
	"  deuxieme copie    "
	| abat b|
	abat := Bat new.
	self assert: (abat isMemberOf: Bat ) equals: false
]
