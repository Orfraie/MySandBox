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
	self should: [ anAnimal joie ] raise: SubclassResponsibility

	
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
AnimalTest >> testEnjoyingMyOiseau [
	" ? "	
			
	| anOiseau |
	anOiseau := Oiseau new.
	anOiseau name: 'Pollux'.
	anOiseau joie: 'JePepie'.
	self assert: anOiseau  joie equals: 'JePepie'

	
]

{ #category : 'tests' }
AnimalTest >> testNamingMyAnimal [
	" ? "	
			
	| anAnimal |
	anAnimal := Animal new.
	anAnimal name: 'Pollux'.
	self assert: anAnimal name equals: 'Pollux'
]

{ #category : 'tests' }
AnimalTest >> testSubClassResponsibility [
	" Animal is an abstract class due to subclassresponsability occurence "	
			
	| anAnimal |
	anAnimal := Animal new.
	anAnimal name: 'Pollux'.
	self should: [ anAnimal joie ] raise: SubclassResponsibility

	
]
