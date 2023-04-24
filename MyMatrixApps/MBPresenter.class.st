Class {
	#name : #MBPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'matrixSizeLabel',
		'matrixSizeInput',
		'operations',
		'benchmarkButton',
		'stopButton'
	],
	#classInstVars : [
		'matrixSizeLabel'
	],
	#category : #MyMatrixApps
}

{ #category : #layout }
MBPresenter class >> defaultSpec [ 
	" "
	^ SpBoxLayout newTopToBottom
 		add: #matrixSizeLabel withConstraints: 
			[ :constraints | constraints height: 10 ] ; "self labelledPresenterHeight ] ;"

		
 		add: 'Select the operation to benchmark' expand: false;
 		add: #operations ;

 		addLast: (SpBoxLayout newLeftToRight 
  			add: #benchmarkButton ;
  			add: #stopButton ; yourself
  			);
		yourself
		
	
]

{ #category : #initialization }
MBPresenter >> connectPresenters [
 
self benchmarkButton action: [ 
  |benchmarkClass matrixSize|
  benchmarkClass := self operations selection selectedItem.
  matrixSize :=  self matrixSizeInput number.
  benchmarkClass perform: #runBenchmarks: with: matrixSize ]
]

{ #category : #initialization }
MBPresenter >> initializePresenters [
	" "
	matrixSizeInput := self newNumberInput  placeholder: '100'. 
	matrixSizeLabel := self instantiate: (SpLabeledPresenter 
		label: 'Matrix Size' 
		input: matrixSizeInput  
		description: 'Size of the square matrices on which the benchmarks will be run.').
	
 	operations := self newList.
 	operations items: Integer subclasses.

	benchmarkButton  := self newButton label: 'benchmark'; color: Color orange ; yourself. 
	stopButton := self newButton label: 'Stop'; color: Color red; yourself.
	^self
	
]
