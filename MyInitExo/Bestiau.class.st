Class {
	#name : #Bestiau,
	#superclass : #Object,
	#category : #MyInitExo
}

{ #category : #testing }
Bestiau class >> isAbstract [
		
	^ self == Bestiau
]

{ #category : #testing }
Bestiau class >> logIt: aString [
	" On se sert du Transcript, le plus simple pour le moment "
	Transcript show: aString ; cr.
]

{ #category : #testing }
Bestiau class >> new [ 
	Transcript show: self printString, ' -- ', self class printString ; cr.
	self == Bestiau ifTrue: 
		[ self logIt: 'Tentative de création d''un ',self printString,' sans type précis.'. ^ nil].
	^ super new
]
