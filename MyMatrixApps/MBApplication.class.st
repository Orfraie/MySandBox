"
DG 2022 aout 11
https://rakshit-p.medium.com/building-a-simple-application-with-spec2-36fa4b0ffb38

Cette appli plante sur un does not understand que je ne comprends pas non plus ! 
On la garde parce qu'on va arriver à la depanner



"
Class {
	#name : #MBApplication,
	#superclass : #SpApplication,
	#category : #MyMatrixApps
}

{ #category : #running }
MBApplication >> open [

	^ (self new: MBPresenter) openWithSpec
]

{ #category : #running }
MBApplication >> start [

	^ (self new: MBPresenter) openWithSpec
]

{ #category : #running }
MBApplication >> startOLD [

	^ (self new: MBPresenter) openWithSpec
]
