Class {
	#name : #MyTextPane,
	#superclass : #SpPresenter,
	#instVars : [
		'scrollablePresenter'
	],
	#classInstVars : [
		'scrollablePresenter'
	],
	#category : #MyTextPane
}

{ #category : #layout }
MyTextPane class >> defaultLayout [ 
	^SpScrollableLayout with: scrollablePresenter
]

{ #category : #adding }
MyTextPane >> addTextFieldTo: aLayout [
	aLayout
		add: (self newLabel
				 label: 'This is MY text field';
				 yourself)
		expand: false
		fill: false
		padding: 5.
	aLayout add: self newText withConstraints: [ :c | c height: 120 ]
]

{ #category : #initialization }
MyTextPane >> initializePresenters [
	| largeLayout |
	super initializePresenters.
	largeLayout := SpBoxLayout newTopToBottom.
	self addTextFieldTo: largeLayout.
	"self flag: 'setting flag.'."
	scrollablePresenter := SpPresenter new.
	scrollablePresenter layout: largeLayout.
	"self halt"
]
