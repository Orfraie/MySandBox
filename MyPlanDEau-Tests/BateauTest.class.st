Class {
	#name : #BateauTest,
	#superclass : #TestCase,
	#category : #'MyPlanDEau-Tests'
}

{ #category : #tests }
BateauTest >> testBuildThreeBateaux [
 	"Creation de 3 bateaux 1/ évaluation de la taille de dicoBoat 2/Extraction des variables d'instance"
	| ba1 ba2 ba3 |
	Bateau initClassVariable .
	ba1 := Bateau new  name: 'ba1'; randomizedXYCAP .
	ba2 := Bateau new  name: 'ba2'; x: 10 ; y:10 .
	ba3 := Bateau new  name: 'ba3'.
	Transcript show: ( Bateau dicoBoatSize ) ; cr.
	self assert: ( Bateau dicoBoatSize ) equals: 3.
	" self assert: ( ba2 isMemberOf: Bateau) equals: true  "
]

{ #category : #tests }
BateauTest >> testBuildWithAName [
	""
	| ba |
	ba := Bateau new name: 'TITI'.
	self assert: ( ba isMemberOf: Bateau) equals: true.
	self assert: ( ba name = 'TITI') equals: true
]

{ #category : #tests }
BateauTest >> testBuildWithANamexy [
	""
	| ba |
	ba := Bateau new name: 'TITI' ; x: 3 ; y: 20.
	self assert: ( ba isMemberOf: Bateau) equals: true.
	self assert: ( ba name = 'TITI') equals: true.
	self assert: ( ba x = 3 ) equals: true.
	self assert: ( ba y = 20) equals: true
]

{ #category : #tests }
BateauTest >> testBuildWithANamexyWithLimit [
	""
	| ba bb |
	ba := Bateau new name: 'TITI' ; x: -1 ; y: 26.
	self assert: ( ba isMemberOf: Bateau) equals: true.
	self assert: ( ba name = 'TITI') equals: true.
	self assert: ( Bateau maxNberOfBoat = 50) equals: true.
	self assert: ( ba y = 25) equals: true.
	self assert: ( ba x = 1) equals: true.
	
	bb := Bateau new name: 'Toto' ; x: 25 ; y: 1.
	self assert: ( bb x = 25) equals: true.
	self assert: ( bb y = 1) equals: true.

]

{ #category : #tests }
BateauTest >> testInitialize [
	"Commentaire de testLePlusSimple 5"
	| ba |
	ba := Bateau new.
	ba name: 'aName' ; x: 1 ; y: 1.
	self assert: ( ba isMemberOf: Bateau) equals: true.
	self assert: ( ba name ) equals: 'aName'.
	self assert: ( Bateau maxNberOfBoat ) equals: 50.
	self assert: ( ba x = 1 ) equals: true.
	self assert: ( ba y = 1 ) equals: true.
	self assert: ( Bateau dicoBoatSize )  equals: 1.
	self assert: ( ( Bateau caps size = 8 ) and: [  (Bateau caps at: 2) = 45 ] )
]

{ #category : #tests }
BateauTest >> testLePlusSimple [
"kjolloilhkjh"
	| ba |
	ba := Bateau new.
	self assert: ( ba isMemberOf: Bateau) equals: true
]

{ #category : #tests }
BateauTest >> testinitClassVariable [
	"Test initialisation des variables de la classe Bateau"
	| |
	Bateau initClassVariable .
	self assert: ( Bateau  min = 1 ) equals: true.
	self assert: ( Bateau  max = 25) equals: true.
	self assert: ( Bateau  maxNberOfBoat = 50) equals: true.
	
]

{ #category : #tests }
BateauTest >> testmaxNberOfBoat [
	""
	|  |
	self assert: ( Bateau maxNberOfBoat ) equals: 50
]

{ #category : #tests }
BateauTest >> testrandomizedXYCAP [
	"Creation of a boat with a explicit name and all other variable randomized in their limits"
	| ba |
	ba := Bateau new name: 'TITI'.
	self assert: ( ba isMemberOf: Bateau) equals: true.
	self assert: ( ba name = 'TITI') equals: true.
	" on test que randomizedXYCAP fonctionne "
	ba randomizedXYCAP.

]
