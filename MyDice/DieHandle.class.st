"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	dice:		<Object>


    Implementation Points
"
Class {
	#name : #DieHandle,
	#superclass : #Object,
	#instVars : [
		'dice'
	],
	#category : #MyDice
}

{ #category : #initialization }
DieHandle >> + aDieHandle [
	| handle |
	handle := DieHandle new.
	self dice do: [ :each |  handle  addDie: each ].
	aDieHandle dice do: [ :each | handle addDie: each ].
	^ handle
]

{ #category : #initialization }
DieHandle >> addDie: aDie [
	dice add: aDie
]

{ #category : #initialization }
DieHandle >> dice [
	^ dice
]

{ #category : #initialization }
DieHandle >> diceNumber [
	^ dice size
]

{ #category : #initialization }
DieHandle >> initialize [
	super initialize.
	dice :=  OrderedCollection new 
]

{ #category : #initialization }
DieHandle >> maxValue [
	| res |
	res := 0.
	dice do: [  :each | res := res + each faces ].
	^ res
]

{ #category : #initialization }
DieHandle >> roll [
	| res |
	res := 0.
	dice do: [  :each | res := res + each roll ].
	^ res
]
