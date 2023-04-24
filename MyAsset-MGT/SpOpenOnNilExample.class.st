"
I am the component of DynamycSpecExample used for nil.

self example

I display simply an TextInputFieldPresenter, disable to don't be edditable by the user.
"
Class {
	#name : #SpOpenOnNilExample,
	#superclass : #SpPresenter,
	#instVars : [
		'text'
	],
	#category : #'MyAsset-MGT'
}

{ #category : #examples }
SpOpenOnNilExample class >> example [

	" /home/dagerm/Pharo10-64bits/Spec-V1.1.2-EstebanLorenzo-2022apr1/Spec-1.1.2/src/Spec2-Examples/SpOpenOnNilExample.class.st
C'est une instance de SpTextInputFieldPresenter, bel exemple mais pas encore ce qu'on veut !

"

	<totoRajoutécestSyntaxiquementCorrectMaisOnNeSaitPasAQuoiCaSert>
	<sampleInstance>
	^ self new
		  extent: 200 @ 100;
		  open;
		  yourself
]

{ #category : #layout }
SpOpenOnNilExample >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: text expand: false;
		  yourself
]

{ #category : #initialization }
SpOpenOnNilExample >> initialize: anInteger [
	text label: anInteger asString
]

{ #category : #initialization }
SpOpenOnNilExample >> initializePresenters [
	text := self instantiate: SpTextInputFieldPresenter.
	text
		text: 'Object is nil';
		enabled: false.
]

{ #category : #accessing }
SpOpenOnNilExample >> text [
	^ text
]

{ #category : #accessing }
SpOpenOnNilExample >> title [
	^ 'SpOpenOnNilExample'
]
