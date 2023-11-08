Class {
	#name : #Circle,
	#superclass : #Pictures,
	#category : #MyInitExo
}

{ #category : #accessing }
Circle >> area [ 
	"  "
	^ (Float pi * self radius squared / 2)
]

{ #category : #accessing }
Circle >> radius [ 
	"  "
	^ 4
]
