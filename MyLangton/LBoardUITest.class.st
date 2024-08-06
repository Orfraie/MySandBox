Class {
	#name : 'LBoardUITest',
	#superclass : 'TestCase',
	#instVars : [
		'boardUI'
	],
	#classInstVars : [
		'antUI',
		'boardUI',
		'ant'
	],
	#category : 'MyLangton',
	#package : 'MyLangton'
}

{ #category : 'running' }
LBoardUITest >> setUp [
Transcript show: 'RTView n''existe plus, il faut réécrire LBoardUI, 2024 juillet 29 ' ; cr.
super setUp.
boardUI := LBoardUI new.



]

{ #category : 'running' }
LBoardUITest >> testColorPosition [

self assert: (boardUI boardColorAtPosition: 5@5) equals: Color blue

]

{ #category : 'running' }
LBoardUITest >> testCreation [

self assert: boardUI numberOfAntUI equals: 0.
boardUI addAnt.
self assert: boardUI numberOfAntUI equals: 1.


]
