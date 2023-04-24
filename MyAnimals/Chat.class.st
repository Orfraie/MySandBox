Class {
	#name : #Chat,
	#superclass : #Mamifere,
	#category : #MyAnimals
}

{ #category : #'as yet unclassified' }
Chat >> miaule [

	Transcript
		show: 'As a ' , self class printString , ', je miaule,..';
		cr
]
