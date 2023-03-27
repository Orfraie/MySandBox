Extension { #name : #Integer }

{ #category : #'*MyDice' }
Integer >> D10 [
	^ self D: 10
	
	
	
]

{ #category : #'*MyDice' }
Integer >> D12 [
	^ self D: 12
	
	
	
]

{ #category : #'*MyDice' }
Integer >> D20 [
	^ self D: 20
	
	
	
]

{ #category : #'*MyDice' }
Integer >> D4 [
	^ self D: 4
	
	
	
]

{ #category : #'*MyDice' }
Integer >> D6 [
	^ self D: 6
	
	
	
]

{ #category : #'*MyDice' }
Integer >> D: aNumber [
	"Le message D: est envoyé au receiver qui est un integer"
	| handle |
	handle := DieHandle new.
	self timesRepeat: [  handle addDie: (Die withFaces: aNumber) ].
	^ handle
	
	
]
