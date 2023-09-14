Class {
	#name : #Ketch,
	#superclass : #Boat,
	#instVars : [
		'aDeuxMats'
	],
	#category : #MyPlanDEau
}

{ #category : #accessing }
Ketch >> aDeuxMats [
	^ aDeuxMats
]

{ #category : #accessing }
Ketch >> aDeuxMats: a2mats [
	aDeuxMats:= a2mats
]

{ #category : #initialization }
Ketch >> initialize [ 
	"init aDeuxMats "
	super initialize. 
	"Sans super, cela coupe la chaine d'initialisation, l'initialisation de la super classe ne s'exécute pas: name et age, variable d'instance de Boat, reste à nil. "
	Boat logIt: 'je suis Ketch/initialize, et je confirme ici la chaîne d''initialization de age et name de la classe Boat, [ Annexe new inspect ] pour le vérifier'.
	aDeuxMats := true.
]
