Class {
	#name : #Chat,
	#superclass : #Animal,
	#instVars : [
		'joie'
	],
	#category : #MyAnimal
}

{ #category : #accessing }
Chat >> joie [
	^ joie
]

{ #category : #accessing }
Chat >> joie: aString [
	^ joie := aString
]
