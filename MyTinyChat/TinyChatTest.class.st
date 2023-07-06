Class {
	#name : #TinyChatTest,
	#superclass : #TestCase,
	#category : #MyTinyChat
}

{ #category : #tests }
TinyChatTest >> CreationInstanceSansTestDansLeLibelle [
	" ? "
	self assert: TinyChat new initialize messages size equals: 0

]

{ #category : #tests }
TinyChatTest >> testCreationInstance [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
			
	| aTiny |
	self assert: TinyChat new initialize lastMessageIndex equals: 0
	"
	self assert: aTiny class printString equals: 'TinyChat class'.
	self assert: aTiny lastMessageIndex equals: 0.
	"
]

{ #category : #tests }
TinyChatTest >> testCreationInstance1 [
	" ? "
	self assert: TinyChat new initialize lastMessageIndex equals: 0

]

{ #category : #tests }
TinyChatTest >> testCreationInstance2 [
	" ? "
	self assert: TinyChat new initialize exit equals: false 

]

{ #category : #tests }
TinyChatTest >> testCreationInstance3 [
	" ? "
	self assert: TinyChat new initialize messages size equals: 0

]
