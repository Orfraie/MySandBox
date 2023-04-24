Class {
	#name : #SpOpenOnItExample,
	#superclass : #SpPresenter,
	#instVars : [
		'text',
		'plus',
		'minus'
	],
	#category : #'MyAsset-MGT'
}

{ #category : #documentation }
SpOpenOnItExample class >> docEtSource [
	^self
"
I am the component of DynamycSpecExample used for Integer.

self example 

Class {
	#name : #SpOpenOnIntExample,
	#superclass : #SpPresenter,
	#instVars : [
		'text',
		'plus',
		'minus'
	],
	#category : #'MyAsset-MGT'
}

{ #category : #examples }
SpOpenOnIntExample class >> example [

	<sampleInstance>
	^ (self new: 42)
		  extent: 100 @ 100;
		  open;
		  yourself
]

{ #category : #instantiation }
SpOpenOnIntExample class >> new: anInteger [
	^ self new initialize: anInteger
]

{ #category : #initialization }
SpOpenOnIntExample >> connectPresenters [
	minus
		action: [ | currentValue |
			currentValue := text label asInteger.
			text label: (currentValue - 1) asString ].
	plus
		action: [ | currentValue |
			currentValue := text label asInteger.
			text label: (currentValue + 1) asString ]
]

{ #category : #layout }
SpOpenOnIntExample >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		add: text expand: false;
		add: (SpBoxLayout newLeftToRight
			add: minus;
			add: plus;
			yourself)
		expand: false;
		yourself
]

{ #category : #initialization }
SpOpenOnIntExample >> initialize: anInteger [
	text label: anInteger asString
]

{ #category : #initialization }
SpOpenOnIntExample >> initializePresenters [
	text := self instantiate: SpLabelPresenter.
	plus := self instantiate: SpButtonPresenter.
	minus := self instantiate: SpButtonPresenter.
	plus
		label: '+'.
	minus
		label: '-'
]

{ #category : #accessing }
SpOpenOnIntExample >> minus [
	^ minus
]

{ #category : #accessing }
SpOpenOnIntExample >> plus [
	^ plus
]

{ #category : #accessing }
SpOpenOnIntExample >> text [
	^ text
]

{ #category : #accessing }
SpOpenOnIntExample >> title [
	^ 'OpenOnIntExample'
]
"
]

{ #category : #examples }
SpOpenOnItExample class >> example [

	"/home/dagerm/Pharo10-64bits/Spec-V1.1.2-EstebanLorenzo-2022apr1/Spec-1.1.2/src/Spec2-Examples/SpOpenOnIntExample.class.st"

	^ (self new: 42)
		  extent: 100 @ 100;
		  open;
		  yourself
]

{ #category : #'instance creation' }
SpOpenOnItExample class >> new: anInteger [
	^ self new initialize: anInteger

]

{ #category : #'instance initialization' }
SpOpenOnItExample >> connectPresenters [
"a comment "
	minus
		action: [ | currentValue |
			currentValue := text label asInteger.
			text label: (currentValue - 1) asString ].
	plus
		action: [ | currentValue |
			currentValue := text label asInteger.
			text label: (currentValue + 1) asString ]
]

{ #category : #layout }
SpOpenOnItExample >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		add: text expand: false;
		add: (SpBoxLayout newLeftToRight
			add: minus;
			add: plus;
			yourself)
		expand: false;
		yourself
]

{ #category : #'instance initialization' }
SpOpenOnItExample >> initialize: anInteger [ 
	text label: anInteger asString

]

{ #category : #initialization }
SpOpenOnItExample >> initializePresenters [ 
"a comment"
	text := self instantiate: SpLabelPresenter.
	plus := self instantiate: SpButtonPresenter.
	minus := self instantiate: SpButtonPresenter.
	plus
		label: '+'.
	minus
		label: '-'
]

{ #category : #accessing }
SpOpenOnItExample >> minus [
	^minus
]

{ #category : #accessing }
SpOpenOnItExample >> plus [
	^plus
]

{ #category : #accessing }
SpOpenOnItExample >> text [
	^text
]

{ #category : #accessing }
SpOpenOnItExample >> title [

	^ 'SpOpenOnItExample'
]
