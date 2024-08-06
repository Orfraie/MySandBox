Class {
	#name : 'LManyAntsBoardTest',
	#superclass : 'TestCase',
	#instVars : [
		'board',
		'ant'
	],
	#category : 'MyLangton',
	#package : 'MyLangton'
}

{ #category : 'as yet unclassified' }
LManyAntsBoardTest >> setUp [

super setUp.
ant := LAnt new.
board := LBoard new. 
board addAnt: ant. 
]

{ #category : 'as yet unclassified' }
LManyAntsBoardTest >> testAddAnt [

|newAnt|
newAnt := LAnt new.
board addAnt: newAnt. 
self assert: board numberOfAnts equals: 2.
self assert: (board ants at: 2) equals: newAnt.
self assert: (board ants at: 1) equals: ant.
]

{ #category : 'as yet unclassified' }
LManyAntsBoardTest >> testAntIndex [
| tmpAnt index |
1 to: 4 do: [ : i | board addAnt: (LAnt antPosition: (10 atRandom @ 10 atRandom ))].
self assert: board numberOfAnts equals: 5.
index := 3.
tmpAnt := board ants at: index.
self assert: (tmpAnt id) equals: index.
self assert: tmpAnt boardValueForLeft equals: (tmpAnt id)


]

{ #category : 'as yet unclassified' }
LManyAntsBoardTest >> testCreation [

self assert: ant board equals: board
]
