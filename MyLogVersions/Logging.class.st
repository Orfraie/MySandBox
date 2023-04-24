Class {
	#name : #Logging,
	#superclass : #Object,
	#instVars : [
		'udpPort',
		'udpNode',
		'udpFacility',
		'udpFlag',
		'logRoot',
		'logFlag',
		'transcriptFlag',
		'debugFlag',
		'logFileName',
		'logFileDesc',
		'udpSocket',
		'stripCtl',
		'initDone',
		'udpAddr',
		'aLogPane',
		'textPaneName'
	],
	#classVars : [
		'DefaultDebug',
		'DefaultDebugFlag',
		'DefaultLogFlag',
		'DefaultLogRoot',
		'DefaultStripCtlFlag',
		'DefaultTranscriptFlag',
		'DefaultUdpFacility',
		'DefaultUdpFlag',
		'DefaultUdpNode',
		'DefaultUdpPort',
		'Lf'
	],
	#category : #MyLogVersions
}

{ #category : #viewer }
Logging class >> dumpLoggingClassVariables [
	"retourne un string ready to print"
	^ 'DefaultUdpFacility =' , DefaultUdpFacility printString , Lf , 
	'DefaultLogRoot =' , DefaultLogRoot printString , Lf , 
	'DefaultUdpNode =' , DefaultUdpNode printString , Lf , 
	'DefaultUdpPort =' , DefaultUdpPort printString , Lf , 
	'DefaultDebugFlag =' , DefaultDebugFlag printString , Lf , 
	'DefaultTranscriptFlag=' , DefaultTranscriptFlag printString , Lf , 
	'Lf code is ' , (Lf at: 1) asciiValue printString , Lf , 
	'DefaultUdpFlag=' , DefaultUdpFlag printString , Lf , 
	'DefaultLogFlag=' , DefaultLogFlag printString , Lf , 
	'DefaultStripCtlFlag=' , DefaultStripCtlFlag printString , Lf , 
	'End of Logging Class Variable.' , Lf
]

{ #category : #viewer }
Logging class >> dumpLoggingClassVariablesForLog [
	"retourne un string ready to print"
	| s |
	s := '[UDP=', DefaultUdpFlag printString, ':' , DefaultUdpFacility printString, ',', DefaultUdpNode, ',', DefaultUdpPort printString,
		']    [Logroot=',	DefaultLogRoot,']    [Debug=', DefaultDebugFlag printString,']    [Transcript=', DefaultTranscriptFlag printString,
		']   [StripCTL=', DefaultStripCtlFlag printString,']'.
	^s
]

{ #category : #'class variables' }
Logging class >> initClassVariables [
	"retourne une nouvelle instance du logging avec les valeurs par
	default"
	DefaultUdpFlag := true.
	DefaultUdpFacility := 183.
	"Code de la facility local7.debug : 191"
	"Code de la facility local6.debug : 183"
	"191-183 =8, devinez comment faire aller le message dans local5.debug ??"
	DefaultUdpNode := 'localhost'.
	DefaultUdpPort := 5463. "Pour tourner avec Bpif-v2-srv.py sinon 514 pour syslog"
	
	DefaultLogFlag := true.	
	DefaultLogRoot := 'LL-'.

	DefaultDebugFlag := true.
	DefaultTranscriptFlag := true.

	Lf := 10 asCharacter asString.
	DefaultStripCtlFlag := true
]

{ #category : #documentation }
Logging class >> notesSurLaClasse [
	"
Cette classe permet d'installer directement , un m‚Äö√†√∂¬¨¬©canisme de logging apte a surveiller le fonctionnement d'une petite application.
Il permet, en fonction des flags positionnes a true ou false de gerer un fichier log local, un fichier syslog distant ou local, un fichier 
circulaire memeoire, le transcript et un textMorph qui peut etre une sous fenetre d'une interface applicative ou une fenetre standAlone.
Logging
	
	1. rsyslogd.
	Pour que ca marche bien , il faut que le ssysteme de logging sur
	la machine Unix soit configure correctement.
	Sous Ubuntu 10.10, voir
	/etc/rsyslogd.conf 
	Decommenter ceci
	# provides UDP syslog reception
	$ModLoad imudp
	$UDPServerRun 514
	/etc/rsyslog.d/50*
	Ajouter ceci pour la facility 191 ou adapter pour d'autres facilities.
	#
	# Add by DG pour le support de la classe Logging de Pharo
	#
	local7.*			-/var/log/local7.log
	Pour regarder passer les paquest UDP
	==> tcpdump -Nqt -i lo '(port 514)'
	Pour g‚Äö√†√∂¬¨¬©n‚Äö√†√∂¬¨¬©rer des enregistremenst de logs pour tester si c'est le
	code Pharo qui bugge ou si c'est la configuration du systeme Unix
	hebergeant le daemon rsyslogd
	==> logger -s -d -t TAG -i -p 
	local7.debug	MonMessageDeLogAMoiQueJAi 
	Ensuite , regarder dans /var/log/local7.log pour voir les messages
	arriver .
	==> Attention, a chaque mise a jour de noyau, ubuntu remet la conf rsyslog par default.
		
	"
	^ self
]

{ #category : #'Example-With-aGUI' }
Logging class >> openExample [
	"
	Une petite application qui ne fait rien d'utile mais qui logge
	plein de trucs est disponible dans la meme categorie dans la classe
	LoggingExample,..... Elle permet de voir pratiquement comment
	configurer un textMorph
	de logging dans l'interface d'une application normale
	Pour la lancer , evaluer [ LoggingExample openView ]
	
	"
	^ self
]

{ #category : #OverallTests }
Logging class >> test1 [
	| aLog |
	Transcript cr ; show: 'TEST1 :: all functions On' ; cr.
	self initClassVariables.
	self dumpLoggingClassVariables.
	Transcript show: ( self dumpLoggingClassVariables).
	aLog := self new.
	aLog init: nil.
	aLog dumpFlag. 
	1 to: 5 do: [ :i | aLog logit: 'azer' msg: 'rty',i asString, 7 asCharacter
	asString, 10 asCharacter asString, 78 asCharacter asString, 130
	asCharacter asString].
	aLog closeAllSupport.
	Transcript show: '-End' ; cr.
]

{ #category : #OverallTests }
Logging class >> test2 [
	"
	=======================================
	le script ci dessous est un test pour verifier la configuration de
	rsyslogd, ca balance dasn /var/log/message
	"
	| socket buffer n serverName serverAddr |
	Transcript cr ; show: 'TEST2 :: initializing network ... '.
	Socket initializeNetwork.
	Transcript show: 'ok'; cr.
	
	serverName := 'localhost'.
	serverAddr := NetNameResolver addressForName: serverName timeout: 10.
	socket := Socket newUDP.
	Transcript show: 'UDP client endpoint created to access server using ', serverAddr printString,'::5463' ; cr.
	socket
		sendData: '<191>TAG toto'
		toHost: serverAddr
		port: 5463.
	Transcript show: 'On vient d''ecrire dans dans la facility local7.debug (code191)' ; cr. 
	socket closeAndDestroy.
	Transcript show: 'UDP endpoint destroyed'; cr ; show: '-End';cr.
]

{ #category : #OverallTests }
Logging class >> test2rsyslog [
	"
	=======================================
	le script ci dessous est un test pour verifier la configuration de
	rsyslogd, ca balance dasn /var/log/message
	"
	| socket buffer n serverName serverAddr |
	Transcript cr ; show: 'TEST2 :: initializing network ... '.
	Socket initializeNetwork.
	Transcript show: 'ok'; cr.
	
	serverName := 'localhost'.
	serverAddr := NetNameResolver addressForName: serverName timeout: 10.
	socket := Socket newUDP.
	Transcript show: 'UDP syslog endpoint created to access server using ', serverAddr printString,'::514' ; cr.
	socket
		sendData: '<191>TAG toto'
		toHost: serverAddr
		port: 514.
	Transcript show: 'On vient d''ecrire dans dans la facility local7.debug (code191)' ; cr. 
	socket closeAndDestroy.
	Transcript show: 'UDP endpoint destroyed'; cr ; show: '-End';cr.
]

{ #category : #openFileSocket }
Logging >> closeAllSupport [
	"cloase all,.."
	logFileDesc close.
	self initDone: false.
	udpSocket closeAndDestroy.
	"aLogPane dependents first close  . fonctionne tres bien mais on ne voit plus rien,..."
	Transcript cr; show: 'Client endpoint destroyed, log file closed, pane closed '; cr.
]

{ #category : #configuring }
Logging >> debugFlag: d [ 
	"Setting the debug level , d must be a boolean"
	| temporary variable names |
	debugFlag := d
]

{ #category : #viewer }
Logging >> dump [
	"print current parameter of this instance"
       self inspect.
]

{ #category : #'accessing - view' }
Logging >> dumpFlag [
	"print current flag of this instance"
	| s |
	s := String new.
	s := 'udpFlag is ' , udpFlag printString , ',   ' , 'logFlag is ' , logFlag printString , '   ' , '   ' , 'debugFlag = ' , debugFlag printString, ',   ' , 'transcriptFlag = ' , transcriptFlag printString, '   ' , 'textPaneName = ' , textPaneName printString.
	^ s
]

{ #category : #'accessing - view' }
Logging >> dumpInstanceVariable [
	"print current parameter of this instance"
	| |
	Transcript 
		nextPutAll: 'facility = ' ; nextPutAll: udpFacility printString; cr ; 
		nextPutAll: 'fileName = ' ; nextPutAll: logFileName ; cr ;
		nextPutAll: 'port = ' ; nextPutAll: udpPort printString ; cr ;
		nextPutAll: 'node = ' ; nextPutAll: udpNode  ;cr ;
		nextPutAll: 'debug = ' ; nextPutAll: debugFlag printString ;cr ;
		nextPutAll: 'wsName = ' ; nextPutAll: 'g' printString  ;cr ;
		nextPutAll: 'textPaneName = ' ; nextPutAll: textPaneName printString  ;cr .
	
	Transcript show: 'facility = ' , udpFacility printString;
		 cr;
		 show: 'fileName = ' , logFileName;
		 cr;
		 show: 'port = ' , udpPort printString;
		 cr;
		 show: 'node = ' , udpNode;
		 cr;
		 show: 'debug = ' , debugFlag printString;
		 cr;
		 show: 'wsName = ' , 'g' printString;
		 cr;
		 show: 'textPaneName = ' , textPaneName  printString;
		 cr
]

{ #category : #readingInstVar }
Logging >> facility [
	^udpFacility
]

{ #category : #'initialize-release' }
Logging >> init [
	"initialize une instance du logging avec les valeurs par default
	Prise en compte d'un eventuel textMorph si disponible"
	aLogPane 
	ifNil: [
		aLogPane := Workspace openContents: Time now printString,  ' Démarrage du logging.', Character cr asString .
		].
	
	self udpFacility: DefaultUdpFacility.
	self udpNode: DefaultUdpNode.
	self udpPort: DefaultUdpPort.
	self logRoot: DefaultLogRoot.
	self transcriptFlag: DefaultTranscriptFlag.
	self debugFlag: DefaultDebug.
	"ouverture du fichier log, creation des sockets UDP et SMTP"
	self udpFlag: DefaultUdpFlag.
	self logFlag: DefaultLogFlag.
	self stripCtlFlag: DefaultStripCtlFlag.
	self openAllSupport
]

{ #category : #'initialize-release' }
Logging >> init: aExistingTextPaneName [ 
	"initialize une instance du logging avec les valeurs par default
	Prise en compte d'un eventuel textMorph si disponible"
	aLogPane 
	ifNil: [
		aLogPane := Workspace openContents: Time now printString,  ' Démarrage du logging.', Character cr asString .
		aLogPane label: 'Logging de l''application MyPlan'.
		].
	
	aExistingTextPaneName class isNil
		ifFalse: [self textPaneName:  aExistingTextPaneName ].
	self udpFacility: DefaultUdpFacility.
	self udpNode: DefaultUdpNode.
	self udpPort: DefaultUdpPort.
	self logRoot: DefaultLogRoot.
	self transcriptFlag: DefaultTranscriptFlag.
	self debugFlag: DefaultDebug.
	"ouverture du fichier log, creation des sockets UDP et SMTP"
	self udpFlag: DefaultUdpFlag.
	self logFlag: DefaultLogFlag.
	self stripCtlFlag: DefaultStripCtlFlag.
	self openAllSupport
]

{ #category : #readingInstVar }
Logging >> initDone [
	^initDone
]

{ #category : #'initialize-release' }
Logging >> initDone: b [ 
	initDone := b
]

{ #category : #configuring }
Logging >> logFlag: b [ 
	logFlag := b
]

{ #category : #configuring }
Logging >> logMorph [
	^aLogMorph
]

{ #category : #configuring }
Logging >> logPane [
	^aLogPane
]

{ #category : #configuring }
Logging >> logRoot: f [
	"Setting local log root file name to use to log "

	| temporary variable names |
	logRoot := f.
	^self
]

{ #category : #'method execution' }
Logging >> logit: code msg: aMsg [ 
	"ca formate aMsg pour le support de l'ascii 7 bits sans ; et sans CtrlChar"
	| s ss input output char |
	" On remplace les ;  par des , "
	(aMsg	select: [:i | i = $;]) isNotEmpty  
		ifTrue: [self error: 'no ; inside aMsg, thanks'].
	"ca doit etre des strings,...."
	(code isString and: [code size < 25])
		ifFalse: [self error: 'unsupported class/size for code in logit'].
	aMsg isString
		ifFalse: [self error: 'unsupported object for aMsg']
	"on vire les caracteres"
		ifTrue: [input := ReadStream on: aMsg.
			output := String new.
			[input atEnd]
				whileFalse: [char := input next.
					char = 13 asCharacter
						ifTrue: [output := output , '<CR>']
						ifFalse: [char = 10 asCharacter
								ifTrue: [output := output , '<LF>']
								ifFalse: [ char = $; 
									ifTrue: [  output := output, ' ' ]
									ifFalse: [(char < 32 asCharacter or: [char > 129 asCharacter])
											ifTrue: [output := output , '<?>']
											ifFalse: [output := output , char asString]]]]]].
	"On formate,..."
	s := '<' , self facility asString , '>;' , 
	Date today yyyymmdd , ';' , Time now print24 , ';' , 
	code , ';' , output , Lf.
	ss := Time now print24 , '  [' , code , ']  ' , output , Lf.
	self outputLoggingString: s or: ss
]

{ #category : #openFileSocket }
Logging >> openAllSupport [
	"il s'agit ici de configurer les sous systemes de sortie pour qu'ils
	soient disponibles pour le logging"
	"Transcript : rien a faire qu'il soit ou non ouvert , ca fonctionne de
	maniere identique"
	"Debug : idem, car ca utilise tous les autres supports disponibles"
	"Syslog: sauf ordre de config, on fait marcher, si syslogd est inactif ,
	pas d'importance, on est en mode deconnect‚Äö√†√∂¬¨¬©"
	self udpFlag
		ifTrue: [self openSyslog].
	"Memory: a toujours faire marcher, pas de configuration a faire, ici le
	code d'initialisation du fichier memoire circulaire reference dans le
	Systeme Dictionnary Smalltalk"
	self openMemory.
	"Logfile: si la config l'impose on fait marcher"
	logFlag
		ifTrue: [self openLog].
	self initDone: true
]

{ #category : #openFileSocket }
Logging >> openLog [
	"on cree le fichier log"

	logFileName := logRoot , 'yy'.
	logFileDesc := logFileName asFileReference writeStream.
	logFileDesc setToEnd.
	logFileDesc nextPutAll: 'Log file initialized,  date is ' , Date today printString , ', time is ' , Time now printString , Lf.
	"self halt."
]

{ #category : #openFileSocket }
Logging >> openMemory [
	"on cree le ficihier circulaire memoire avec un nom unique a definir 
	et on l'initialise"
	^ self
]

{ #category : #openFileSocket }
Logging >> openSyslog [
	"on cree le socket et on l'initialise"
	| |
	Socket initializeNetwork.
	udpAddr := NetNameResolver addressForName: udpNode timeout: 10.
	udpSocket := Socket newUDP.
]

{ #category : #'method execution' }
Logging >> outputLoggingString: aString [ 
	"dispatche vers tous les supports de logging configures"
	| crlf1 |
	crlf1 := 10 asCharacter asString , 13 asCharacter asString.
	aLogPane 
		ifNotNil: [aLogPane appendText: aString.. aLogPane contents: aLogPane contents].
	
	logFlag
		ifTrue: [logFileDesc nextPutAll: aString].
	
	transcriptFlag
		ifTrue: [Transcript show: aString].
	udpFlag
		ifTrue: [udpSocket
				sendData: aString
				toHost: udpAddr
				port: udpPort]
]

{ #category : #'method execution' }
Logging >> outputLoggingString: aString or: aScreenString [
	"dispatche vers tous les supports de logging configurés"
	| crlf1 |
	crlf1 := 10 asCharacter asString , 13 asCharacter asString.
	aLogPane 
		ifNotNil: [aLogPane contents append: aScreenString . aLogPane contents: aLogPane contents].
	logFlag
		ifTrue: [logFileDesc nextPutAll: aString].
	transcriptFlag
		ifTrue: [Transcript show: aString].
	udpFlag
		ifTrue: [udpSocket
				sendData: aString
				toHost: udpAddr
				port: udpPort]
]

{ #category : #readingInstVar }
Logging >> stripCtl [
	^stripCtl
]

{ #category : #configuring }
Logging >> stripCtlFlag: b [ 
	| stripCtlFlag |
	stripCtl := b
]

{ #category : #accessing }
Logging >> text [
	| text |
	^text
]

{ #category : #setting }
Logging >> text: aString [
	| text |
	text := aString.
	^self changed: #text.
]

{ #category : #configuring }
Logging >> textMorphName [
	^textMorphName
]

{ #category : #configuring }
Logging >> textMorphName: n [  
	"Setting the text Morph Name used to log  "

	| temporary variable names |
	textMorphName := n.
	^self
]

{ #category : #configuring }
Logging >> textPaneName [  
	"Getting the text Pane Name used to log  "

	^textPaneName
]

{ #category : #configuring }
Logging >> textPaneName: n [  
	"Setting the text Morph Name used to log  "

	| textPaneName |
	textPaneName := n.
	^self
]

{ #category : #configuring }
Logging >> transcriptFlag: b [ 
	transcriptFlag := b
]

{ #category : #configuring }
Logging >> udpFacility: f [
	"Setting facility to use to log to a Syslogd daemon"

	| temporary variable names |
	udpFacility := f.
	^self
]

{ #category : #readingInstVar }
Logging >> udpFlag [
	^udpFlag
]

{ #category : #configuring }
Logging >> udpFlag: b [
	udpFlag := b
]

{ #category : #configuring }
Logging >> udpNode: n [ 
	"Setting the node name to use to log to a syslogd daemon"
	| temporary variable names |
	udpNode := n
]

{ #category : #configuring }
Logging >> udpPort: i [ 
	"Setting the UDP port to use to log to a syslogd daemon "

	| temporary variable names |
	udpPort := i.
	^self
]
