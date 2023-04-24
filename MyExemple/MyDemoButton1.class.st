Class {
	#name : #MyDemoButton1,
	#superclass : #Object,
	#category : #MyExemple
}

{ #category : #exemples }
MyDemoButton1 >> example [

	| tmp2 |
	"self halt. Juste parce qu'on ne voit rien apparaître a la ligne openInWorld" 
	tmp2 := PluggableButtonMorph
		        on: [ 
			        Transcript
				        show:
					        'something-Dependents=' , tmp2 dependents printString;
				        cr ]
		        getState: nil
		        action: #value.
	Transcript
		show: 'Init :: Dependents=' , tmp2 dependents printString;
		cr.
	"self halt."
	tmp2
		label:
			'i''m a pluggableButtonMorph, when clicked write something on Transcript!!';
		position: 100 @ 200;
		openInWorld. "Ne marche pas."
	(Delay forSeconds: 2) wait.		
	tmp2 delete.
]
