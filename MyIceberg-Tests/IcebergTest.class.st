Class {
	#name : #IcebergTest,
	#superclass : #TestCase,
	#category : #'MyIceberg-Tests'
}

{ #category : #example }
IcebergTest class >> testIcebergReportOnTranscript [
	" In a Transcript, IcebergTest icebergTestReportOnTranscript. "
	Transcript cr; show: '!!!!! ' ; show: 'Coming from Icebergtest class Method to write event onTranscript.' ; cr .
]

{ #category : #tests }
IcebergTest >> testIt [ 
	" Test du test , si , si "
	Transcript show: 'Je suis dans le test du Test de icebergTest' ; cr .
]
