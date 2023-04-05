"
This is class Bateau documentation

"
Class {
	#name : #Bateau,
	#superclass : #Object,
	#instVars : [
		'name',
		'x',
		'y',
		'cap'
	],
	#classVars : [
		'caps',
		'dicoBoat',
		'max',
		'maxNberOfBoat',
		'min'
	],
	#category : #MyPlanDEau
}

{ #category : #creation }
Bateau class >> caps [
	^caps
]

{ #category : #creation }
Bateau class >> dicoBoat [

	^dicoBoat
]

{ #category : #creation }
Bateau class >> dicoBoatSize [

	^dicoBoat size
]

{ #category : #creation }
Bateau class >> initClassVariable [
	" Be sure max min maxNberOfBoat dicoBoat and caps are crrectly setup when instance are created "
	max := 25 . 
	min := 1.
	maxNberOfBoat := 50.
	dicoBoat := Dictionary new.
	caps := Array new: 8 .
	caps at: 1 put: 0.
	2 to: 8 do: [  :each | caps at: each  put: (caps at: each-1 ) + 45 ].
	
]

{ #category : #creation }
Bateau class >> max [
	^max 
]

{ #category : #creation }
Bateau class >> maxNberOfBoat [
	^maxNberOfBoat
]

{ #category : #creation }
Bateau class >> min [
	^min 
]

{ #category : #creation }
Bateau class >> name: aName [
| ba |
	ba := self new.
	"  verifier que aName n'est pas deja present dans dicoBoat "
	"  creer une entrée dans dicoBoat "
	ba name: aName  
]

{ #category : #accessing }
Bateau >> cap [
	^cap
]

{ #category : #accessing }
Bateau >> cap: anInteger [
	cap:=anInteger
]

{ #category : #accessing }
Bateau >> initialize [
	" set x , y , cap a des valeurs randomizées "
	self x: max atRandom.
	self y: max atRandom.
	self cap: (Bateau caps at: (8 atRandom)).
]

{ #category : #accessing }
Bateau >> name [
	^name 
]

{ #category : #accessing }
Bateau >> name: aName [
	name := aName
]

{ #category : #creation }
Bateau >> name: aString x: anInteger y: anOtherInteger [
	name := aString.
	x := anInteger.
	y := anOtherInteger
]

{ #category : #accessing }
Bateau >> new [
^nil
]

{ #category : #accessing }
Bateau >> new: aName [
	" set x , y , cap a des valeurs randomizées "
	super new initialize.
	self x: max atRandom.
	self y: max atRandom.
	self cap: (self class caps at: (8 atRandom)).
	self name: aName asString 
]

{ #category : #printing }
Bateau >> printOn: aStream [
	super printOn: aStream.
	aStream cr ; nextPutAll: 'INSTANCES var :: named: ', name , 
	', x =  ', x asString, ', y = ' , y asString , 
	', cap = ', cap asString ;  cr ;
	nextPutAll: 'CLASS POOL :: max = ', Bateau max asString , 
	', min = ', Bateau min asString , ', maxNberOfBoat = ', Bateau maxNberOfBoat asString ,
	', dicoBoatCurrentSize =' , dicoBoat size asString ; cr .
]

{ #category : #accessing }
Bateau >> randomizedXYCAP [
	" set x , y , cap a des valeurs randomizées "
	self x: max atRandom.
	self y: max atRandom.
	self cap: (Bateau caps at: (8 atRandom)).
]

{ #category : #accessing }
Bateau >> x [
	^x
]

{ #category : #accessing }
Bateau >> x: anInteger [
	x := anInteger.
	anInteger > max ifTrue: [ x := max ].
	anInteger < min ifTrue: [ x := min]
	
]

{ #category : #accessing }
Bateau >> y [
	^y
]

{ #category : #accessing }
Bateau >> y: anInteger [
	y := anInteger.
	anInteger > max ifTrue: [ y := max ].
	anInteger < min ifTrue: [ y := min]
	
]