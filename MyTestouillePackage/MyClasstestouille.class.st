Class {
	#name : #MyClasstestouille,
	#superclass : #Object,
	#instVars : [
		'anInteger'
	],
	#category : #MyTestouillePackage
}

{ #category : #accessing }
MyClasstestouille >> anInteger [
	" bla bla "
	^anInteger
]

{ #category : #accessing }
MyClasstestouille >> anInteger: i [
	" bla bla "
	i ifNil: [ anInteger := 100 ]
	i ifNotNil: [ anInteger := i ]
]
