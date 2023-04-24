Extension { #name : #ZnEncodedReadStream }

{ #category : #'*MyTrucsQuiMarchentPas' }
ZnEncodedReadStream >> skipSeparators [
	" Recopier de la V5 et modifier pour que ca tourne en V10"
	|  character |
	[ 
		" state := converter saveStateOf: self."
		(character := self next) 
			ifNil: [ false ]
			ifNotNil: [ character isSeparator ] ] whileTrue.
	"character ifNotNil: [ 
		converter restoreStateOf: self with: state ]"
]
