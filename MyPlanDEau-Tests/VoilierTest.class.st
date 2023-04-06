Class {
	#name : #VoilierTest,
	#superclass : #TestCase,
	#category : #'MyPlanDEau-Tests'
}

{ #category : #'as yet unclassified' }
VoilierTest >> testComplet [
" test complet du voilier"
| vo r1 r2 r3 r4 r5 r6 r7 r0 r8 r9|

vo := Voilier new: 'vo'.
r0 := (vo isKindOf: Bateau).
vo changeVoilePosition.

r1 := vo voile.
vo x: 1.
vo y: 1.
r2 := vo x.
r3 := vo y.

r4 := vo maxx.
r5 := vo maxy.

vo x: 23.
vo y: 24.
r6 := vo x.
r7 := vo y.

vo dir: 'nord'.
vo move.
r8 := vo x.
r9 := vo y.


Transcript show: 'Is a kind of boat ?', r0 printString ; cr.
Transcript show: 'Is sail up or down ?', r1 printString ; cr.
Transcript show: 'Position x=', r2 , '  y=' , r3 printString ; cr.
Transcript show: 'Plan d''eau size Maxx=', r4,', Maxy=', r5 printString ; cr.

Transcript show: 'Position x must be 23 and is ', r6 printString ; cr.
Transcript show: 'Position y must be 24 and is ', r7 printString ; cr.
Transcript show: 'Plan d''eau size Maxx=', r4,', Maxy=', r5 printString ; cr.
Transcript show: 'Position x must be 23 and is ', r6 printString ; cr.
Transcript show: 'Position y must be 23 and is ', r7 printString ; cr.

self assert: ( r0 and: [ r1 and: [ 1 = r2 and: [ 1 = r3]]]) equals: true
]

{ #category : #'as yet unclassified' }
VoilierTest >> testVoilePosition [
	" tester la position courante de la voile"
	| v vh vb |
	v := Voilier new.
	" on monte la voile,.."
	v voile: true.
	vh := v voilePosition.
	" on descend la voile,..."
	v voile: false.
	vb := v voilePosition.
	" On teste la position de la voile,.. "
	self assert: (( vb = false ) and: [ vh ] ) equals: true
	
]
