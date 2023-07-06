Class {
	#name : #MyTodoListPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'todoListPresenter'
	],
	#category : #MyToDoApps
}

{ #category : #initialization }
MyTodoListPresenter >> initializePresenters [

	| tmp2 tmp4 |
	tmp2 := self newTable.
	tmp2
		addColumn:
			((SpCheckBoxTableColumn evaluated: [ :arg1 | arg1 isdone ]) width:
					 20);
		addColumn:
			(SpStringTableColumn
				 title: 'Title'
				 evaluated: [ :arg2 | arg2 title ]).
	todoListPresenter := tmp2 yourself.
	tmp4 := SpBoxLayout newVertical.
	tmp4 add: todoListPresenter.
	self layout: tmp4 yourself
]

{ #category : #initialization }
MyTodoListPresenter >> updatePresenter [

	todoListPresenter items: MyTodoTask selectAll asOrderedCollection
]
