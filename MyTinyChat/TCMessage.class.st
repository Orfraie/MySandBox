"
Les variables d’instances sont les suivantes:
• sender : le login de l’expéditeur,
• text : le texte du message,
• separator : un caractère séparateur pour l’affichage.
"
Class {
	#name : 'TCMessage',
	#superclass : 'Object',
	#instVars : [
		'sender',
		'separator',
		'text'
	],
	#category : 'MyTinyChat',
	#package : 'MyTinyChat'
}

{ #category : 'instance creation' }
TCMessage class >> from: aSender text: aText [
	" creer une instance de TCMsg avec aSender et aText"	
	^ self new sender: aSender ; text: aText ; yourself
]

{ #category : 'instance creation' }
TCMessage class >> fromString: aString [
	" creer une instance de TCMsg avec un str dotté d'un separator"	
	^ self new fromString: aString ; yourself
]

{ #category : 'instance creation' }
TCMessage >> fromString: aString [ 
	"compose a msg from aStrings"	
			
	| items |
	items := aString substrings: separator.
	self sender: items first.
	self text: items second.
	
]

{ #category : 'initialization' }
TCMessage >> initialize [
	"set le separator"	
	super initialize.
	separator := '>'
]

{ #category : 'printing' }
TCMessage >> printOn: aStream [
	"TCMsg object as a string"	
	aStream
		<< self sender ;
		<< separator ;
		<< self text ;
		<< String crlf 
		
]

{ #category : 'accessing' }
TCMessage >> sender [
	^ sender
]

{ #category : 'setting' }
TCMessage >> sender: anObject [
	^ sender := anObject
]

{ #category : 'accessing' }
TCMessage >> text [
	^ text
]

{ #category : 'setting' }
TCMessage >> text: anObject [
	^ text := anObject
]
