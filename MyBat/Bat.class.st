"
How to run it .
---------------
Bat new
Bat initClassVariable 
Canot new  godille: false inspect
 

"
Class {
	#name : #Bat,
	#superclass : #Object,
	#instVars : [
		'x',
		'y',
		'name',
		'cap',
		'moveCount'
	],
	#classVars : [
		'CountBateau',
		'CountTotalMove',
		'DicoBat',
		'InitDone',
		'MaxX',
		'MaxY',
		'VentDirection'
	],
	#category : #MyBat
}

{ #category : #testing }
Bat class >> isAbstract [
		
	^ self == Bat
]

{ #category : #printing }
Bat class >> logIt: aString [
	" On se sert du Transcript, le plus simple pour le moment "
	Transcript show: aString ; cr.
]

{ #category : #accessing }
Bat >> cap [
	^ cap
]

{ #category : #accessing }
Bat >> moveCount [
	^ moveCount
]

{ #category : #accessing }
Bat >> name [
	^ name
]

{ #category : #accessing }
Bat >> name: aString [
	name := aString
]

{ #category : #printing }
Bat >> printOn: aStream [ 
	" Largement  adapté aux variables d'instance de la classe Bateau"
	| si sc i j k |
	super printOn: aStream.
	k := aStream contents.
	i := self class.
	j := self class asString.
	si := 	'/InstVar are --> name=', self name asString, 
			'   x=', self x asString, 
			'   y=', self y asString,
			'   cap=', self cap asString,
			'   moveCount=',self moveCount asString.
	sc := 	j,'/ClassVar are --> maxX=', self class maxX asString,
			'   maxY=', self class maxY asString,
			'   countBateau=',self class countBateau asString,   
			'   countTotalMove=',self class countTotalMove asString, 
			'	 dico=', self class dicoBat size asString.
	aStream nextPutAll: si ; cr ; nextPutAll: sc ; cr.
]

{ #category : #accessing }
Bat >> x [
	^ x
]

{ #category : #accessing }
Bat >> y [
	^ y
]
