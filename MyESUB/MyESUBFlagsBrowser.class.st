Class {
	#name : #MyESUBFlagsBrowser,
	#superclass : #SpPresenter,
	#instVars : [
		'flags',
		'locations',
		'code',
		'textPresenter'
	],
	#category : #MyESUB
}

{ #category : #layout }
MyESUBFlagsBrowser class >> defaultLayout [

	 	"^ SpPanedLayout newTopToBottom add: #code ; yourself "
	 	"^ SpPanedLayout new add: #code ; yourself 	"
	^ SpPanedLayout newHorizontal
		  positionOfSlider: 30 percent;
		  add: (SpBoxLayout newVertical
				   add: 'Liste des bateaux'
				   expand: false
				   fill: false
				   padding: 0;
				   add: #flags;
				   yourself);
		  add: (SpPanedLayout newVertical
				   add: #locations; 
				   add: #code;
				   yourself ); 
		  yourself
		
	
]

{ #category : #initialization }
MyESUBFlagsBrowser >> initializePresenters [
	""
	flags := self newList. "Not a real list , just a SpListPresenter"
	locations := self newTable.
	code := self newCode.
	textPresenter := self newText.
	textPresenter 
		text: 'toto';
		beNotEditable.
	"flags items: self class environment allClasses ;
			contextMenu: self flagsMenu.
	"
]
