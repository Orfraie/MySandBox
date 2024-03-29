Class {
	#name : #Betes,
	#superclass : #Object,
	#instVars : [
		'name',
		'vivant'
	],
	#classVars : [
		'count'
	],
	#category : #MyInitExo
}

{ #category : #setting }
Betes class >> counter [ 
	""
	^ count
]

{ #category : #testing }
Betes class >> isAbstract [
		
	^ self == Betes
]

{ #category : #setting }
Betes class >> new [
	"On ne cree pas de betes, ca n''existe pas. le super new est indispensable si on a 
	des subclasses qui , elles, sont instanciables "
	self == Betes ifTrue: [ ^ self subclassResponsibility ].
	^ super new
]

{ #category : #setting }
Betes class >> plusUn [
	""
	count ifNil: [  count := 0 ].
	count := count + 1.
]

{ #category : #exemples }
Betes >> new [
	""
	self == self class ifTrue: [
		^ self error: 'Betes is an abstract class.  Make a concrete subclass.'].
	^ super new
]
