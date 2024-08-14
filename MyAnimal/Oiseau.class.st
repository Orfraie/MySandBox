Class {
	#name : 'Oiseau',
	#superclass : 'Animal',
	#instVars : [
		'joie'
	],
	#category : 'MyAnimal',
	#package : 'MyAnimal'
}

{ #category : 'accessing' }
Oiseau >> joie [
	^ joie
]

{ #category : 'accessing' }
Oiseau >> joie: aString [
	^ joie := aString
]
