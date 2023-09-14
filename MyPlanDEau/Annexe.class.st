Class {
	#name : #Annexe,
	#superclass : #Sloop,
	#instVars : [
		'aUneGodille'
	],
	#category : #MyPlanDEau
}

{ #category : #accessing }
Annexe >> aUneGodille [
	^ aUneGodille
]

{ #category : #accessing }
Annexe >> aUneGodille: aGodille [
	aUneGodille := aGodille
]

{ #category : #initialization }
Annexe >> initialize [ 
	" init aUneGodille "
	super initialize.
	aUneGodille := true.
]
