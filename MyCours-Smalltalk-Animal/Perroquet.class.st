Class {
	#name : #Perroquet,
	#superclass : #Oiseau,
	#instVars : [
		'vocabulaire',
		'compteur',
		'aleatoire'
	],
	#category : #'MyCours-Smalltalk-Animal'
}

{ #category : #actions }
Perroquet >> aleatoire [ 
	"retourne la valeur de la variable d'instance aleatoire"
	^aleatoire 
]

{ #category : #actions }
Perroquet >> parle [
	"Fait parler au perroquet un nouveau vocabulaire"
	self answer: 
		( vocabulaire at: 
			( self aleatoire next * 100 \\ compteur ) truncated + 1 )
]

{ #category : #initialize }
Perroquet >> vocabulaire: aString [
	"Ajoute une nouvelle phrase au vocabulaire du perroquet "
	vocabulaire isNil
		ifTrue: [ compteur := 1.
				aleatoire  := Random new.
				vocabulaire := Array new: 100]
		ifFalse: [ compteur := compteur +1 ].
		vocabulaire at: compteur put: aString 
]
