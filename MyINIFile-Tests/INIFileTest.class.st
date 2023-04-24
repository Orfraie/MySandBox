Class {
	#name : #INIFileTest,
	#superclass : #TestCase,
	#category : #'MyINIFile-Tests'
}

{ #category : #'as yet unclassified' }
INIFileTest >> testBatchAddition [
	| ini dict |
	ini := INIFile new.
	dict := Dictionary withAll: {'key1'->'val1'. 'key2'->'val2'}.
	(ini section: 'foo') addAll: dict.
	
	self assert: ((ini section: 'foo') at: 'key1') = 'val1'.
	self assert: ((ini section: 'foo') at: 'key2') = 'val2'.
]

{ #category : #'as yet unclassified' }
INIFileTest >> testComplexRead [
	| content in |
	content := '

[bar]
;comment

key1 = val1

key2 = val2
;key2 = oldvalue

;foo heading comment
[foo]
key1=    val1
key2= val with a space in it

'.

	in := INIFile readFrom: content readStream.
	self assert: ((in section: 'foo') at: 'key1') = 'val1'.
	self assert: ((in section: 'foo') at: 'key2') = 'val with a space in it'.
	self assert: ((in section: 'bar') at: 'key1') = 'val1'.
	self assert: ((in section: 'bar') at: 'key2') = 'val2'.
]

{ #category : #'as yet unclassified' }
INIFileTest >> testEmptyValueOnRead [
	| content in |
	content := '[foo]
key1 =      '.

	in := INIFile readFrom: content readStream.
	self assert: ((in section: 'foo') at: 'key1') isNil
]

{ #category : #'as yet unclassified' }
INIFileTest >> testHasSection [
	| ini section |
	ini := INIFile new.
	section := ini section: 'foo'.
	self deny: (ini includesSection: 'foo').
	section at: 'bar' put: 'baz'.
	self assert: (ini includesSection: 'foo').
	
]

{ #category : #'as yet unclassified' }
INIFileTest >> testIteration [
	| ini |
	ini := INIFile new.
	(ini section: 'foo') at: 'key1' put: 'val1'.
	(ini section: 'foo') at: 'key2' put: 'val2'.
	(ini section: 'bar') at: 'key1' put: 'val1'.
	(ini section: 'bar') at: 'key2' put: 'val2'.
	
	self assert: ini sections size = 2.
	ini sectionsDo: [:ea | self assert: ea associations size = 2].
]

{ #category : #'as yet unclassified' }
INIFileTest >> testMultipleSections [
	| stream out in |
	out := INIFile new.
	(out section: 'foo') at: 'key1' put: 'val1'.
	(out section: 'foo') at: 'key2' put: 'val2'.
	(out section: 'bar') at: 'key1' put: 'val1'.
	(out section: 'bar') at: 'key2' put: 'val2'.
	stream := WriteStream on: String new.
	out writeOn: stream.
	
	in := INIFile readFrom: stream contents readStream.
	self assert: ((in section: 'foo') at: 'key1') = 'val1'.
	self assert: ((in section: 'foo') at: 'key2') = 'val2'.
	self assert: ((in section: 'bar') at: 'key1') = 'val1'.
	self assert: ((in section: 'bar') at: 'key2') = 'val2'.
]

{ #category : #'as yet unclassified' }
INIFileTest >> testNilValueOnWrite [
	| out expected stream |
	out := INIFile new.
	(out section: 'foo') at: 'key1' put: nil.
	stream := WriteStream on: String new.
	out writeOn: stream.
	
	expected := '[foo]
key1=
'.
	
	self assert: expected = stream contents

	
]

{ #category : #'as yet unclassified' }
INIFileTest >> testSectionIsEmpty [
	| ini section |
	ini := INIFile new.
	section := ini section: 'foo'.
	self assert: section isEmpty.
	section at: 'bar' put: 'baz'.
	self deny: section isEmpty.
	
]

{ #category : #'as yet unclassified' }
INIFileTest >> testSingleSection [
	| out stream in foo |
	out := INIFile new.
	(out section: 'foo') at: 'key1' put: 'val1'.
	(out section: 'foo') at: 'key2' put: 'val2'.
	stream := WriteStream on: String new.
	out writeOn: stream.
	
	foo := (INIFile readFrom: stream contents readStream) section: 'foo'.
	self assert: (foo at: 'key1') = 'val1'.
	self assert: (foo at: 'key2') = 'val2'.
]
