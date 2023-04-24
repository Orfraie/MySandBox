Class {
	#name : #ViewDB2,
	#superclass : #Object,
	#instVars : [
		'list',
		'debug',
		'dict',
		'indexSelected',
		'nameSelected'
	],
	#category : #'MyAsset-MGT'
}

{ #category : #'as yet unclassified' }
ViewDB2 >> addItem [
	" Rajoute un item dans la base,..."
	||
	nameSelected := 'key-',Time now printString.
	dict at: nameSelected put: 'String-',Time now printString.
	indexSelected := 0. " deselecting any item"
	self changed: #list.
]

{ #category : #waiting }
ViewDB2 >> idle [
	"   " 
	| |
	Transcript show: 'sinon attendre une seconde, idle ne fait rien.' ;cr. 
	( Delay forSeconds: 1 ) wait.
]

{ #category : #importing }
ViewDB2 >> importPrPo [
	" Ca charge le Pr PO ou n'importe quel fichier CSV, le seul truc a customizer,
	c'est le nom du champ qui doit servir de cle d'acces au dictionnaire
	"

	| aLine inputStream i buf key t f |
	key := 2.
	t := Time now asSeconds.
	Transcript 
	  nextPutAll: 'Loading a CSV file using '; 
	  nextPutAll: CSVParser separator printString ; 
	  nextPutAll:  ' as separator.' ; 
	  cr. 
	dict isNotEmpty
		ifTrue: [ 
			Transcript
				show: 'importPrPo:  dict NOT empty';
				cr.
			^ self ].
	i := 0.
	f := 'DG_Files_Historique/DATA/aaa.csv' asFileReference.
	inputStream := f readStream. 
     [ inputStream atEnd ]
		whileFalse: [ 
			aLine := inputStream upTo: Character cr.
			aLine size < 10 ifTrue: [ 
				Transcript nextPutAll: 'Jumping line ' ; nextPutAll: i printString ; cr ; endEntry .
				aLine := inputStream  upTo: Character cr. i := i + 1 . ].
			buf := (CSVParser parseString: aLine) at: 1.
			"parseString retourne une collection de collections,... il n ''y en a qu''une, d'' ou le at: 1"
			buf size > 1 ifTrue: [ 
				buf at: 1.
				dict at: (buf at: key) put: buf.	
				]
			ifFalse: [self error: 'Impossible,...'].
			i \\ 10 = 0
				ifTrue: [ 
					Transcript
						nextPutAll: i printString ;
						nextPutAll: ' records loaded,...dict size is ' ;
						nextPutAll: dict size printString ;
						cr ; endEntry].
			i := i + 1.
			].
	inputStream close.
	Transcript
		nextPutAll: i printString ; 
		nextPutAll: '  records loaded ,  elapsed used ' ;
		nextPutAll: (Time now asSeconds - t) printString ;
		nextPutAll: '  seconds. ' ;
		cr.
	self changed: #list
]

{ #category : #initalize }
ViewDB2 >> initializeLDict [
	""
|  |
dict := Dictionary new.
indexSelected := 0.
nameSelected := nil.
]

{ #category : #'set and get' }
ViewDB2 >> list [

	debug ifTrue: [Transcript nextPutAll: 'List' ; cr .]. 
	^dict keys asSortedCollection
]

{ #category : #'as yet unclassified' }
ViewDB2 >> listIndex [
	" "

	|  |
	debug ifTrue: [  
	   Transcript
		nextPutAll: 'ListIndex,      indexSelected is ' ;
		nextPutAll: indexSelected printString ;
		nextPutAll: ',  key=' ;
		nextPutAll: nameSelected printString ; 
		cr ; endEntry ] .
	
	^ indexSelected
]

{ #category : #'as yet unclassified' }
ViewDB2 >> listIndex: anInteger [
	" "

	| t |
	indexSelected  := anInteger.

	indexSelected  = 0 
		ifFalse: [ nameSelected  := ( dict keys asSortedCollection) at: indexSelected ]
		ifTrue: [ nameSelected := nil ].
	"
	Transcript
		show: 'ListIndex:      indexSelected is ' , indexSelected printString ;
		show: ',  nameSelected=', nameSelected printString ;
		show: ',  sizeList is ' , dict size printString;
		cr.
	"
	self changed: #listIndex.
]

{ #category : #'file list menu' }
ViewDB2 >> listMenu: aMenu [
	| differentMenu |
	Transcript
		show: 'Menu: indexSelected is ' , indexSelected printString;
		show: ',  namedSelected is ' , nameSelected printString;
		show: ',  sizeDict is ' , dict size printString;
		cr.
	differentMenu := MenuMorph new.
	dict isEmpty  ifTrue: [
		differentMenu 
		add: 'Add' target: self selector: #addItem ;
		add: 'Load' target: self selector: #loadAssetDB ;
		add: 'Import' target: self selector: #importPrPo.
		].
	( dict isNotEmpty and: [ indexSelected = 0 ]) ifTrue: [
		differentMenu 
		add: 'Add' target: self selector: #addItem ;
		add: 'Store' target: self selector: #store ;
		add: 'DeleteAll' target: self selector: #removeAllItem .
		].
	( indexSelected > 0 and: [ nameSelected notNil  ]) ifTrue: [
		differentMenu 
		add: 'Del' target: self selector: #removeItem;
		add: 'Inspect' target: ( dict at: nameSelected ) selector: #inspect.
		].
	^differentMenu 
	"
	s := dict size.
	s = 0 ifFalse: [Transcript show: 'false' ].
	s > 0 ifFalse: [ Transcript show: 'true'] .
	s > 0 ifFalse: [ 
			differentMenu
				add: 'Add' target: self selector: #addItem;
				add: 'Load' target: self selector: #idleAction;
				add: 'Import' target: self selector: #idleAction. 
				].
 
	( s > 0 and: [ nameSelected isNil not ] )
	ifTrue: [ 
			differentMenu
				add: 'Add' target: self selector: #addItem;
				add: 'Remove' target: self selector: #removeItem;
				add: 'Load' target: self selector: #idleAction;
				add: 'Save' target: self selector: #idleAction;
				add: 'ViewItem on Transcript' target: self selector: #viewItemOnTranscript;
				add: 'explore' target: nameSelected selector: #explore;
				add: 'inspect' target: (dict at: nameSelected) selector: #inspect ]
	ifFalse: [ differentMenu add: 'Add' target: self selector: #addItem].
			
	^ differentMenu
	"
]

{ #category : #'as yet unclassified' }
ViewDB2 >> loadAssetDB [
	| t tt i |
	t := Time now asSeconds.
	tt := ( 'DG_Files_Historique/DATA/assetdb.obj' asFileReference ) readStream .
	Transcript show: 'Filing in a serialized view of assetdb from file assetdb.obj,....    '.
	dict := tt next.
	tt close.
	Transcript nextPutAll: dict size printString ; nextPutAll: ' Records loaded ,  elapsed used ' ; 	nextPutAll: (Time now asSeconds - t) printString ; nextPutAll:  '  seconds. '; cr.
	self changed: #list
]

{ #category : #initalize }
ViewDB2 >> openView [

"
ViewDB2 new openView
"

| window aListMorph bi0 bi1 bi2 bi3 bl1 bl2 bl3 bl4 bl5 |
debug := true.
self initializeLDict.  
Transcript nextPutAll: 'Init dict done, debug is ' ; nextPutAll: debug printString ; cr . 

indexSelected := 0.
aListMorph := PluggableListMorph
	on: self
	list: #list
	selected: #listIndex
	changeSelected: #listIndex:
	menu: #listMenu:.
bi0 := PluggableButtonMorph on: [Transcript show: 'bi0 Bip onTranscript !!'; cr] getState: nil 	action: #value . bi0 label: 'bi0!!'.
bi1 := PluggableButtonMorph on: [Transcript show: 'bi1 Bip onTranscript !!'; cr] getState: nil 	action: #value . bi1 label: 'bi1!!'.
bi2 := PluggableButtonMorph on: [Transcript show: 'bi2 Bip onTranscript !!'; cr] getState: nil 	action: #value . bi2 label: 'bi2!!'.
bi3 := PluggableButtonMorph on: [Transcript show: 'bi3 Bip onTranscript !!'; cr] getState: nil 	action: #value . bi3 label: 'bi3!!'.
bl1 := PluggableButtonMorph on: [Transcript show: 'bl1 Bip onTranscript !!'; cr] getState: nil 	action: #value . bl1 label: 'bl1!!'.
bl2 := PluggableButtonMorph on: [Transcript show: 'bl2 Bip onTranscript !!'; cr] getState: nil 	action: #value . bl2 label: 'bl2!!'.
bl3 := PluggableButtonMorph on: [Transcript show: 'bl3 Bip onTranscript !!'; cr] getState: nil 	action: #value . bl3 label: 'bl3!!'.
bl4 := PluggableButtonMorph on: [Transcript show: 'bl4 Bip onTranscript !!'; cr] getState: nil 	action: #value . bl4 label: 'bl4!!'.
bl5 := PluggableButtonMorph on: [Transcript show: 'bl5 Bip onTranscript !!'; cr] getState: nil 	action: #value . bl5 label: 'bl5!!'.



window := SystemWindow labelled: 'ViewDB2 : AssetDB with a Dictionary'.
window color: Color blue ;
	addMorph: aListMorph frame: (0 @ 0.04 extent: 0.2 @ 0.96);
	addMorph: bi0 frame: (0 @ 0 extent: 0.2 @ 0.04 );  
	addMorph: bi1 frame: (0.2@0 extent: 0.3@0.6 ) ;
	addMorph: bi2 frame: (0.5 @ 0.04 extent: 0.2 @ 0.56) ;
	addMorph: bi3 frame: (0.7@0 extent: 0.3@0.6) ;
	addMorph: bl1 frame: (0.2@0.6 extent: 0.8@0.4);
	" ESPACE BOUTONS,...."
	addMorph: bl2 frame: (0.5@0 extent: 0.05@0.05);
	addMorph: bl3 frame: (0.55@0 extent: 0.05@0.05);
	addMorph: bl4 frame: (0.6@0 extent: 0.05@0.05);
	addMorph: bl5 frame: (0.65@0 extent: 0.05@0.05).
	
^window openInWorld extent: 800 @ 600
]

{ #category : #removing }
ViewDB2 >> removeAllItem [
	" remove all Item dans la base,..."
	||
	debug ifTrue: [Transcript  show: 'FromremoveAllItem.' ; cr. ].
	dict := Dictionary new.
	nameSelected := nil.
	indexSelected := 0.
	self changed: #list.
]

{ #category : #removing }
ViewDB2 >> removeItem [
	" remove un item dans la base,..."
	||
	debug ifTrue: [Transcript  show: 'FromremoveItem: nameSelected ' ; nextPutAll: nameSelected 	printString ; nextPutAll: ' removed' ; cr. ].
	dict removeKey: nameSelected ifAbsent: [].
	nameSelected := nil.
	indexSelected := 0.
	self changed: #list.
]

{ #category : #update }
ViewDB2 >> storeAssetDB [

	" filer object to disk file called assedb.obj " 
	| rr t |
	t := Time now asSeconds.
	rr := ( 'DG_Files_Historique/DATA/assetdb.obj' asFileReference ) writeStream .
	Transcript show: 'Filing out a serialized view of assetdb in file assetdb.obj,....    ' ; cr .
	rr nextPut: dict.
	rr close.
	Transcript 
		nextPutAll: dict size printString ; 
		nextPutAll:  ' Records loaded ,  elapsed used ' ;
		nextPutAll: (Time now asSeconds - t) printString ; 
		nextPutAll: '  seconds. '; 
		cr.
 

]
