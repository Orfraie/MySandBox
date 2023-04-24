Class {
	#name : #AnimalHabitat,
	#superclass : #Object,
	#instVars : [
		'Animal',
		'nom'
	],
	#category : #'MyCours-Smalltalk-Animal'
}

{ #category : #viewer }
AnimalHabitat class >> eraseAllAnimalHabitatInstances: aBoolean [
	"elimine toute instance de la classe"

	| liste u |
	liste := AnimalHabitat allInstances asArray.
	aBoolean ifTrue: [
	Transcript
		cr;
		show: liste size asString , '      ' , liste asString;
		cr.
	1 to: liste size do: [ :i | 
		u := (liste at: i) Animal asString.
		Transcript
			show: '---' , i asString , '      ' , (liste at: i) asString , '   habité par ' , u , ' will be destroyed ' ; cr.
			i become: nil.
		].
	].
	"AnimalHabitat allInstances do: [ :each | each become: nil ] ."
	^'cleaned.'
]

{ #category : #viewer }
AnimalHabitat class >> show [
	" Liste tous les Animal de tous les habitats de AnimalHabitat"
	| s cr | 
	s := ' '.
	cr := 10 asCharacter asString.
	s := s,' Nbers of instances in AnimalHabitat is ', self allInstances size asString, cr.
	self allInstances 
	do: [ :i | 
		s := s, cr,'---Habitat de type [' , i nom asString, ']'.  
		s := s,' with :' .
		i Animal isNil
			ifFalse: [ ( i Animal asArray ) do: [ :k | s := s , cr, '    -->' , k show ]]
			ifTrue: [ s := s, cr ,'    -->' , 'NoPetInIt!']..
		]. 
	Transcript show: s . 
	s := ''.
]

{ #category : #'initialize-release' }
AnimalHabitat >> Animal [ 
	"retourne l'ensemble des Animal habitant le receveur'"

^Animal 
]

{ #category : #'initialize-release' }
AnimalHabitat >> Animal: aSet [
	"initialize la variable Animal"
	Animal := aSet 
 
]

{ #category : #'initialize-release' }
AnimalHabitat >> AnimalName [
	"retourne l'ensemble des noms des Animal habitant le receveur'"
| s |
s := ''.
Animal isNil ifFalse: [ self Animal do: [ :i | s := s , i nom ] ].
^s
]

{ #category : #'initialize-release' }
AnimalHabitat >> ajoute: unAnimal [
	"ajoute un Animal a cet habitat et informe l'Animal de son habitat"
	self Animal isNil
		ifTrue: [self Animal: Set new].
	self Animal add: unAnimal.
]

{ #category : #'initialize-release' }
AnimalHabitat >> nom [
	"donne un nom à l'habitat"
	^nom
 

]

{ #category : #'initialize-release' }
AnimalHabitat >> nom: aString [
	"donne un nomà l'habitat"
	nom := aString
 

]

{ #category : #viewer }
AnimalHabitat >> show [
	"Liste tous les occupants de cet habitat"
	self Animal do:
		[ :unAnimal | Transcript show: '---',unAnimal ; cr ]
]
