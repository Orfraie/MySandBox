Class {
	#name : #MyTodoTask,
	#superclass : #Object,
	#instVars : [
		'done',
		'title'
	],
	#category : #MyToDoApps
}

{ #category : #testing }
MyTodoTask class >> isVoyageRoot [

	^ true
]

{ #category : #accessing }
MyTodoTask >> done: arg1 [

	done := arg1
]

{ #category : #accessing }
MyTodoTask >> initialize [

	super initialize.
	self done: false
]

{ #category : #accessing }
MyTodoTask >> isdone [

	^ done
]

{ #category : #accessing }
MyTodoTask >> title [

	^ title
]

{ #category : #accessing }
MyTodoTask >> title: arg1 [

	title := arg1
]
