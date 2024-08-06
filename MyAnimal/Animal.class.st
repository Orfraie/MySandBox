"
Petit exercice indépendant sur les animaux
"
Class {
	#name : 'Animal',
	#superclass : 'Object',
	#instVars : [
		'name'
	],
	#category : 'MyAnimal',
	#package : 'MyAnimal'
}

{ #category : 'instance creation' }
Animal class >> newAnimal: aNom [
	" On cree un animal en lui donnant un nom "
	| a |
	a := Animal new.
	a nom: ''.
	^a
	
]

{ #category : 'initialize' }
Animal >> answer: aString [
	"imprime la classe et le nom de l'Animal en question suivi de l'argument aString"
	Transcript show:
		(self class asString , ' ' ,
			self nom , ': ' , aString) ;
			cr.
			
	
]

{ #category : 'actions' }
Animal >> habitat [ 
	^habitat 
]

{ #category : 'actions' }
Animal >> habitat: unHabitat [ 
	"Indique au receiver que son habitat est unHabitat et indique à l'Habitat qu'il a un nouveau resident"
	habitat := unHabitat nom.
	unHabitat ajoute: self
]

{ #category : 'accessing' }
Animal >> joie [
	"On delegue a la sous classe le job de montrer sa joie "
	self subclassResponsibility 

]

{ #category : 'actions' }
Animal >> nage [ 	
	" un animal ne nage pas forcement "
	self answer: 'Je ne sais pas nager.'
]

{ #category : 'accessing' }
Animal >> name [
	^ name

]

{ #category : 'accessing' }
Animal >> name: aString [
	^ name := aString

]

{ #category : 'privat' }
Animal >> nom [
	"retourne le nom  du receveur, donc la vaeur de la variable d'instance 'nom'"
	^nom
]

{ #category : 'initialize' }
Animal >> nom: aString [
	"change le nom de l''Animal en aString"
	nom := aString
]

{ #category : 'actions' }
Animal >> ouEsTu [
	^Transcript show: 'Je suis un(e) ',  self class asString, ', je m''appelle ', self nom , ' et j''habite dans ',self habitat ; cr.
]

{ #category : 'actions' }
Animal >> parle [
	"Un message disant que l'Animal ne sait pas parler"
	self answer: 'je ne sais pas parler'
]

{ #category : 'actions' }
Animal >> show [


^ 'Le (la) ', self class asString , '  ' , self nom .
"^ ('Bonjour, je suis un(e) ',  self class asString, ', je m''appelle ', self nom , ' et j''habite ici (',self habitat,')')"
]
