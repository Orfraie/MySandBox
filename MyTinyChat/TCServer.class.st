"
Le coeur du serveur est basé sur le framework REST Teapot, permettant l’en-
voi et la réception des messages. Il maintient en plus une liste de messages
qu’il communique aux clients.

La variable d’instance teapotServer référence l’instance du serveur TeaPot
que l’on créée à l’aide de la méthode initializePort
"
Class {
	#name : 'TCServer',
	#superclass : 'Object',
	#instVars : [
		'teapotServer',
		'messagesQueue'
	],
	#category : 'MyTinyChat',
	#package : 'MyTinyChat'
}

{ #category : 'public' }
TCServer class >> startOn: aPortNumber [
	" ? "
	^ self new
		initializePort: aPortNumber ;
		registerRoutes ;
		registerErrorHandlers ;
		yourself.
]

{ #category : 'registering' }
TCServer class >> stopAll [
	"ces"	
	self allInstancesDo: #stop 
]

{ #category : 'adding' }
TCServer >> addMessage: aRequest [
	" ? "
	messagesQueue add: (TCMessage from: (aRequest at: #sender) text: (aRequest at: #text)).
]

{ #category : 'initialization' }
TCServer >> initialize [ 
	" ? "	
	super initialize.
	messagesQueue := TCMessageQueue new.
]

{ #category : 'initialization' }
TCServer >> initializePort: anInteger [
	"cs"	
	teapotServer := Teapot configure: { 
		#defaultOutput -> #text.
		#port -> anInteger.
		#debugMode -> true
		}.
	teapotServer start.
]

{ #category : 'public protocol' }
TCServer >> messageCount [
	^ messagesQueue size
]

{ #category : 'as yet unclassified' }
TCServer >> messagesFrom: request [
	^ messagesQueue formattedMessagesFrom: (request at: #id)
]

{ #category : 'register' }
TCServer >> registerErrorHandlers [
	teapotServer
		exception: KeyNotFound -> (TeaResponse notFound body: 'No such message')
]

{ #category : 'register' }
TCServer >> registerRoutes [
	"Le routage HTTP est défini dans la méthode registerRoutes . Trois opérations sont définies :
	• GET messages/count : retourne au client le nombre de messages reçus par le serveur,
	• GET messages/<id:IsInteger> : le serveur retourne les messages à partir de l’index indiqué dans la requête HTTP,
	• POST /message/add : le client envoie un message au serveur.	
	"
	teapotServer
		GET: '/messages/count' -> (Send message: #messageCount to: self);
		GET: '/messages/<id:IsInteger>' -> (Send message: #messagesFrom: to: self);
		POST: '/messages/add' -> (Send message: #addMessage: to: self)
]

{ #category : 'accessing' }
TCServer >> stop [ 
	"c"
	teapotServer stop.
	messagesQueue reset.
]
