Class {
	#name : 'Chien',
	#superclass : 'Animal',
	#instVars : [
		'joie'
	],
	#category : 'MyAnimal',
	#package : 'MyAnimal'
}

{ #category : 'actions' }
Chien >> aboie [
	"fait aboyer le chien"
	self aboieBeaucoup
		ifTrue: [self answer: 'Wouf, wouf, wouf, wouf, bow wow']
		ifFalse: [^self answer: 'woof']
		
]

{ #category : 'actions' }
Chien >> aboieBeaucoup [
	"retourne la valeur de aboieBeaucoup"
	^aboieBeaucoup 
]

{ #category : 'initialize' }
Chien >> aboieBeaucoup: aBoolean [
	"donne une valeur a aboieBeaucoup"
	^aboieBeaucoup := aBoolean
]

{ #category : 'actions' }
Chien >> faitBruit [
	"Change le statut du chien vers un chien bruyant"
	self aboieBeaucoup: true.
	self answer: 'je vais aboyer beaucoup'
]

{ #category : 'accessing' }
Chien >> joie [
	^ joie
]

{ #category : 'actions' }
Chien >> parle [
	"faitparler le chien en  aboyant ou pas"
	self aboieBeaucoup isNil
		ifTrue: [super parle]
		ifFalse: [self aboie].
]

{ #category : 'actions' }
Chien >> silence [
	"Change le statut du chien vers un chien silencieux"
	self aboieBeaucoup: false.
	self answer: 'je n''aboierai pas beaucoup'
]
