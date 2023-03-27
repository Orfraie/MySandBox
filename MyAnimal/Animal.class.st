"
Petit exercice indépendant sur les animaux
"
Class {
	#name : #Animal,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #MyAnimal
}

{ #category : #accessing }
Animal >> joie [
	"On delegue a la sous classe le job de montrer sa joie "
	self subclassResponsibility 

]

{ #category : #accessing }
Animal >> name [
	^ name

]

{ #category : #accessing }
Animal >> name: aString [
	^ name := aString

]
