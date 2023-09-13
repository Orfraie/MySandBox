Class {
	#name : #Voilier,
	#superclass : #Bateau,
	#instVars : [
		'voileHaute'
	],
	#category : #MyPlanDEau
}

{ #category : #operations }
Voilier >> initialize [ 
	" on met la voile basse,.."
	super initialize.
	Transcript show: 'We are crossing Voilier--> initialize,...with self class = ',self class asString ; cr.
	voileHaute := false
]

{ #category : #operations }
Voilier >> voile [
	^ voileHaute.
]

{ #category : #operations }
Voilier >> voile: aBoolean [
	" On hisse la voile ???? "
	 voileHaute := aBoolean
	
	
]
