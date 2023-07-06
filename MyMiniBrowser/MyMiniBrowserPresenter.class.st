Class {
	#name : #MyMiniBrowserPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'treeClasses',
		'button',
		'codeShower',
		'methodsList',
		'methodsFilteringList'
	],
	#category : #MyMiniBrowser
}

{ #category : #'button actions' }
MyMiniBrowserPresenter >> buttonAction [
 
    | newShower |
    button label = 'Edit'
        ifTrue: [ 
            button label: 'Read only'.
            newShower := self newCode ]
        ifFalse: [ 
            button label: 'Edit'.
            newShower := self newText beNotEditable ].
 
    newShower text: methodsFilteringList selectedItem ast formattedCode.
"Ici bug ! ast send to nil while no method available in selectedItem "
 	 newShower text: methodsFilteringList selectedItem ast formattedCode.
    self layout replace: codeShower with: newShower.
    codeShower := newShower
]

{ #category : #initialization }
MyMiniBrowserPresenter >> connectPresenters [
 	" "
    treeClasses whenActivatedDo: [ :selection | 
        methodsFilteringList items: selection selectedItem methods ].
     
    methodsFilteringList listPresenter
        whenSelectedDo: [ :selectedMethod | 
            codeShower text: selectedMethod ast formattedCode ].
     
    button action: [ self buttonAction ]
]

{ #category : #initialization }
MyMiniBrowserPresenter >> initializeLayout [
 
    | classesAndMethodsLayout |
    classesAndMethodsLayout := SpBoxLayout newLeftToRight.
    classesAndMethodsLayout
        spacing: 10;
        add: treeClasses;
        add: methodsFilteringList.
    self layout: (SpBoxLayout newTopToBottom
        spacing: 5;
        add: classesAndMethodsLayout;
        add: codeShower;
        add: button expand: false;
        yourself)
]

{ #category : #initialization }
MyMiniBrowserPresenter >> initializePresenters [
 	"First we are going to instantiate the tree presenter. We want the tree presenter to show all the classes that are presented in the Pharo image. We know that all subclasses (almost) inherit from Object. So, that is going to be the only root of the tree. To get the subclasses of a class we can send the message subclasses, that is what we need to get the children of a node. We want to each of the nodes (clases) have a nice icon, we can get the icon of a class with the message systemIcon. Finally, we want to “activate” the presenter with only one click instead of two. The code will be:"

    treeClasses := self newTree.
    treeClasses
       activateOnSingleClick;
       roots: Object asOrderedCollection;
       children: [ :each | each subclasses ];
       displayIcon: [ :each | each systemIcon ].

    methodsFilteringList := self newFilteringList.
    methodsFilteringList display: [ :method | method selector ].
    methodsFilteringList listPresenter
        sortingBlock: [ :method | method selector ] ascending.
 
    button := self newButton.
    button
        label: 'Read Only';
        icon: (self iconNamed: #smallConfiguration).
 
    codeShower := self newText.
    codeShower beNotEditable.
    self initializeLayout
]

{ #category : #initialization }
MyMiniBrowserPresenter >> initializeWindow: aWindowPresenter [
 
    aWindowPresenter
        title: 'My Mini Browser';
        initialExtent: 750 @ 650
]
