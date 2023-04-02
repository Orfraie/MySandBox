Class {
	#name : #IcebergTest,
	#superclass : #Object,
	#category : #MyIcebergTest
}

{ #category : #example }
IcebergTest class >> icebergTestReportOnTranscript [
	" In a Transcript, IcebergTest icebergTestReportOnTranscript. "
	Transcript cr; show: '!! ' ; show: 'Coming from Icebergtest class Method to write event onTranscript.' ; cr .
]
