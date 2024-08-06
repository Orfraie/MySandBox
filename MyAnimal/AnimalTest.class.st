Class {
	#name : 'AnimalTest',
	#superclass : 'TestCase',
	#category : 'MyAnimal',
	#package : 'MyAnimal'
}

{ #category : 'tests' }
AnimalTest >> testEnjoyingMyAnimal [
	" ? "	
			
	| anAnimal |
	anAnimal := Animal new.
	anAnimal name: 'Pollux'.
	[ anAnimal joie ] 
		on: ZeroDivide
		do: [ :ex | Transcript cr ; show: 'bof' ; cr ]
	
]

{ #category : 'tests' }
AnimalTest >> testEnjoyingMyCat [
	" ? "	
			
	| aKat |
	aKat := Chat new.
	aKat name: 'Pollux'.
	aKat joie: 'JeMiaule'.
	self assert: aKat joie equals: 'JeMiaule'
]

{ #category : 'tests' }
AnimalTest >> testNamingMyAnimal [
	" ? "	
			
	| anAnimal |
	anAnimal := Animal new.
	anAnimal name: 'Pollux'.
	self assert: anAnimal name equals: 'Pollux'
]
