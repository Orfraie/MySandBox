"
Fille de Bat avec une godille
"
Class {
	#name : #Canot,
	#superclass : #Bat,
	#instVars : [
		'godille'
	],
	#category : #MyBat
}

{ #category : #accessing }
Canot >> godille [
	" On verifie que la godille est bien a bord."
	^godille
]

{ #category : #accessing }
Canot >> godille: aBoolean [
	"On met ou retire la godille du canot "
	godille := aBoolean
]

{ #category : #initialization }
Canot >> initialize [ 	
	" on met la godille dans le canaot "
	godille := true.
]
