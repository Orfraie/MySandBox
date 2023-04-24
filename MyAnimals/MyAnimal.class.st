Class {
	#name : #MyAnimal,
	#superclass : #Object,
	#category : #MyAnimals
}

{ #category : #'reflective operations' }
MyAnimal >> doesNotUnderstand: arg1 [

	Transcript
		show: 'Error : this instance of class [' , self class printString
			, '] does not understand method [' , arg1 printString
			, '], it must be implemented elsewhere.';
		cr
]
