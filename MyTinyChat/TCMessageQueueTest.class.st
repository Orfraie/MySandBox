"
Quelques tests unitaires pour la queue de msg

"
Class {
	#name : 'TCMessageQueueTest',
	#superclass : 'TestCase',
	#category : 'MyTinyChat',
	#package : 'MyTinyChat'
}

{ #category : 'tests' }
TCMessageQueueTest class >> testCreationQueue [
	"co"	
			
	| aQueue |
	aQueue := TCMessageQueue new ; initialize.
	self assert: aQueue size equals: 0
]

{ #category : 'tests' }
TCMessageQueueTest >> testAddMsgToQueue [
	" ? "
			
	| aQueue |
	aQueue := TCMessageQueue new initialize.
	aQueue add: (TCMessage fromString: 'Olivier>aMSG').
	self assert: aQueue size equals: 1.
	
]

{ #category : 'tests' }
TCMessageQueueTest >> testCreationQueue [
	" ? "
			
	| aQueue |
	aQueue := TCMessageQueue new initialize.
	self assert: aQueue size equals: 0.
	
]

{ #category : 'tests' }
TCMessageQueueTest >> testPartialExtractFromQueue [
	" ? "
			
	| aQueue |
	aQueue := TCMessageQueue new initialize.
	aQueue add: (TCMessage fromString: 'Olivier>aMSG').
	aQueue add: (TCMessage fromString: 'Olivier>aMSG1').
	self assert: (aQueue formattedMessagesFrom: 100) equals: ''.
	self assert: (aQueue formattedMessagesFrom: 1) size equals: 29
	
]

{ #category : 'tests' }
TCMessageQueueTest >> testRemoveQueue [
	" ? "
			
	| aQueue |
	aQueue := TCMessageQueue new initialize.
	aQueue add: (TCMessage fromString: 'Olivier>aMSG').
	aQueue add: (TCMessage fromString: 'Olivier>aMSG1').
	self assert: (aQueue formattedMessagesFrom: 3) equals: ''
	
]

{ #category : 'tests' }
TCMessageQueueTest >> testResetQueue [
	" ? "
			
	| aQueue |
	aQueue := TCMessageQueue new initialize.
	aQueue add: (TCMessage fromString: 'Olivier>aMSG').
	aQueue add: (TCMessage fromString: 'Olivier>aMSG1').
	aQueue reset.
	self assert: aQueue size equals: 0
	
]
