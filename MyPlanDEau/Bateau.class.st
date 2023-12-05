Class {
	#name : #Bateau,
	#superclass : #Object,
	#instVars : [
		'name',
		'x',
		'y',
		'cap',
		'xy'
	],
	#classVars : [
		'MaxCap',
		'MaxXY',
		'VentDirection'
	],
	#classInstVars : [
		'x'
	],
	#category : #MyPlanDEau
}

{ #category : #logging }
Bateau class >> logIt: aString [ 	
	" On se sert du Transcript, le plus simple pour le moment " 
	| tt |
	tt := Time now asString, ' ' .	
	Transcript show: tt,aString ; cr.
]

{ #category : #accessing }
Bateau class >> maxCap [
	^ 8
]

{ #category : #accessing }
Bateau class >> maxXY [
	^ 10
]

{ #category : #'instance creation' }
Bateau class >> new [ 	
	self == Bateau ifTrue:
  		[ self logIt: 'Tentative de création d''un ',self printString,' sans type précis.'. ^ nil]. 
	^ super new
]

{ #category : #accessing }
Bateau class >> printOn: aStream [ 
	" Largement  adapté aux variables d'instance de la classe Bateau et de ses sous classes "
	super printOn: aStream.
	aStream 
		nextPutAll: ' -- MaxCap = ' ;
		nextPutAll: self maxCap asString ;
		nextPutAll: ' -- MaxXY = ' ;
		nextPutAll: self maxXY asString ;
		nextPutAll: ' -- VentDirection = ';
		nextPutAll: self ventDirection asString.
]

{ #category : #settings }
Bateau class >> ventDirection [
	^ VentDirection.
]

{ #category : #accessing }
Bateau >> cap [
	^ cap
]

{ #category : #settings }
Bateau >> cap: anInteger [ 
	cap := anInteger
]

{ #category : #initialization }
Bateau >> initialize [ 
	" "
	x := self class maxXY atRandom.
	y := self class maxXY atRandom.
	cap := self class maxCap atRandom.
	name := 'aName' , (Time now asMilliSeconds // 1000) asString.
	"La direction du vent ne change pas pendant la simulation"
	VentDirection ifNil: [  VentDirection := self class maxCap atRandom.].
]

{ #category : #accessing }
Bateau >> name [
	^ name
]

{ #category : #settings }
Bateau >> name: aString [ 
	name := aString
]

{ #category : #accessing }
Bateau >> printOn: aStream [ 
	" Largement  adapté aux variables d'instance de la classe Bateau et de ses sous classes "
	super printOn: aStream.
	aStream 
		nextPutAll: ' :: name = ' ;
		nextPutAll: self name asString ;
		nextPutAll: ' :: cap = ';
		nextPutAll: self cap asString ;
		nextPutAll: ' :: xy = ';
		nextPutAll: self xy asString.
]

{ #category : #accessing }
Bateau >> xy [
	^ xy
]

{ #category : #setting }
Bateau >> xy: aPoint [ 
	xy := aPoint
]
