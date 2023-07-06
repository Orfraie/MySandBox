Class {
	#name : #Betes,
	#superclass : #Object,
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
	""
	self == self class ifTrue: [
		^ self error: 'Betes is an abstract class.  Make a concrete subclass.'].
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
