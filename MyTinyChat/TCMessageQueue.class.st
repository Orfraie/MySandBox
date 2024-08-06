"
Queue des MSG
"
Class {
	#name : 'TCMessageQueue',
	#superclass : 'Object',
	#instVars : [
		'messages'
	],
	#category : 'MyTinyChat',
	#package : 'MyTinyChat'
}

{ #category : 'adding' }
TCMessageQueue >> add: aMessage [
	messages add: aMessage
]

{ #category : 'adding' }
TCMessageQueue >> formattedMessagesFrom: aMessageNumber [
	" ? "
	^ String streamContents: 
		[  :formattedMessagesStream | (self listFrom: aMessageNumber) 
			do: [ :m | formattedMessagesStream << m printString ]
		]

]

{ #category : 'initialization' }
TCMessageQueue >> initialize [
	super initialize.
	messages := OrderedCollection new.
]

{ #category : 'adding' }
TCMessageQueue >> listFrom: aIndex [
	^ (aIndex > 0 and: [ aIndex <= messages size])
		ifTrue: [ messages copyFrom: aIndex to: messages size ]
		ifFalse: [ #() ]
]

{ #category : 'adding' }
TCMessageQueue >> remove: anIndex [
	^ messages removeAt: anIndex.

	
]

{ #category : 'adding' }
TCMessageQueue >> reset [ 
	messages removeAll
]

{ #category : 'adding' }
TCMessageQueue >> size [
	^ messages size
]
