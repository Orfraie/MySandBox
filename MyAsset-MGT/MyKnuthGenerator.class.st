"
Running a random generator 
Based on Linear congruential method describe in Knuth 2 section 3.2
doc in file ST-V-Example-1999-lottery-ByLeavens.ps

Demo code is 

| myRandom |
MyKnuthGenerator displayMCA.
myRandom := MyKnuthGenerator new initialize.
0 to: 9 do: [ :i| Transcript show: 'I=',i printString, ' and MyRandom is ',myRandom next printString ; cr ].
"
Class {
	#name : #MyKnuthGenerator,
	#superclass : #Object,
	#instVars : [
		'seed'
	],
	#classVars : [
		'A',
		'C',
		'M'
	],
	#category : #'MyAsset-MGT'
}

{ #category : #accessing }
MyKnuthGenerator class >> displayMCA [
	Transcript show: 'MyKnuthGenerator from Knuth[2, Section 3.2]  M = ' ; show: M printString ; cr.
	Transcript show: 'MyKnuthGenerator from Knuth[2, Section 3.2]  C = ' ; show: C printString ; cr.
	Transcript show: 'MyKnuthGenerator from Knuth[2, Section 3.2]  A = ' ; show: A printString ; cr.
	Transcript show: 'MyKnuthGenerator will return a float between 0 and 1'; cr.
]

{ #category : #'instance creation' }
MyKnuthGenerator class >> new [ 
	A ifNil: 
		[ M := 2 raisedToInteger: 35.
		  C := 541. "Should be relatively prime to M"
		  A := 315159621  
		].
	^ super new initialize  
]

{ #category : #initialization }
MyKnuthGenerator >> initialize [
	self seed: 0.5714159
]

{ #category : #initialization }
MyKnuthGenerator >> next [
	"ENSURE:   result is a random floatong point number between 0 and 1"
	seed := ( A * seed +C ) rem: M.
	^ (seed / M ) asFloat
]

{ #category : #initialization }
MyKnuthGenerator >> randInteger: size [
	self error: 'this message deleted, use Uniform Discrete instead'
	
]

{ #category : #initialization }
MyKnuthGenerator >> seed: anInteger [
	seed := (1 max: anInteger)
	
]
