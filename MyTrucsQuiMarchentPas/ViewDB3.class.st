Class {
	#name : #ViewDB3,
	#superclass : #Object,
	#instVars : [
		'list',
		'debug',
		'dict',
		'indexSelected',
		'nameSelected'
	],
	#category : #MyTrucsQuiMarchentPas
}

{ #category : #'as yet unclassified' }
ViewDB3 >> addItem [
	" Rajoute un item dans la base,..."
	||
	nameSelected := 'key-',Time now printString.
	dict at: nameSelected put: 'String-',Time now printString.
	indexSelected := 0. " deselecting any item"
	LogV1 logit: 'aIt' msg: 'namedSelectd Add by ??'.
	self changed: #list.
]

{ #category : #'as yet unclassified' }
ViewDB3 >> copieNameSelected [
	"retourne un text recopiant namedSelected"

	| temporary variable names |
	dict at: nameSelected ifAbsent:  [ ^'nil']. 
	^ ( dict at: nameSelected ) printString
	"^'Donnees bidon a logger qaund selectedName Change ' , nameSelected printString" 
]

{ #category : #'as yet unclassified' }
ViewDB3 >> idle [
	"   " 
	| |
	LogV1 logit: 'idle' msg: 'Idle Called et ne fait rien.'. 
	
]

{ #category : #'as yet unclassified' }
ViewDB3 >> importPrPo [
	" Ca charge le Pr PO ou n'importe quel fichier CSV, le seul truc a customizer,
	c'est le nom du champ qui doit servir de cle d'acces au dictionnaire
	"

	| aLine inputStream i buf key t |
	key := 2.
	t := Time now asSeconds.
	LogV1 logit: 'iPP' msg: 'Loading a CSV file using ', CSVParser separator printString, ' as separator.' . 
	dict size > 0
		ifTrue: [ 
			LogV1 logit: 'iPP' msg: 'importPrPo:  dict NOT empty';
				cr.
			^ self ].
	i := 0.
	"Qualiparc_pr_v2-20101101_060004.csv           pr_v2_FULL_8859-15.csv      pr_v2_SMALL_8859-15.csv"
	inputStream := CrLfFileStream readOnlyFileNamed: 'DG_Files/DATA/pr_v2_SMALL_8859-15.csv'.
     [ inputStream atEnd ]
		whileFalse: [ 
			aLine := inputStream upTo: Character cr.
			aLine size < 10 ifTrue: [ 
				LogV1 logit: 'iPP' msg: 'Jumping line ', i printString.
				aLine := inputStream  upTo: Character cr. i := i + 1 . ].
			buf := (CSVParser parseString: aLine) at: 1.
			"parseString retourne une collection de collections,... il n ''y en a qu''une, d'' ou le at: 1"
			buf size > 1 
			ifTrue: [ 
				buf at: 1.
				dict at: (buf at: key) put: buf.	
				]
			ifFalse: [self error: 'Impossible,...'].
			i \\ 100 = 0
				ifTrue: [ 
					self changed: #list.
					LogV1 logit: 'iPP' msg: i printString , ' records loaded,. dict size is ' , dict size printString .
					Transcript show:  i printString , ' records loaded,. dict size is ' , dict size printString ; cr .
				 ].
			i := i + 1.
			].
	inputStream close.
	LogV1 logit: 'iPP' msg: i printString , '  records loaded ,  elapsed used ' , (Time now asSeconds - t) printString, '  seconds. '.
	self changed: #list
]

{ #category : #'as yet unclassified' }
ViewDB3 >> initializeDict [
	""
| indexSelectedInKeys |
dict := Dictionary new.
indexSelected := 0.
nameSelected := nil.
]

{ #category : #'as yet unclassified' }
ViewDB3 >> list [

	debug ifTrue: [LogV1 logit: 'list' msg:  'List' .].
	^dict keys asSortedCollection
]

{ #category : #'as yet unclassified' }
ViewDB3 >> listIndex [
	" "

	| s |
	
	LogV1 logit: 'lIn' msg: 'ListIndex,      indexSelected is ' , indexSelected printString, ',  key=' , nameSelected printString  .
	^ indexSelected
]

{ #category : #'as yet unclassified' }
ViewDB3 >> listIndex: anInteger [
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
	self changed: #copieNameSelected.

]

{ #category : #'as yet unclassified' }
ViewDB3 >> listMenu: aMenu [
	| targetClass differentMenu className s |
	LogV1 logit: 'lMe' msg: 
		 'Menu: indexSelected is ' , indexSelected printString, 
		 ',  namedSelected is ' , nameSelected printString ,
		 ',  sizeDict is ' , dict size printString .
	differentMenu := MenuMorph new.
	( dict size = 0 ) ifTrue: [
		differentMenu 
		add: 'Add' target: self selector: #addItem ;
		add: 'Load' target: self selector: #load ;
		add: 'Import' target: self selector: #importPrPo.
		].
	( dict size > 0 and: [ indexSelected = 0 ]) ifTrue: [
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
ViewDB3 >> load [
	| t tt i |
	t := Time now asSeconds.
	tt := ReferenceStream fileNamed: 'assetdb.obj'.
	LogV1 logit: 'load' msg:  'Filing in a serialized view of assetdb from file assetdb.obj,....  (Warning, taking 5 or 6 minutes)  '.
	dict := tt next.
	tt close.
	LogV1 logit: 'load' msg: dict size printString , ' Records loaded ,  elapsed used ' , (Time now asSeconds - t) printString , '  seconds. '.
	self changed: #list
]

{ #category : #'as yet unclassified' }
ViewDB3 >> openView [

"
ViewDB3 new openView
C'est une migration brute de decoffrage venat de ST/V , evidemment , il y a une palanquée de Don't understand.
On n'y touche pas pour l'instant DG 2022 aout 11
"

| window aListMorph aTextMorph bi0  bi1 bi2 bi3 bl1 bl2 bl3 bl4 bl5 |
debug := true.
self initializeDict.  
" le logging, un peu particulier "
LogV1 reset ; init ; resetDebug . 
LogV1 logit: 'oV' msg:  'Init dict done, debug is ', debug printString. 

indexSelected := 0.
aListMorph := PluggableListMorph
	on: self
	list: #list
	selected: #listIndex
	changeSelected: #listIndex:
	menu: #listMenu:.
aTextMorph :=	PluggableTextMorph  
    on: self  
    text: #copieNameSelected
    accept: nil.
bi0 := PluggableButtonMorph on: [LogV1 logit: 'oV' msg: 'Filtre Bip!'] getState: nil 	action: #value . bi0 label: 'Filtres'.
bi2 := PluggableButtonMorph on: [LogV1 logit: 'oV' msg: 'Bi2 Bip onTranscript !!'] getState: nil 	action: #value . bi2 label: 'bi2!!'.
bi3 := PluggableButtonMorph on: [LogV1 logit: 'oV' msg: 'bi3 Bip onTranscript !!'] getState: nil 	action: #value . bi3 label: 'bi3!!'.
bl2 := PluggableButtonMorph on: [LogV1 logit: 'oV' msg: 'bl2 Bip onTranscript !!'] getState: nil 	action: #value . bl2 label: 'bl2!!'.
bl3 := PluggableButtonMorph on: [LogV1 logit: 'oV' msg: 'bl3 Bip onTranscript !!'] getState: nil 	action: #value . bl3 label: 'bl3!!'.
bl4 := PluggableButtonMorph on: [LogV1 logit: 'oV' msg:  'bl4 Bip onTranscript !!'] getState: nil 	action: #value . bl4 label: 'bl4!!'.
bl5 := PluggableButtonMorph on: [LogV1 logit: 'oV' msg:  'bl5 Bip onTranscript !!'] getState: nil 	action: #value . bl5 label: 'bl5!!'.


window := SystemWindow labelled: 'ViewDB3 : AssetDB with a Dictionary'.
window color: Color blue ;
	addMorph: aListMorph frame: (0 @ 0.04 extent: 0.2 @ 0.96);
	addMorph: aTextMorph frame: (0.2@0 extent: 0.3@0.6 ) ;
	addMorph: (LogV1 aTM) frame: (0.2@0.6 extent: 0.8@0.4);
	" ESPACE BOUTONS, a redefinir...."
	addMorph: bi0 frame: ( 0@0 extent: 0.2@0.04);
	addMorph: bi2 frame: (0.5 @ 0.04 extent: 0.2 @ 0.56) ;
	addMorph: bi3 frame: (0.7@0 extent: 0.3@0.6) ;
	addMorph: bl2 frame: (0.5@0 extent: 0.05@0.05);
	addMorph: bl3 frame: (0.55@0 extent: 0.05@0.05);
	addMorph: bl4 frame: (0.6@0 extent: 0.05@0.05);
	addMorph: bl5 frame: (0.65@0 extent: 0.05@0.05).
	
^window openInWorldExtent: 800 @ 600
]

{ #category : #'as yet unclassified' }
ViewDB3 >> removeAllItem [
	" remove all Item dans la base,..."
	||
	debug ifTrue: [LogV1 logit: 'rAI' msg: 'FromremoveAllItem.'].
	dict := Dictionary new.
	nameSelected := nil.
	indexSelected := 0.
	self changed: #list.
]

{ #category : #'as yet unclassified' }
ViewDB3 >> removeItem [
	" remove un item dans la base,..."
	||
	debug ifTrue: [Transcript  show: 'FromremoveItem: nameSelected ', nameSelected printString, ' removed' ; cr. ].
	dict removeKey: nameSelected ifAbsent: [].
	nameSelected := nil.
	indexSelected := 0.
	self changed: #list.
]

{ #category : #'as yet unclassified' }
ViewDB3 >> store [ 

	" filer object to disk file called assedb.obj " 
	| rr t |
	t := Time now asSeconds.
	rr := ReferenceStream fileNamed: 'assetdb.obj'.
	LogV1 logit: 'stor' msg: 'Filing out a serialized view of assetdb in file assetdb.obj,....    ' .
	rr nextPut: dict.
	rr close.
	LogV1 logit: 'stor' msg:  dict size printString , ' Records loaded ,  elapsed used ' , (Time now asSeconds - t) printString , '  seconds. '.
 

]
