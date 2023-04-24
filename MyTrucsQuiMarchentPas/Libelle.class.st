Class {
	#name : #Libelle,
	#superclass : #Object,
	#instVars : [
		'identificateurUnique',
		'dateDeCreation',
		'dateDeMiseAJour',
		'valeur',
		'label',
		'roleProprietaire',
		'regexp',
		'numeroImmobilisation',
		'roleCourant',
		'UrlAide'
	],
	#category : #MyTrucsQuiMarchentPas
}

{ #category : #viewer }
Libelle class >> formatRegexp [
	"format la variable de classe expressionReguliereDict"

	| temporary variable names |
	^'je suis l''expresion reguliere de ', self id printString.
]

{ #category : #'class initialization' }
Libelle class >> initLibelleClassVariable [
	"comment stating purpose of message"

	| temporary variable names |
	traductionDict := Dictionary new.
	traductionDict at: 'un' put: ( ( 'En','english'),('it','italian'),('Fr','french')).
	"traductionDict inspect."
	expressionReguliereArray := Dictionary new.
	expressionReguliereArray at: 1 put: 'regexp-Number-1' ; at: 2 put: 'regexp-Number-2'.
	"expressionReguliereArray  inspect."
	Transcript show: 'J''ai cr‚Äö√Ñ√∂‚àö‚Ä†‚àö‚àÇ¬¨¬®¬¨¬©‚Äö√Ñ√∂‚àö‚Ä†‚àö‚àÇ¬¨¬®¬¨¬© le dictionnaire des labels multilangue et le dict regexp' ; cr ; show: traductionDict printString; cr ; show: expressionReguliereArray printString; cr .

]

{ #category : #format }
Libelle >> formatLibelleAsString [
	"  "

	| s st |
	s := String new.
	st := WriteStream on: (String new).
	st 
		nextPutAll: 'Formating ', self id ; 
	 	nextPutAll: '  ', dateDeCreation printString ;
	 	nextPutAll: '  ', dateDeMiseAJour printString ;
	 	nextPutAll: '  ', valeur printString ;
	 	nextPutAll: '  ', label printString ; 
	 	nextPutAll: '  ',  roleProprietaire printString ;
	 	nextPutAll: '  ',  numeroImmobilisation printString ;
	 	nextPutAll: '  ',  roleCourant printString ;
	 	nextPutAll: '  ',  UrlAide printString.
		
	^st  contents
	
	"
	identificateurUnique dateDeCreation dateDeMiseAJour valeur label roleProprietaire regexp numeroImmobilisation roleCourant UrlAide
	
	
	^st contents.
	"
]

{ #category : #access }
Libelle >> id [
	"comment stating purpose of message"

	| temporary variable names |
	^identificateurUnique printString
]

{ #category : #format }
Libelle >> ps [
	"  "

	| temporary variable names |
	^'je me suis imprime moi meme'
]

{ #category : #'initialize-release' }
Libelle >> randomize: r [
	"on remplit un libelle automatiquement pour faire tourner " 

	| | 
	identificateurUnique := 'Id-',r printString.
	dateDeCreation := DateAndTime now.
	dateDeMiseAJour := DateAndTime now.
	valeur := 1234+r.
	label := 'MonLabelEst-',r printString.
	roleProprietaire := 'rolepro'.
	regexp := expressionReguliereArray at: 1.
	numeroImmobilisation := 'Immo-',r printString.
	roleCourant := 'roleCti' .
	UrlAide := 'http://localhost/',r printString, '.html'.
	^self
	
]
