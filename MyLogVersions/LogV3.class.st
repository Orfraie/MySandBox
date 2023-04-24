Class {
	#name : #LogV3,
	#superclass : #SpTextPresenter,
	#category : #MyLogVersions
}

{ #category : #initialize }
LogV3 class >> openView [ 
	"This open a Log view with default parameter"
	| mylogInstance |
	Transcript show: 'Start of this unique method openView';cr.

	^ self new
		withoutEditionContextMenu;
		text: 
			'Start of a Log View test (V3) with Spec2.
			I am a ', self class asString ,'/',self superclass asString,'/', SpPresenter superclass asString,'
			Ligne1
			Ligne2
			Ligne3
			Ligne3
			Ligne3
			Ligne3
			Ligne3
			Ligne3
			...';
		open
]

{ #category : #initialize }
LogV3 class >> openView1 [
	"This open a Log view with default parameter"
	| mylogInstance |
	Transcript show: 'Start of this unique method openView';cr.

	mylogInstance := 
	   self new
		withoutEditionContextMenu;
		text: 
			'Start of a Log View test (V3) with Spec2.
			I am a ', self class asString ,'/',self superclass asString,'/', SpPresenter superclass asString,'
			Ligne1
			Ligne2
			Ligne3
			Ligne3
			Ligne3
			Ligne3
			Ligne3
			Ligne3
			...';
		open.
	self halt.
	^ mylogInstance
]
