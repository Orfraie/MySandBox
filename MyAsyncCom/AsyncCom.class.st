"
AsynCom createAnAsyncCom.

Bon , ca ne marche , pas le code 'compile' mais il y a plein de trucs qui ne fonctionnent pas.
A revoir à la campagne avec un cable et un raspberry
2023 nov 19
"
Class {
	#name : #AsyncCom,
	#superclass : #Object,
	#instVars : [
		'currentModeCmd',
		'receiveTimeOut',
		'timeStartInMs',
		'portComID',
		'charSend',
		'charReceived',
		'timeOutNum',
		'currentExpectedPrompt'
	],
	#classVars : [
		'ClassInitDone',
		'DefaultModeCmd',
		'DefaultTimeOut',
		'ErrorMsgDict'
	],
	#category : #MyAsyncCom
}

{ #category : #operation }
AsyncCom class >> createAnAsyncCom [
       "Initialise le port com pour qu'il soit pret a dialoguer"
| aModeCommand aCom temporaries dcb returnCode aPortID |
    AsyncCom initialize.
    currentExpectedPrompt := $> .
    aModeCommand := String new.
    aCom:='COM '.
    aCom at: 4 put: (DefaultModeCmd at: 4).
    Transcript cr ; show: (AsyncCom getMsgDict: 1) ; show: aCom ;cr.
    LogDatacomPane logit: 'Port Com Init with [',DefaultModeCmd,'] ' sens: $- ; cr. 

"Creation du DCB"
    dcb := ByteArray new: 40.
    1 to: dcb size do: [ :i | dcb at: i put: 254 ].
    returnCode := UserLibrary buildCommDCB:  DefaultModeCmd asAsciiZ asParameter
                              DCB: dcb asParameter.
    (returnCode < 0) ifTrue: [  LogDatacomPane logit: 'Build DCB failed.' sens: $- ; cr. ^returnCode ]
                     ifFalse: [ LogDatacomPane logit: 'Build DCB Done.' sens: $- ; cr.].

"On open le device COMx "
    (aPortID := UserLibrary
                  openComm: aCom asParameter
                  inQueue: 16384 asParameter
                  outQueue: 512 asParameter).
    (aPortID = -1) ifTrue:  [LogDatacomPane logit: 'OpenCom Failed.' sens: $-; cr. ^aPortID ]
                     ifFalse: [LogDatacomPane logit: 'OpenCom done.' sens: $-; cr.].


"Init device with DCB with SetCommState"
    returnCode := UserLibrary setCommState: dcb asParameter.
    (returnCode < 0) ifTrue:  [LogDatacomPane logit: 'SetCommState failed.' sens: $- ;cr.^returnCode]
                     ifFalse: [LogDatacomPane logit: 'SetCommState done.' sens: $- ; cr. ].


    LogDatacomPane logit: 'Port Com Init done,....' sens: $- ; cr.
    portComID := aPortID.
]

{ #category : #'instance creation' }
AsyncCom class >> getMsgDict: anInteger [
        "retourne le msg d'horreur anInteger"
^(ErrorMsgDict at: 1)
]

{ #category : #operation }
AsyncCom >> addExpectedPrompt: aChar [
  "Ajoute temporairement un prompt spécifique a une transaction"
  aChar isCharacter ifTrue: [ currentExpectedPrompt := aChar ] .
  ^self
]

{ #category : #operation }
AsyncCom >> charReceived [
        "retourne le nombre d'octet lu depuis le debut de la session"
    ^charReceived
]

{ #category : #operation }
AsyncCom >> charSend [
        "retourne le nombre d'octet écrit depuis le debut de la session"
    ^charSend
]

{ #category : #operation }
AsyncCom >> close [
        "comment"
    | y temporaries |
    ^UserLibrary closeComm: portComID asParameter.
]

{ #category : #operation }
AsyncCom >> currentModeCmd [
        "retourne la config courante au format Mode"
    ^'COMX,19200,8,None'
]

{ #category : #operation }
AsyncCom >> defaultModeCmd [
        "retourne la config par default stockee dans la variable de classe DefaultModeCmd"
    ^DefaultModeCmd
]

{ #category : #initialize }
AsyncCom >> initialize [
        "Initialize the class variables for
         detecting recursive data structures. (ST)
         Message d'horreur et tutiquanti initialise, a revoir vraiment"
    RecursiveSet := Set new.
    RecursionInError := false.
       ClassInitDone := True.
       ErrorMsgDict := Dictionary new.
       DefaultModeCmd:= 'COM1:19200,N,8'.
       DefaultTimeOut:= 50. "Ms"
       "Transcript show: 'Initializing AsyncCom ',DefaultModeCmd,' TO=100Ms.' ; cr."
       ErrorMsgDict
         at: 1 put: 'Msg1: ';
         at: 2 put: 'Msg2: '.
]

{ #category : #operation }
AsyncCom >> listen [
 | c first returnCode resultBuffer startTimer count result continue recbuf |
    "On lit until plus rien n'arrive avec le timer par default
     soit 5 passes de DefaultTimeOut ms
     et le prompt par default soit # soit > soit :"

     recbuf := ByteArray new: 4000.
     resultBuffer := ReadWriteStream on: String new.
     first := 5.
     count := 0.
     continue := 1.
     [ continue = 1 ]  whileTrue:
     [
         "Ce sera le premier ?"
         "On attend delay les premiers octets, on laisse du temps pour demarrer"
         startTimer := (DefaultTimeOut*5) + (Time millisecondClockValue).
         [Time millisecondClockValue < startTimer] whileTrue: [].
         "On lit"
         returnCode:= UserLibrary
           readComm: portComID asParameter
           lpBuf: recbuf asParameter
           size: recbuf size asParameter.
         returnCode = 0
         ifTrue: [ resultBuffer position > 0
                   ifTrue: [ resultBuffer position: (resultBuffer readLimit) - 1.
                             c:= resultBuffer next.
                             ( c = currentExpectedPrompt or: [ c = $# or: [ c = $: ] ] )
                             ifTrue: [ continue := 0.
                                       result:= (resultBuffer readLimit) - 1 .
                                       "LogDatacomPane logit: 'Prompt expected found.' sens: $-;cr."
                                     ]
                             ifFalse:[ first := first - 1.
                                       first = 0
                                       ifTrue: [ continue:=0. result:=-1.
                                                 LogDatacomPane logit: 'This TimeOut can be an error!.' sens: $- ;cr.].
                                     ].
                            ]
                   ifFalse: [ first := first - 1 .
                              first = 0 ifTrue: [ continue := 0. result := -2. ].
                            ]
                 ]
         ifFalse: [ returnCode>0
                       ifTrue: [ count := count + returnCode.
                                 1 to: returnCode do: [ :i |
                                 resultBuffer nextPut: (recbuf at: i) asCharacter ].
                                 first:=5.
                               ]
                       ifFalse: [ continue := 0.
                                  result := returnCode.
                                ].
                  ].
      ].
     LogDatacomPane logit: 'Default Listen done, ', count printString, ' caractère(s) lu(s).' sens: $I; cr.
      ^resultBuffer
]

{ #category : #operation }
AsyncCom >> listen: aDelay p1: c1 p2: c2 [
 | c first returnCode resultBuffer startTimer count result continue recbuf |
"On lit until plus rien n arrive
 aScript est une array gerant des parametrees a definir pour la gestion
 de la transaction.
"
     recbuf := ByteArray new: 4000.
     resultBuffer := ReadWriteStream on: String new.
     first := 5.
     count := 0.
     continue := 1.
     [ continue = 1 ]  whileTrue:
     [
         "Ce sera le premier ?"
         "On attend 5 * delay ms les premiers octets"
         startTimer := (aDelay*5) + (Time millisecondClockValue).
         [Time millisecondClockValue < startTimer] whileTrue: [].
         "On lit"
         returnCode:= UserLibrary
           readComm: portComID asParameter
           lpBuf: recbuf asParameter
           size: recbuf size asParameter.
                 returnCode = 0
         ifTrue: [ resultBuffer position > 0
                   ifTrue: [ resultBuffer position: (resultBuffer readLimit) - 1.
                             c:= resultBuffer next.
                             ( c = c1  or: [ c = c2 ] )
                             ifTrue: [ continue := 0.
                                       result:= (resultBuffer readLimit) - 1 .
                                       LogDatacomPane logit: 'Prompt expected found.' sens: $-;cr.
                                     ]
                             ifFalse:[ first := first - 1.
                                       first = 0
                                       ifTrue: [ continue:=0. result:=-1.
                                                 LogDatacomPane logit: 'TimeOut (Can be an error!).' sens: $- ;cr.].
                                     ].
                            ]
                   ifFalse: [ first := first - 1 .
                              first = 0 ifTrue: [ continue := 0. result := -2. ].
                            ]
                 ]
         ifFalse: [ returnCode>0
                       ifTrue: [ count := count + returnCode.
                                 1 to: returnCode do: [ :i |
                                 resultBuffer nextPut: (recbuf at: i) asCharacter ].
                                 first:=5.
                               ]
                       ifFalse: [ continue := 0.
                                  result := returnCode.
                                ].
                  ].
      ].
      LogDatacomPane logit: 'Listen done, ', count printString, ' caractère(s) lu(s).' sens: $I; cr.
      ^resultBuffer
]

{ #category : #operation }
AsyncCom >> listenNoLog [
 | c first returnCode resultBuffer startTimer count result continue recbuf |
    "On lit until plus rien n'arrive avec le timer par default
     soit 5 passes de DefaultTimeOut ms
     et le prompt par default soit # soit > soit :"

     recbuf := ByteArray new: 4000.
     resultBuffer := ReadWriteStream on: String new.
     first := 5.
     count := 0.
     continue := 1.
     [ continue = 1 ]  whileTrue:
     [
         "Ce sera le premier ?"
         "On attend delay les premiers octets, on laisse du temps pour demarrer"
         startTimer := (DefaultTimeOut*5) + (Time millisecondClockValue).
         [Time millisecondClockValue < startTimer] whileTrue: [].
         "On lit"
         returnCode:= UserLibrary
           readComm: portComID asParameter
           lpBuf: recbuf asParameter
           size: recbuf size asParameter.
         returnCode = 0
         ifTrue: [ resultBuffer position > 0
                   ifTrue: [ resultBuffer position: (resultBuffer readLimit) - 1.
                             c:= resultBuffer next.
                             ( c = currentExpectedPrompt or: [ c = $# or: [ c = $: ] ] )
                             ifTrue: [ continue := 0.
                                       result:= (resultBuffer readLimit) - 1 .
                                       "LogDatacomPane logit: 'Prompt expected found.' sens: $-;cr."
                                     ]
                             ifFalse:[ first := first - 1.
                                       first = 0
                                       ifTrue: [ continue:=0. result:=-1.
                                                 LogDatacomPane logit: 'This TimeOut can be an error!.' sens: $- ;cr.].
                                     ].
                            ]
                   ifFalse: [ first := first - 1 .
                              first = 0 ifTrue: [ continue := 0. result := -2. ].
                            ]
                 ]
         ifFalse: [ returnCode>0
                       ifTrue: [ count := count + returnCode.
                                 1 to: returnCode do: [ :i |
                                 resultBuffer nextPut: (recbuf at: i) asCharacter ].
                                 first:=5.
                               ]
                       ifFalse: [ continue := 0.
                                  result := returnCode.
                                ].
                  ].
      ].
      ^resultBuffer
]

{ #category : #operation }
AsyncCom >> listenNoLog: aDelay p1: c1 p2: c2 [
 | c first returnCode resultBuffer startTimer count result continue recbuf |
"On lit until plus rien n arrive
 aScript est une array gerant des parametrees a definir pour la gestion
 de la transaction.
"
     recbuf := ByteArray new: 4000.
     resultBuffer := ReadWriteStream on: String new.
     first := 5.
     count := 0.
     continue := 1.
     [ continue = 1 ]  whileTrue:
     [
         "Ce sera le premier ?"
         "On attend 5 * delay ms les premiers octets"
         startTimer := (aDelay*5) + (Time millisecondClockValue).
         [Time millisecondClockValue < startTimer] whileTrue: [].
         "On lit"
         returnCode:= UserLibrary
           readComm: portComID asParameter
           lpBuf: recbuf asParameter
           size: recbuf size asParameter.
                 returnCode = 0
         ifTrue: [ resultBuffer position > 0
                   ifTrue: [ resultBuffer position: (resultBuffer readLimit) - 1.
                             c:= resultBuffer next.
                             ( c = c1  or: [ c = c2 ] )
                             ifTrue: [ continue := 0.
                                       result:= (resultBuffer readLimit) - 1 .
                                       LogDatacomPane logit: 'Prompt expected found.' sens: $-;cr.
                                     ]
                             ifFalse:[ first := first - 1.
                                       first = 0
                                       ifTrue: [ continue:=0. result:=-1.
                                                 LogDatacomPane logit: 'TimeOut (Can be an error!).' sens: $- ;cr.].
                                     ].
                            ]
                   ifFalse: [ first := first - 1 .
                              first = 0 ifTrue: [ continue := 0. result := -2. ].
                            ]
                 ]
         ifFalse: [ returnCode>0
                       ifTrue: [ count := count + returnCode.
                                 1 to: returnCode do: [ :i |
                                 resultBuffer nextPut: (recbuf at: i) asCharacter ].
                                 first:=5.
                               ]
                       ifFalse: [ continue := 0.
                                  result := returnCode.
                                ].
                  ].
      ].
      ^resultBuffer
]

{ #category : #operation }
AsyncCom >> portComID [
        "comment"
    | fds |
    ^portComID
]

{ #category : #operation }
AsyncCom >> receiveTimeOut [
        "retourne le receiveTimeOut courant"
    ^receiveTimeOut
]

{ #category : #operation }
AsyncCom >> send: anObject [
  "On envoit l'objet requis sans inserer de retour chariot"
   | r buf cr |
     buf := ByteArray new: anObject size .
     anObject class = 'String'
     ifTrue:
     [ 1 to: anObject size do: [ :i | buf at: i put: (anObject at: i) ].
       ( UserLibrary writeComm: portComID asParameter
                     lpBuf: buf  asParameter
                     size: buf size asParameter ) = -1
       ifFalse: [ LogDatacomPane logit: 'send Without CR done' sens: $O. r:=-1 ]
       ifTrue:[ LogDatacomPane logit: 'Write failed.' sens: $O. r:=0  ].
     ].
     ^r
]

{ #category : #operation }
AsyncCom >> sendWithCR: buf [
  "On ecrit le string sur le port"
   | returnCode bbuf cr |
     bbuf := String new.
     bbuf := buf,(13 asCharacter asString).
     returnCode :=
     UserLibrary writeComm: portComID asParameter
                 lpBuf: bbuf asParameter
                 size: bbuf size asParameter.
     returnCode = -1 ifFalse: [ LogDatacomPane logitStripCtrlChar: ('String [', bbuf, '] sent to remote.') sens: $O ; cr.]
                     ifTrue:[ LogDatacomPane logit: 'Write failed.' sens: $O ; cr. ].
     "^returnCode"
]

{ #category : #operation }
AsyncCom >> sendWithCRnoLog: buf [
  "On ecrit le string sur le port avec le delay "
   | returnCode bbuf cr |
     bbuf := String new.
     bbuf := buf,(13 asCharacter asString).
     returnCode :=
     UserLibrary writeComm: portComID asParameter
                 lpBuf: bbuf asParameter
                 size: bbuf size asParameter.
     returnCode = -1 ifTrue:[ LogDatacomPane logit: 'Write failed.' sens: $O ; cr. ].
]

{ #category : #operation }
AsyncCom >> timeOutNum [
        "retourne le nombre de to depuis le début de la session"
   ^timeOutNum
]

{ #category : #operation }
AsyncCom >> timeStartInMs [
        "retourne le nombre de ms depuis le debut de session"
    ^987654
]
