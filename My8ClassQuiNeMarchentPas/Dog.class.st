Class {
	#name : #Dog,
	#superclass : #Object,
	#classInstVars : [
		'count'
	],
	#category : #My8ClassQuiNeMarchentPas
}

{ #category : #accessing }
Dog class >> count [
	^ count
]

{ #category : #'class initialization' }
Dog class >> initialize [ 
	""
	count := 0
]

{ #category : #'instance creation' }
Dog class >> new [ 
	count := count + 1.
	^ super new
]
