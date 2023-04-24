"
Ne marche pas du otu
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
