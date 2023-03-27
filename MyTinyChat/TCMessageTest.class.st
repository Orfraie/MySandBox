Class {
	#name : #TCMessageTest,
	#superclass : #TestCase,
	#category : #MyTinyChat
}

{ #category : #tests }
TCMessageTest >> testCreationWithFromString [
	" ? "
			
	| aMsg |
	aMsg := TCMessage fromString: 'Olivier>textDeTestPourFromString'.
	self assert: aMsg sender equals: 'Olivier'
]

{ #category : #tests }
TCMessageTest >> testCreationWithFromText [
	" ? "
			
	| aMsg |
	aMsg := TCMessage from: 'Olivier' text: 'Msg de Olivier'.
	self assert: aMsg printString equals: 'Olivier>Msg de Olivier',String crlf
]
