Class {
	#name : #Parallelogramme,
	#superclass : #Pictures,
	#instVars : [
		'hauteur',
		'cote'
	],
	#category : #MyInitExo
}

{ #category : #accessing }
Parallelogramme >> area [  
	^ self cote * self hauteur
]

{ #category : #accessing }
Parallelogramme >> cote [
	^ 6
]

{ #category : #accessing }
Parallelogramme >> hauteur [ 
	^ 4
]
