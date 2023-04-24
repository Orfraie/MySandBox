Class {
	#name : #ExempleSetTest,
	#superclass : #TestCase,
	#instVars : [
		'full',
		'empty'
	],
	#category : #'MyExemple-Tests'
}

{ #category : #initialization }
ExempleSetTest >> setUp [

	super setUp.
	empty := Set new.
	full := Set with: 5 with: 6 with: 7
]

{ #category : #tests }
ExempleSetTest >> testDemoButton1 [

	^ nil
]

{ #category : #tests }
ExempleSetTest >> testExample [

	| tmp1 |
	tmp1 := PluggableButtonMorph
		        on: [ 
			        Transcript
				        show: 'something';
				        cr ]
		        getState: nil
		        action: #value.
	tmp1
		label: 'show ''something'' on Transcript!!';
		position: 100 @ 200;
		openInWorld
]

{ #category : #tests }
ExempleSetTest >> testIllegal [

	self
		should: [ empty at: 5 ] raise: Error;
		should: [ empty at: 5 put: #zork ] raise: Error
]

{ #category : #tests }
ExempleSetTest >> testIllegal1 [

	self
		should: [ empty at: 4 ] raise: TestResult error;
		should: [ empty at: 5 put: #zork ] raise: TestResult error
]

{ #category : #tests }
ExempleSetTest >> testIllegal2 [

	self
		should: [ empty at: 5 ] raise: TestResult error;
		should: [ empty at: 5 put: #zork ] raise: TestResult error
]

{ #category : #tests }
ExempleSetTest >> testIllegal3 [

	self
		should: [ empty at: 5 ] raise: TestResult error;
		should: [ empty at: 5 put: #zork ] raise: TestResult error
]

{ #category : #tests }
ExempleSetTest >> testIncludes [

	self
		assert: (full includes: 5);
		assert: (full includes: 6)
]

{ #category : #tests }
ExempleSetTest >> testIndependant [

	| tmp1 |
	tmp1 := 42.
	self
		assert: tmp1 = 42
		description:
			'String explicatif quand ca gaufre, attendu 42, obtenu '
			, tmp1 printString
]

{ #category : #'MyExemple-Tests' }
ExempleSetTest >> testIntegerRendTjrs23 [

	self assert: Integer rendTjrs23 = 23 equals: true
]

{ #category : #tests }
ExempleSetTest >> testIsIpAddress_v1 [

	self
		assert: '192.168.1.1' isIpAddress;
		assert: '192.155.1.0' isIpAddress;
		assert: '255.255.255.255' isIpAddress;
		assert: '0.0.0.0' isIpAddress;
		deny: 'toto' isIpAddress;
		deny: '0.0.0.256' isIpAddress;
		deny: '0.344.0.25' isIpAddress;
		deny: '790.34.0.25' isIpAddress;
		deny: '10.3.256.25' isIpAddress;
		deny: '10.3.6.25.1' isIpAddress;
		deny: '10.3..6.25' isIpAddress;
		deny: '10.3-6.25' isIpAddress
]

{ #category : #tests }
ExempleSetTest >> testIsIpAdress [

	| tmp1 tmp2 |
	tmp1 := '192.168.0.21'.
	self assert: '192.168.0.21' isIpAddress.
	tmp2 := 'toto'.
	self
		deny: tmp2 isIpAddress
		description: 'This string is an IP address ' , tmp2;
		assert: '192.1.1.1' isIpAddress
]

{ #category : #tests }
ExempleSetTest >> testOccurences [

	self
		assert: (empty occurrencesOf: 0) equals: 0;
		assert: (full occurrencesOf: 5) equals: 1.
	full add: 5.
	self assert: (full occurrencesOf: 5) equals: 1
]

{ #category : #tests }
ExempleSetTest >> testQuiContinue [
	" https://eng.libretexts.org/Bookshelves/Computer_Science/Programming_Languages/Book%3A_Pharo_by_Example_5.0_(Ducasse_Zagidulin_Hess_and_Chloupis)/09%3A_SUnit/9.08%3A_Continuing_After_a_Failure
	"
	| tmp1 |
	tmp1 := OrderedCollection withAll: #( 2 10 1 2 3 4 5 6 7 8 9 ).
	tmp1 do: [ :arg1 | 
		self
			assert: arg1 even
			description: 	( arg1 printString , ' n''est pas pair mais je continue le test' )
			resumable: true ].
	self assert: true
]

{ #category : #tests }
ExempleSetTest >> testRemove [

	full remove: 5.
	self
		assert: (full includes: 6);
		deny: (full includes: 5)
]
