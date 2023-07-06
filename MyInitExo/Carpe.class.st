Class {
	#name : #Carpe,
	#superclass : #Poisson,
	#instVars : [
		'couleur'
	],
	#category : #MyInitExo
}

{ #category : #accessing }
Carpe >> couleur [
	^couleur
]

{ #category : #accessing }
Carpe >> couleur: aColor [
	couleur := aColor
]

{ #category : #initialization }
Carpe >> initialize [ 
	""
	Betes plusUn.
	^ self couleur: 'Black'.
]
