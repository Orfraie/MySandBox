Class {
	#name : #TextDemo1,
	#superclass : #Object,
	#category : #MyTextDemo1
}

{ #category : #example }
TextDemo1 class >> example [
	"Creates two text morph on the common model.
	 If you change (if you have finished with changing
	 the string, press Alt+S) the string in one of the text morphs,
	 this will affect also the other one."
	
	| object textMorph1 textMorph2 |
	object := TextDemo1Object new.
	
	textMorph1 :=  RubPluggableTextMorph on: object text: #text accept: #text:.
	textMorph1 
		position: 50 @ 450; 
		extent: 200 @ 100;
		color: Color white;
		openInWorld.
	
	textMorph2  := RubPluggableTextMorph on: object text: #text accept: #text:.
	textMorph2
		position: 300 @ 450;
		extent: 200 @ 100;
		color: Color white;
		openInWorld.
]
