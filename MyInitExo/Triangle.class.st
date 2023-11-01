Class {
	#name : #Triangle,
	#superclass : #Pictures,
	#category : #MyInitExo
}

{ #category : #accessing }
Triangle >> area [ 
	" "
	^ ( self hauteur * self base ) / 2
]

{ #category : #accessing }
Triangle >> base [
	^ 5
]

{ #category : #accessing }
Triangle >> hauteur [
	^ 4
]
