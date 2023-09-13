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
	ba1 := Voilier name: 'ba1'.
	ba1 randomizedXYCAP .
	ba2 := Voilier new.
	ba2 x: 10.
	ba2 y: 10.
	ba3 := Voilier new.
	Transcript show: ( Bateau dicoBoatSize ) ; cr.
	self assert: ( Bateau dicoBoatSize ) equals: 3.
	self assert: ( ba2 isKindOf: Bateau ) equals: true
]

{ #category : #tests }
BateauTest >> testInitialize [ 
	" "
	| b c d |
	Bateau initialize.
	b := Voilier new.
	d := Bateau dicoBoat.
	c := Bateau dicoBoatSize.
	self assert: 
			( c = 1 
			and: [ (d isMemberOf:  OrderedCollection ) 
			and: [ ( b isKindOf: Bateau ) 
			and: (b isMemberOf: Voilier) ] ] ) 
	equals: true
]

{ #category : #tests }
BateauTest >> testLePlusSimple [
	" "
	| ba |
	ba := Bateau new.
	self assert: ( ba isMemberOf:  Bateau ) equals: false
]

{ #category : #tests }
BateauTest >> testinitClassVariable [
	"Test initialisation des variables de la classe Bateau"
	| |
	Bateau initClassVariable .
	self assert: ( Bateau  maxNberOfBoat = 50) equals: true.
	self assert: ( Bateau  dicoBoat isKindOf: Collection) equals: true.
	
]

{ #category : #tests }
BateauTest >> testmaxNberOfBoat [
	""
	|  |
	self assert: ( Bateau maxNberOfBoat ) equals: 50
]
