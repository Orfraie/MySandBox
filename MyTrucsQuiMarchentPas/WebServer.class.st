Class {
	#name : #WebServer,
	#superclass : #Object,
	#instVars : [
		'sessions'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #MyTrucsQuiMarchentPas
}

{ #category : #accessing }
WebServer class >> WebServeruniqueInstance [
	" To Run it : WebServer uniqueInstance "
	uniqueInstance ifNil: [ uniqueInstance := self new ]. 
]

{ #category : #accessing }
WebServer class >> uniqueInstance [
	" To Run it : WebServer uniqueInstance "
	uniqueInstance ifNil: [ uniqueInstance := self new ]. 
	^ uniqueInstance
]
