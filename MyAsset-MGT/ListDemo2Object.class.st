Class {
	#name : #ListDemo2Object,
	#superclass : #Object,
	#instVars : [
		'collection',
		'text',
		'selection'
	],
	#category : #'MyAsset-MGT'
}

{ #category : #'instance creation' }
ListDemo2Object class >> new [
	^ super new initialize.
]

{ #category : #accessing }
ListDemo2Object >> collection [
	
	^ collection.
]

{ #category : #accessing }
ListDemo2Object >> collection: aCollection [
	" add a collection and says to list to self update"
	collection := aCollection.
	
	^ self changed: #list.
]

{ #category : #initializing }
ListDemo2Object >> initialize [

	self collection: #(
		"items in the first column"
		#('1a' '2a' '3a' '4a' '5a' '6a' '7a' '8a' '9a' '0b' '1b' '1c' '1d' '1e' '1f')
		
		"items in the second column"
		#('1a' '2a' '3a' '4a' '5a' '6a' '7a' '8a' '9a' '0b' '1b' '1c' '1d' '1e' '1f')
	).
	self selection: 2.
	^ self.
]

{ #category : #plugging }
ListDemo2Object >> list [

	^ self collection.
]

{ #category : #plugging }
ListDemo2Object >> select [
	^ self selection.
]

{ #category : #plugging }
ListDemo2Object >> select: aNumber [

	self selection: aNumber.
	Transcript show: 'user selection: ', self selection asString; cr.
	^ self.
]

{ #category : #accessing }
ListDemo2Object >> selection [
	
	^ selection
]

{ #category : #accessing }
ListDemo2Object >> selection: aNumber [
	selection := aNumber.
	^ self changed: #select.
]

{ #category : #plugging }
ListDemo2Object >> text [
	^ text
]

{ #category : #plugging }
ListDemo2Object >> text: aString [
	| |
	text := aString.
	^ self changed: #text.
]
