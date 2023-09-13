Class {
	#name : #VoilierTest,
	#superclass : #TestCase,
	#category : #'MyPlanDEau-Tests'
}

{ #category : #tests }
VoilierTest >> testComplet [
" test complet du voilier"
| vo r1 r2 r3 r4 r5 r6 r7 r0 r8 r9|

vo := Voilier new.
vo name: 'vo'.
r0 := (vo isKindOf: Bateau).
vo voile: true.

r1 := vo voile.
vo x: 1.
vo y: 1.
r2 := vo x.
r3 := vo y.
r4 := vo class maxXY.

r6 := vo x: 3.
r7 := vo y: 5.
r8 := vo x.
r9 := vo y.


Transcript show: 'Is a kind of boat ?', r0 printString ; cr.
Transcript show: 'Is sail up or down ?', r1 printString ; cr.
Transcript show: 'Position x=', r2 printString, '  y=' , r3 printString ; cr.
Transcript show: 'Plan d''eau size MaxXY=', r4 printString ; cr.

Transcript show: 'Position x must be 2 and is ', r6 printString ; cr.
Transcript show: 'Position y must be 4 and is ', r7 printString ; cr.
Transcript show: 'Plan d''eau size Maxx=', r4 printString ; cr.
Transcript show: 'Position x must be 3 and is ', r6 printString ; cr.
Transcript show: 'Position y must be 5 and is ', r7 printString ; cr.

self assert: ( r0 and: [ r1 and: [ 1 = r2 and: [ 1 = r3]]]) equals: true

]

{ #category : #tests }
VoilierTest >> testVoilePosition [
	" tester la position courante de la voile"
	| v vh vb |
	v := Voilier new.
	" on monte la voile,.."
	v voile: true.
	vh := v voile.
	" on descend la voile,..."
	v voile: false.
	vb := v voile.
	" On teste la position de la voile,.. "
	self assert: (( vb = false ) and: [ vh ] ) equals: true
	
]
