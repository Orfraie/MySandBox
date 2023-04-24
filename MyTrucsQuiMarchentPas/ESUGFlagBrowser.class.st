Class {
	#name : #ESUGFlagBrowser,
	#superclass : #SpPresenter,
	#instVars : [
		'flags',
		'locations',
		'code'
	],
	#category : #MyTrucsQuiMarchentPas
}

{ #category : #layout }
ESUGFlagBrowser class >> defaultLayout [

	" a comment "

	^ SpPanedLayout newHorizontal
		  positionOfSlider: 30 percent;
		  add: (SpBoxLayout newVertical
				   add: 'Flags'
				   expand: false
				   fill: false
				   padding: 0;
				   add: #flags;
				   yourself);
		  add: (SpPanedLayout newVertical
				   add: #locations;
				   add: #code;
				   yourself);
		  yourself
]

{ #category : #initialization }
ESUGFlagBrowser >> connectPresenters [ 
	" a comment "
	flags 
		transmitTo: locations 
		transform: [  :flag | flag locations ]
		postTransmission: [  :destination | destination selectIndex: 1 ].
	
	locations 	
		transmitTo: code
		transform: [  :location | location sourceCode ]
		postTransmission: [  :destination :origin :location | 
			destination
				behavior: location classLocation ;
				setSelection: location interval ].
	
	flags items: FBSymbolFlag allflags ;
		selectIndex:  1.
		
	flags whenSelectionChangedDo: [  :flag | self withWindowDo: [  :w | w title: self title ] ]
]

{ #category : #initialization }
ESUGFlagBrowser >> initializePresenter [ 
	" A comment "
	flags := self newList.
	locations := self newTable.
	code := self newCode.
	flags 
		display: [  :flag | flag parameter ] ;
		sortingBlock: [ :flag | flag parameter ] ascending.
	locations
		addColumn: ( SpStringTableColumn title: 'Class' evaluated:  [ :location | location classLocation ] ) ;
		addColumn: ( SpStringTableColumn title: 'Method' evaluated:  [ :location | location selector ] ).
	
]

{ #category : #initialization }
ESUGFlagBrowser >> initializeWindow: aWindowPresenter [
	aWindowPresenter 
		title: self title ;
		initialExtent:  500@600
]

{ #category : #'as yet unclassified' }
ESUGFlagBrowser >> selectedFlag [
	^ flags selectedItem
]

{ #category : #'as yet unclassified' }
ESUGFlagBrowser >> selectedLocation [
	^ locations selectedItem
]

{ #category : #accessing }
ESUGFlagBrowser >> title [ 
	^ self selectedFlag parameter
]
