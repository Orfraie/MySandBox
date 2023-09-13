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
		'cnt',
		'dicoBoat',
		'maxNberOfBoat',
		'maxXY'
	],
	#classInstVars : [
		'initDone',
		'dicoBoat'
	],
	#category : #MyPlanDEau
}

{ #category : #creation }
Bateau class >> dicoBoat [
	"a comment"
	^dicoBoat
]

{ #category : #creation }
Bateau class >> dicoBoatSize [

	^dicoBoat size
]

{ #category : #creation }
Bateau class >> initClassVariable [
	" Be sure max min maxNberOfBoat dicoBoat and caps are correctly setup when instance are created "
	initDone ifNotNil: [ self logIt: 'Bat Class :: initAlreadyDone' . ^ self ].
	dicoBoat := OrderedCollection new.
	

	
]

{ #category : #updating }
Bateau class >> logIt: anObject [
	anObject isString 
		ifTrue:  [ Transcript show: anObject ; cr. ] 
		ifFalse: [ Transcript show: anObject asString ; cr ] .
]

{ #category : #accessing }
Bateau class >> maxCap [ 	
	^ 8
]

{ #category : #creation }
Bateau class >> maxNberOfBoat [
	^maxNberOfBoat
]

{ #category : #accessing }
Bateau class >> maxXY [ 	
	^ 10
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
	" set x , y , cap a des valeurs randomizées et create dicoBoat  "
	Transcript show: 'We are crossing Bateau-->initialize,.. with self class =', self class asString ; cr.
	self x: self class maxXY atRandom.
	self y: self class maxXY atRandom.
	self cap: self class maxCap atRandom.
	self name: ''
	
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
	nextPutAll: 'CLASS POOL :: max = ', Bateau maxXY asString , 
	', maxNberOfBoat = ', Bateau maxNberOfBoat asString ,
	', dicoBoatCurrentSize = ' , Bateau dicoBoat size asString ; cr .
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
	( anInteger < 0 and: [ anInteger <= self class maxXY] )
	ifTrue: [  x := anInteger ]
	
]

{ #category : #accessing }
Bateau >> y [
	^y
]

{ #category : #accessing }
Bateau >> y: anInteger [
	( anInteger < 0 and: [ anInteger <= self class maxXY] )
	ifTrue: [  y := anInteger ]
	
]
