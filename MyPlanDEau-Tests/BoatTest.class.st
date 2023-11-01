Class {
	#name : #BoatTest,
	#superclass : #TestCase,
	#category : #'MyPlanDEau-Tests'
}

{ #category : #tests }
BoatTest >> testComplet [ 
	" presque executable dans un  PlayGround "
	|  v |
	v := Annexe new.
	self assert: ( v age  = 23 ) equals: true.
]

{ #category : #tests }
BoatTest >> testDeLaCouleur [
	" presque executable dans un  PlayGround "
	|  v   l |
	v := Sloop new.
	v couleur: 'noir'.
	l := v couleur.
	self assert: (l = 'noir' ) equals: true.
]

{ #category : #tests }
BoatTest >> testDeLaLongueur [
	" presque executable dans un  PlayGround "
	|  v   l |
	v := Annexe new.
	v longueur: 23.
	l := v longueur.
	self assert: ( v longueur  = 23 ) equals: true.
]
