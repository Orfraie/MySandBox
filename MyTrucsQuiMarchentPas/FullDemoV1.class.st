Class {
	#name : #FullDemoV1,
	#superclass : #Object,
	#instVars : [
		'window'
	],
	#category : #MyTrucsQuiMarchentPas
}

{ #category : #example }
FullDemoV1 class >> example [
	"Similar to ListDemo1, but shows how to create two column pluggable
	 list morph.
	
	FullDemoV1 example
	"

	| model button object listMorph1 listMorph2 buttonMorph1 buttonMorph3 buttonMorph4 buttonMorph2 window textMorph1 textMorph2 object1 cinemaPane tableADessinPane |
	"Creation of models."
	object := ListDemo2Object new.
	object1 := TextDemo1Object new.	

	"Creates two text morph on the common model.
	 If you change (if you have finished with changing
	 the string, press Alt+S) the string in one of the text morphs,
	 this will affect also the other on" 
	textMorph1 := PluggableTextMorph on: object1 text: #text accept: #text:.
	textMorph2 := PluggableTextMorph on: object1 text: #text accept: #text:.

	"Creates new button showing the (stringified) value of its model.
	 User's click will cause change the value from 0 to 1 and vice versa of the model " 
	model := ButtonDemo2Object new.
	buttonMorph2 := PluggableButtonMorph on: model getState: nil action: #act label: #asString.
		
	"Creates new button which, when clicked, will cause the string 'something'
	     been shown on Transcript
	 Selector #value will be sent to the given model (block context instance)
	     whenever user clicks the button"
	buttonMorph1 := PluggableButtonMorph
		on: [Transcript show: 'Bip onTranscript !!'; cr]
		getState: nil 
		action: #value.
	buttonMorph1 label: 'Bip!!'.
	"buttonMorph3 label: 'Futur ListPane'.
	buttonMorph4 label: 'Futur textPane'.
	buttonMorph3 label: 'FuturListPane'.
	cinemaPane label: 'Futur cinemaPane'.
	tableADessinPane label: 'TableADessinPane'.
	buttonMorph4 label: 'Futur textPane'."
	listMorph1 := PluggableMultiColumnListMorph "Creation of the first list morph."
		on: object
		list: #list
		selected: #select
		changeSelected: #select:.	"Creation of the second list morph."
	listMorph2 := PluggableMultiColumnListMorph
		on: object
		list: #list
		selected: #select
		changeSelected: #select:.
	window := SystemWindow labelled: 'FullDemoV1 (old ListDem2) called by example and  encapsulated in a SystemWidow'.
	window	color: Color blue;
	"Ca donne 2 colonnes verticales 
	addMorph: listMorph1 frame: (0 @ 0 corner: 1/2 @ 1) ;
	addMorph: listMorph2 frame: (1/2 @ 0 corner: 1 @ 1).
	Ca donne 2 colonnes horizontales 
	addMorph: listMorph1 frame: (0@0 extent: 1@0.5 ) ;
	addMorph: listMorph2 frame: (0 @ 0.5 corner: 1 @ 1).
	Ca donne 2 carr‚Äö√Ñ√∂‚àö√ë‚àö‚àÇ‚Äö√†√∂‚Äö√Ñ‚Ä†‚Äö√†√∂‚Äö√†√á¬¨¬®¬¨¬Æ¬¨¬®¬¨¬©s oppos‚Äö√Ñ√∂‚àö√ë‚àö‚àÇ‚Äö√†√∂‚Äö√Ñ‚Ä†‚Äö√†√∂‚Äö√†√á¬¨¬®¬¨¬Æ¬¨¬®¬¨¬©s 
	addMorph: listMorph1 frame: (0@0 extent: 0.5@0.5 ) ;
	addMorph: listMorph2 frame: (0.5 @ 0.5 corner: 1 @ 1).	
	Ca donne 1 carre mi-largeur ‚Äö√Ñ√∂‚àö√ë‚àö‚àÇ‚Äö√†√∂‚Äö√Ñ‚Ä†‚Äö√†√∂‚Äö√†√á‚Äö√Ñ√∂‚àö√ë‚àö‚àÇ‚Äö√†√∂‚àö√´‚Äö√Ñ√∂‚àö√ë‚Äö√Ñ‚Ä† gauche et un rectangle dessous pleine largeur (corner)
	addMorph: listMorph1 frame: (0@0 extent: 0.5@0.5 ) ;
	addMorph: listMorph2 frame: (0 @ 0.5 corner: 1 @ 1).	 
	Ca donne 1 carre mi-largeur ‚Äö√Ñ√∂‚àö√ë‚àö‚àÇ‚Äö√†√∂‚Äö√Ñ‚Ä†‚Äö√†√∂‚Äö√†√á‚Äö√Ñ√∂‚àö√ë‚àö‚àÇ‚Äö√†√∂‚àö√´‚Äö√Ñ√∂‚àö√ë‚Äö√Ñ‚Ä† gauche et un rectangle dessous pleine largeur (extent)
	addMorph: listMorph1 frame: (0@0 extent: 0.5@0.5 ) ;
	addMorph: listMorph2 frame: (0 @ 0.5 extent: 1 @ 0.5).			
	Ca donne 2 carres mi largeur a gauche   
	addMorph: listMorph1 frame: (0@0 extent: 0.5@0.5 ) ;
	addMorph: listMorph2 frame: (0 @ 0.5 extent: 0.5 @ 0.5).	
	Ca donne 2 carres mi largeur a droite 
	addMorph: listMorph1 frame: (0.5@0 extent: 0.5@0.5 ) ;
	addMorph: listMorph2 frame: (0.5 @ 0.5 extent: 0.5 @ 0.5).	
	Panel complet " 
	addMorph: listMorph1 frame: (  1/2 @0 extent: 0.5@0.5 ) ;
	addMorph: listMorph2 frame: (0 @ 0.5 extent: 0.5 @ 0.5) ;
	addMorph: buttonMorph1 frame: (0@0 extent: 0.25@0.25) ;
	addMorph: textMorph1 frame: (0.5@0.5 extent: 0.5@0.5);
	addMorph: textMorph2 frame: (0@0.25 extent: 0.5@0.25);
	addMorph: buttonMorph2 frame: (0.25@0 extent: (1/4)@0.25) .	

	^ window openInWorldExtent: 400 @ 400
]

{ #category : #example }
FullDemoV1 class >> go1 [
	"Similar to ListDemo1, but shows how to create two column pluggable
	 list morph.
	
	FullDemoV1 go1
	"

	| model button object listMorph1 listMorph2 buttonMorph1 buttonMorph3 buttonMorph4 buttonMorph2 window textMorph1 textMorph2 object1 cinemaPane tableADessinPane listMorph3 |
	"Creation of models."
	object := ListDemo2Object new.
	object1 := TextDemo1Object new.	

	"Creates two text morph on the common model.
	 If you change (if you have finished with changing
	 the string, press Alt+S) the string in one of the text morphs,
	 this will affect also the other on" 
	textMorph1 := PluggableTextMorph on: object1 text: #text accept: #text:.
	textMorph2 := PluggableTextMorph on: object1 text: #text accept: #text:.

	"Creates new button showing the (stringified) value of its model.
	 User's click will cause change the value from 0 to 1 and vice versa of the model " 
	model := ButtonDemo2Object new.
	buttonMorph2 := PluggableButtonMorph on: model getState: nil action: #act label: #asString.
		
	"Creates new button which, when clicked, will cause the string 'something'
	     been shown on Transcript
	 Selector #value will be sent to the given model (block context instance)
	     whenever user clicks the button"
	buttonMorph1 := PluggableButtonMorph
		on: [Transcript show: 'Bip onTranscript !!'; cr]
		getState: nil 
		action: #value.
	buttonMorph1 label: 'Bip!!'.
	"buttonMorph3 label: 'Futur ListPane'.
	buttonMorph4 label: 'Futur textPane'.
	buttonMorph3 label: 'FuturListPane'.
	cinemaPane label: 'Futur cinemaPane'.
	tableADessinPane label: 'TableADessinPane'.
	buttonMorph4 label: 'Futur textPane'."
	listMorph1 := PluggableMultiColumnListMorph "Creation of the first list morph."
		on: object
		list: #list
		selected: #select
		changeSelected: #select:.	"Creation of the second list morph."
	listMorph2 := PluggableMultiColumnListMorph
		on: object
		list: #list
		selected: #select
		changeSelected: #select:.
	listMorph3 := PluggableListMorph
		on: object
		list: #list
		selected: #select
		changeSelected: #select:.		
	window := SystemWindow labelled: 'FullDemoV1 (old ListDem2) called by go1 and  encapsulated in a SystemWidow'.
	window	color: Color blue;
	"Ca donne 2 colonnes verticales 
	addMorph: listMorph1 frame: (0 @ 0 corner: 1/2 @ 1) ;
	addMorph: listMorph2 frame: (1/2 @ 0 corner: 1 @ 1).
	Ca donne 2 colonnes horizontales 
	addMorph: listMorph1 frame: (0@0 extent: 1@0.5 ) ;
	addMorph: listMorph2 frame: (0 @ 0.5 corner: 1 @ 1).
	Ca donne 2 carr‚Äö√Ñ√∂‚àö√ë‚àö‚àÇ‚Äö√†√∂‚Äö√Ñ‚Ä†‚Äö√†√∂‚Äö√†√á¬¨¬®¬¨¬Æ¬¨¬®¬¨¬©s oppos‚Äö√Ñ√∂‚àö√ë‚àö‚àÇ‚Äö√†√∂‚Äö√Ñ‚Ä†‚Äö√†√∂‚Äö√†√á¬¨¬®¬¨¬Æ¬¨¬®¬¨¬©s 
	addMorph: listMorph1 frame: (0@0 extent: 0.5@0.5 ) ;
	addMorph: listMorph2 frame: (0.5 @ 0.5 corner: 1 @ 1).	
	Ca donne 1 carre mi-largeur ‚Äö√Ñ√∂‚àö√ë‚àö‚àÇ‚Äö√†√∂‚Äö√Ñ‚Ä†‚Äö√†√∂‚Äö√†√á‚Äö√Ñ√∂‚àö√ë‚àö‚àÇ‚Äö√†√∂‚àö√´‚Äö√Ñ√∂‚àö√ë‚Äö√Ñ‚Ä† gauche et un rectangle dessous pleine largeur (corner)
	addMorph: listMorph1 frame: (0@0 extent: 0.5@0.5 ) ;
	addMorph: listMorph2 frame: (0 @ 0.5 corner: 1 @ 1).	 
	Ca donne 1 carre mi-largeur ‚Äö√Ñ√∂‚àö√ë‚àö‚àÇ‚Äö√†√∂‚Äö√Ñ‚Ä†‚Äö√†√∂‚Äö√†√á‚Äö√Ñ√∂‚àö√ë‚àö‚àÇ‚Äö√†√∂‚àö√´‚Äö√Ñ√∂‚àö√ë‚Äö√Ñ‚Ä† gauche et un rectangle dessous pleine largeur (extent)
	addMorph: listMorph1 frame: (0@0 extent: 0.5@0.5 ) ;
	addMorph: listMorph2 frame: (0 @ 0.5 extent: 1 @ 0.5).			
	Ca donne 2 carres mi largeur a gauche   
	addMorph: listMorph1 frame: (0@0 extent: 0.5@0.5 ) ;
	addMorph: listMorph2 frame: (0 @ 0.5 extent: 0.5 @ 0.5).	
	Ca donne 2 carres mi largeur a droite 
	addMorph: listMorph1 frame: (0.5@0 extent: 0.5@0.5 ) ;
	addMorph: listMorph2 frame: (0.5 @ 0.5 extent: 0.5 @ 0.5).	
	Panel complet " 
	addMorph: listMorph1 frame: (  1/2 @0 extent: 0.5@0.5 ) ;
	addMorph: listMorph2 frame: (0 @ 0.5 extent: 0.5 @ 0.5) ;
	addMorph: buttonMorph1 frame: (0@0 extent: 0.25@0.25) ;
	addMorph: textMorph1 frame: (0.5@0.5 extent: 0.5@0.5);
	addMorph: textMorph2 frame: (0@0.25 extent: 0.5@0.25);
	addMorph: buttonMorph2 frame: (0.25@0 extent: (1/4)@0.25) .	

	^ window openInWorldExtent: 400 @ 400
]
