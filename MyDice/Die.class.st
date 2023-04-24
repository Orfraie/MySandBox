"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".
 
For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	faces:		<Object>


    Implementation Points
"
Class {
	#name : #Die,
	#superclass : #Object,
	#instVars : [
		'faces'
	],
	#category : #MyDice
}

{ #category : #'instance creation' }
Die class >> withFaces: anInteger [ 
	| d |
	d := Die new.
	d faces: anInteger.
	^d
]

{ #category : #accessing }
Die >> faces [
	" blabla "
	^ faces
]

{ #category : #accessing }
Die >> faces: anInteger [ 
	faces := anInteger
]

{ #category : #initalize }
Die >> initialize [
	super initialize.
	faces := 6
]

{ #category : #accessing }
Die >> printOn: aStream [
	" a die (faces number)  Evaluate Die withFaces: 6 to show"
	super printOn: aStream.
	aStream nextPutAll: ' (', faces printString, ')'
]

{ #category : #accessing }
Die >> roll [
	^ faces atRandom
]
