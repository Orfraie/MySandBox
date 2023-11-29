Class {
	#name : #SousMarin,
	#superclass : #Cargo,
	#instVars : [
		'torpille',
		'surface'
	],
	#category : #MyPlanDEau
}

{ #category : #accessing }
SousMarin >> initialize [ 
	" dès la création du sous-marin, on charge le tube lance-torpille et on le positionne en surface "
	super initialize.
	surface := true.
	torpille := true
]

{ #category : #accessing }
SousMarin >> printOn: aStream [ 
	" Largement  adapté aux variables d'instance de la classe Bateau et de ses sous classes "
	super printOn: aStream.
	aStream 
		nextPutAll: ' :: torpille = ' ;
		nextPutAll: self torpille asString;
		nextPutAll: ' :: surface = ' ;
		nextPutAll: self surface asString.
	
]

{ #category : #accessing }
SousMarin >> surface [
	^ surface .
]

{ #category : #accessing }
SousMarin >> surface: aBoolean [ 
	surface := aBoolean
]

{ #category : #accessing }
SousMarin >> torpille [
	^torpille
]

{ #category : #accessing }
SousMarin >> torpille: aBoolean [
	torpille := aBoolean
]
