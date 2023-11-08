"
C'est un exercice de délégation du calcul de la surface
Extrait de la prez de SDucasse nommée 
	Oriented-Object-Paradigm-PRESEQUEL-on-object-oriente-FR.mp4
Dans l'exercice , on a un Square, un Triangle, et un Circle, et un Parallelogramme

	|  total  shapes |
	total := 0 .
	Pictures allSubclasses do: [ :aShape |
		total := total + aShape new area ].
	total printString.

    Implementation Points
"
Class {
	#name : #Pictures,
	#superclass : #Object,
	#category : #MyInitExo
}
