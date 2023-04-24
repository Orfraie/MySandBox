"
Petit jeu issu de PBE 2010 et développé en Pharo V1.3 puis fileOut/fileIn dans V10
"
Class {
	#name : #LOGame,
	#superclass : #BorderedMorph,
	#instVars : [
		'cells'
	],
	#category : #MyLightsOut
}

{ #category : #initialization }
LOGame >> cellsPerSide [
	" le nbre de cellule de chaque coté du jeu"
	^ 12
]

{ #category : #initialization }
LOGame >> initialize [
  | sampleCell width height n |
  super initialize.
  n := self cellsPerSide.
  sampleCell := LOCell new.
  width := sampleCell width.
  height := sampleCell height.
  self borderColor: Color green.
  self bounds: (5@5 extent: ((width*n) @(height*n)) + (2 * self borderWidth)).
  cells := Array2D new: n tabulate: [ :i :j | self newCellAt: i at: j ]
]

{ #category : #'event handling' }
LOGame >> mouseMove: anEvent [
]

{ #category : #initialization }
LOGame >> newCellAt: i at: j [
" cree une cellule à la position (i,j) et l'ajoute dans ma représentation graphique à la position correcte.
  retourne une nouvell cellule
"
 | c origin |
  c := LOCell new.
  origin := self innerBounds origin.
  self addMorph: c.
  c position: ((i - 1) * c width) @ ((j - 1) * c height) + origin.
  c mouseAction: [ self toggleNeighboursOfCellAt: i at: j ].
  ^ c
]

{ #category : #'game logic' }
LOGame >> toggleNeighboursOfCellAt: i at: j [
""
  Transcript show: 'change cell stat and its neightboorhood ' ; cr .
  (i > 1) ifTrue: [ (cells at: i - 1 at: j) toggleState ].
  (i < self cellsPerSide) ifTrue: [ (cells at: i + 1 at: j) toggleState ].
  (j > 1) ifTrue: [ (cells at: i at: j - 1) toggleState ].
  (j < self cellsPerSide) ifTrue: [ (cells at: i at: j + 1) toggleState ]
]
