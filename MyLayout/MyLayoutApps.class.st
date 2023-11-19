"
Ne marche pas du tout
"
Class {
	#name : #MyLayoutApps,
	#superclass : #Object,
	#category : #MyLayout
}

{ #category : #initialization }
MyLayoutApps >> run [
	" self new run"
	(self new: scrollablePresenter ) openWithSpec
]
