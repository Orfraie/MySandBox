Extension { #name : #String }

{ #category : #'*MyExemple-Tests' }
String >> isIpAddress [

	| tmp1 tmp2 |
	(self size > 15 or: [ self size < 7 ]) ifTrue: [ ^ false ].
	tmp2 := (self reject: [ :arg1 | '0123456789.' asSet includes: arg1 ])
		        isEmpty.
	tmp2 ifFalse: [ ^ false ].
	tmp1 := self splitOn: '.'.
	tmp2 := tmp1 size = 4.
	tmp2 ifFalse: [ ^ false ].
	tmp2 := (tmp1 select: [ :arg2 | 
		         arg2 asInteger < 0 or: [ arg2 asInteger > 255 ] ]) isEmpty.
	tmp2 ifFalse: [ ^ false ].
	^ true
]

{ #category : #'*MyExemple-Tests' }
String >> isIpAddressOLD [

	| tmp2 |
	tmp2 := 0.
	self isEmpty ifTrue: [ ^ false ].
	self isEmpty ifTrue: [ ^ false ].
	self size > 15 ifTrue: [ ^ false ].
	(self reject: [ :arg1 | '0123456789.' asSet includes: arg1 ])
		isNotEmpty ifTrue: [ ^ false ].
	self do: [ :arg2 | arg2 = $. ifTrue: [ tmp2 := tmp2 + 1 ] ].
	tmp2 = 3 ifFalse: [ ^ false ].
	^ true
]
