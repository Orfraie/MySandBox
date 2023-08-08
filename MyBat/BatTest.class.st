Class {
	#name : #BatTest,
	#superclass : #TestCase,
	#category : #'MyBat-Tests'
}

{ #category : #tests }
BatTest >> testDePrintOn [
	"  deuxieme copie   "
	| aCanot |
	Bat initClassVariable.
	aCanot := Canot new.
	Bat logIt: (aCanot printString).
	self assert: (aCanot isMemberOf: Canot ) equals: true
]

{ #category : #tests }
BatTest >> testVraimentSimple [ 
	"  deuxieme copie   "
	| abat |
	abat := Bat new.
	self assert: (abat isMemberOf: Bat ) equals: false
]
