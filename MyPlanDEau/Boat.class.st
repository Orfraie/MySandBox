Class {
	#name : #Boat,
	#superclass : #Object,
	#instVars : [
		'name',
		'age',
		'couleur',
		'longueur',
		'flotte'
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

{ #category : #Accessing }
Boat >> couleur [
	^ couleur
]

{ #category : #settings }
Boat >> couleur: aString [ 
	couleur := aString.
]

{ #category : #initialization }
Boat >> initialize [ 
	"init age et name "
	name := 'aName'.
	age := 23 .
	flotte := true .
]

{ #category : #accessing }
Boat >> longueur [
	^ longueur
]

{ #category : #settings }
Boat >> longueur: anInteger [ 
	longueur :=  anInteger
]

{ #category : #accessing }
Boat >> name [
	^name
]

{ #category : #accessing }
Boat >> name: aName [
	name := aName
]
