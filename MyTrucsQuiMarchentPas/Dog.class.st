Class {
	#name : #Dog,
	#superclass : #Object,
	#classInstVars : [
		'count'
	],
	#category : #MyTrucsQuiMarchentPas
}

{ #category : #accessing }
Dog class >> count [
	^ count
]

{ #category : #initialization }
Dog class >> initialize [ 
	""
	super initialize.
	count := 0
]

{ #category : #'instance creation' }
Dog class >> new [ 
	count := count + 1.
	^ super new
]
