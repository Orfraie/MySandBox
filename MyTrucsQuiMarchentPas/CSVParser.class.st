Class {
	#name : #CSVParser,
	#superclass : #Object,
	#instVars : [
		'stream'
	],
	#classVars : [
		'separator'
	],
	#category : #MyTrucsQuiMarchentPas
}

{ #category : #'as yet unclassified' }
CSVParser class >> on: aStream [
	^ self basicNew initializeWithStream: aStream
]

{ #category : #'as yet unclassified' }
CSVParser class >> parse: aStream [
	^ (self on: aStream) rows
]

{ #category : #'as yet unclassified' }
CSVParser class >> parseString: aString [
	^ self parse: aString readStream
]

{ #category : #'as yet unclassified' }
CSVParser class >> separator [
	" retourne en francais le caractere separateur couramment selectionn‚àö¬©"
	| |
	separator = $; ifTrue: [ ^'semi-colon' ].
	separator = $, ifTrue: [ ^'colon'].
	^'Unknown' 
]

{ #category : #'as yet unclassified' }
CSVParser class >> separator: aChar [
	separator:=aChar
]

{ #category : #'as yet unclassified' }
CSVParser >> atEndOfLine [
	^ stream atEnd or: [ ( stream peek = Character cr) or: [ (stream peek = Character lf) ]]
]

{ #category : #initialization }
CSVParser >> initializeWithStream: aStream [
	stream := aStream.
	CSVParser separator: $;.
	"Transcript nextPutAll: 'CSV separator is ' ; nextPutAll: separator printString ; cr."
]

{ #category : #'as yet unclassified' }
CSVParser >> nextInLine [
	| next |
	next := stream next.
	(next = Character cr or: [next = Character lf])
		ifTrue:	[stream skip: -1. next := nil].
	^ next
]

{ #category : #'as yet unclassified' }
CSVParser >> nextQuotedValue [
	^ String streamContents:
		[:s |
		s nextPutAll: (stream upTo: $").
		self nextInLine = $" ifTrue:
			[s nextPut: $".
			s nextPutAll: self nextQuotedValue]]
]

{ #category : #'as yet unclassified' }
CSVParser >> nextRow [
	| row |
	row := OrderedCollection new.
	stream skipSeparators.
	[self atEndOfLine]
		whileFalse: [row add: self nextValue].
	stream skip: -1.
	stream next = separator ifTrue: [row add: ''].
	^ row
]

{ #category : #'as yet unclassified' }
CSVParser >> nextValue [
	| next |
	stream peek = $" ifTrue: [stream next. ^ self nextQuotedValue].
	^ String streamContents:
		[:s |
		[(next := self nextInLine) notNil and: [next ~= separator ]]
			whileTrue: [s nextPut: next]]
]

{ #category : #'as yet unclassified' }
CSVParser >> rows [
	^ Array streamContents: [:s | self rowsDo: [:ea | s nextPut: ea]]
]

{ #category : #'as yet unclassified' }
CSVParser >> rowsDo: aBlock [
	| row |
	[stream atEnd] whileFalse:
		[row := self nextRow.
		row isEmpty ifFalse: [aBlock value: row]]
]
