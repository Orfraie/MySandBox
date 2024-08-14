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

{ #category : 'initialize' }
Animal >> answer: aString [
	"imprime la classe et le nom de l'Animal en question suivi de l'argument aString"
	Transcript show:
		(self class asString , ' ' ,
			self nom , ': ' , aString) ;
			cr.
			
	
]

{ #category : 'basic tests' }
Animal >> doesNotUnderstand_ATester: arg1 [

	Transcript
		show: 'Error : this instance of class [' , self class printString
			, '] does not understand method [' , arg1 printString
			, '], it must be implemented elsewhere.';
		cr.
]

{ #category : 'accessing' }
Animal >> joie [
	"On delegue a la sous classe le job de montrer sa joie "
	self subclassResponsibility 

]

{ #category : 'accessing' }
Animal >> name [
	^ name

]

{ #category : 'accessing' }
Animal >> name: aString [
	^ name := aString

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
