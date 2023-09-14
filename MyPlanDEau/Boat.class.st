Class {
	#name : #Boat,
	#superclass : #Object,
	#instVars : [
		'name',
		'age'
	],
	#classVars : [
		'BoatCnt'
	],
	#category : #MyPlanDEau
}

{ #category : #'instance creation' }
Boat class >> logIt: aString [
	" On se sert du Transcript, le plus simple pour le moment "
	Transcript show: aString ; cr
]

{ #category : #'instance creation' }
Boat class >> new [ 
	"On interdit l'instanciation de la classe Boat"
	self == Boat ifTrue:
  		[ self logIt: 'Tentative de création d''un ',self printString,' sans type précis.'. ^ nil]. 
	^ super new	
]

{ #category : #accessing }
Boat >> age [
	^ age
]

{ #category : #accessing }
Boat >> age: aAge [
	age := aAge
]

{ #category : #initialization }
Boat >> initialize [ 
	"init age et name "
	name := 'aName'.
	age := 23 .
]

{ #category : #accessing }
Boat >> name [
	^name
]

{ #category : #accessing }
Boat >> name: aName [
	name := aName
]
