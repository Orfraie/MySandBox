Class {
	#name : #Croiseur,
	#superclass : #Cargo,
	#instVars : [
		'obus'
	],
	#category : #MyPlanDEau
}

{ #category : #accessing }
Croiseur >> initialize [ 
	" On charge le canon des la creation du croiseur  "
	super initialize.
	obus := true
]

{ #category : #accessing }
Croiseur >> obus [
	^ obus.
]

{ #category : #accessing }
Croiseur >> obus: aBoolean [ 
	obus := aBoolean .
]

{ #category : #accessing }
Croiseur >> printOn: aStream [ 
	" Largement  adapté aux variables d'instance de la classe Bateau et de ses sous classes "
	super printOn: aStream.
	aStream 
		nextPutAll: ' :: obus = ' ;
		nextPutAll: self obus asString .
]
