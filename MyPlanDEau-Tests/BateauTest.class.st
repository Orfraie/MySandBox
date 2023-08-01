Class {
	#name : #BateauTest,
	#superclass : #TestCase,
	#category : #'MyPlanDEau-Tests'
}

{ #category : #tests }
BateauTest >> testBateauComplet [
" test complet du voilier"
| vo r1 r2 r3 r4 r5 r6 r7 r0 r8 r9 r10|

vo := Voilier new: 'vo'.
r0 := (vo isKindOf: Bateau).
vo changeVoilePosition.

r1 := vo voile.
vo x: 1.
vo y: 1.
r2 := vo x.
r3 := vo y.

r4 := vo maxx.
r5 := vo maxy.

vo x: 23.
vo y: 24.
r6 := vo x.
r7 := vo y.

vo dir: 'nord'.
vo move.
r8 := vo x.
r9 := vo y.


Transcript show: 'Is a kind of boat ?', r0 printString ; cr.
Transcript show: 'Is sail up or down ?', r1 printString ; cr.
Transcript show: 'Position x=', r2 , '  y=' , r3 printString ; cr.
Transcript show: 'Plan d''eau size Maxx=', r4,', Maxy=', r5 printString ; cr.

Transcript show: 'Position x must be 23 and is ', r6 printString ; cr.
Transcript show: 'Position y must be 24 and is ', r7 printString ; cr.
Transcript show: 'Plan d''eau size Maxx=', r4,', Maxy=', r5 printString ; cr.
Transcript show: 'Position x must be 23 and is ', r6 printString ; cr.
Transcript show: 'Position y must be 23 and is ', r7 printString ; cr.

self assert: ( r0 and: [ r1 and: [ 1 = r2 and: [ 1 = r3]]]) equals: true
]

{ #category : #tests }
BateauTest >> testBuildThreeBateaux [
 	"Creation de 3 bateaux 1/ évaluation de la taille de dicoBoat 2/Extraction des variables d'instance"
	| ba1 ba2 ba3 |
	Bateau initClassVariable .
	ba1 := Bateau name: 'ba1' .
	ba1 randomizedXYCAP .
	ba2 := Bateau name: 'ba2'.
	ba2 x: 10.
	ba2 y: 10.
	ba3 := Bateau name: 'ba3'.
	Transcript show: ( Bateau dicoBoatSize ) ; cr.
	self assert: ( Bateau dicoBoatSize ) equals: 3.
	self assert: ( ba2 isMemberOf: Bateau ) equals: true
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
BateauTest >> testCreation [
	" "
	| b v c d |
	b := Voilier new.
	c := Bateau cnt.
	d := Bateau dico.
	self assert: 
			( c = 1 
			and: [ ( d isMemberOf:  Dictionary ) 
			and: [ ( b isKindOf: Bateau ) 
			and: (b isMemberOf: Voilier) ] ] ) 
	equals: true
]

{ #category : #tests }
BateauTest >> testInitialize [ 
	" "
	| b c d |
	Bateau initialize.
	b := Voilier new.
	c := Bateau cnt.
	d := Bateau dico.
	self assert: 
			( c = 1 
			and: [ (d isMemberOf:  Dictionary ) 
			and: [ ( b isKindOf: Bateau ) 
			and: (b isMemberOf: Voilier) ] ] ) 
	equals: true
]

{ #category : #tests }
BateauTest >> testLePlusSimple [
	" "
	| ba |
	ba := Bateau new.
	self assert: ( ba isMemberOf:  Bateau ) equals: true
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
