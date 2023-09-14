Class {
	#name : #Sloop,
	#superclass : #Ketch,
	#instVars : [
		'aUnMat'
	],
	#category : #MyPlanDEau
}

{ #category : #accessing }
Sloop >> aUnMat [
	^ aUnMat
]

{ #category : #accessing }
Sloop >> aUnMat: aMat [
	aUnMat:= aMat
]

{ #category : #initialization }
Sloop >> initialize [ 
	"init aUnMat"
	super initialize.
	aUnMat := true
]
