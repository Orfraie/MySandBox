Class {
	#name : #MyTodoApps,
	#superclass : #SpApplication,
	#instVars : [
		'todoListPresenter'
	],
	#category : #MyToDoApps
}

{ #category : #running }
MyTodoApps >> example [

	self new run.
]

{ #category : #running }
MyTodoApps >> run [

	(self new: MyTodoListPresenter) open
]
