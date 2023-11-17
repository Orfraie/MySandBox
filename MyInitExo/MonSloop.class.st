Class {
	#name : #MonSloop,
	#superclass : #Object,
	#instVars : [
		'a1mat'
	],
	#classVars : [
		'CntSloop'
	],
	#category : #MyInitExo
}

{ #category : #initialization }
MonSloop >> initialize [ 
	" "
	CntSloop ifNil: [CntSloop := 0].
	CntSloop	:= CntSloop + 1  .
	a1mat := true.		

]
