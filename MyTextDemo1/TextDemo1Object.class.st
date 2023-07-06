Class {
	#name : #TextDemo1Object,
	#superclass : #Object,
	#instVars : [
		'text'
	],
	#category : #MyTextDemo1
}

{ #category : #'instance creation' }
TextDemo1Object class >> new [
	^ super new initialize.
]

{ #category : #initializing }
TextDemo1Object >> initialize [
	text := 'Edit me and press Alt+S.'.
	^ self
]

{ #category : #plugging }
TextDemo1Object >> text [
	^ text
]

{ #category : #plugging }
TextDemo1Object >> text: aString [
	text  := aString.
	^ self changed: #text.
]

{ #category : #accessing }
TextDemo1Object >> value [
	^ value.
]

{ #category : #accessing }
TextDemo1Object >> value: aString [
	value := aString.
	^ self changed: #text.
]
