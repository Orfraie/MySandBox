Class {
	#name : #Square,
	#superclass : #Pictures,
	#category : #MyInitExo
}

{ #category : #accessing }
Square >> area [
	" "
	^self side squared
]

{ #category : #accessing }
Square >> side [
	" "
	^ 4
]
