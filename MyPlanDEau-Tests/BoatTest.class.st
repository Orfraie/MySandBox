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
