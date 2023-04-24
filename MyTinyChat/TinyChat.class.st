"
Cette classe définit les variables suivantes:
• url contient l’url HTTP permettant au client de se connecter au serveur,
• login est une chaîne de caractères identifiant le client,
• messages est une variable d’instance contenant les messages lus par le
client,
• lastMessageIndex est le numéro du dernier message lu par le client,
• exit est une valeur booléenne. Tant que cette valeur est vraie, le client
se connecte à intervalle régulier au serveur pour lire les messages
échangés depuis sa dernière connexion,
• console pointe sur l’instance de la console graphique permettant à
l’utilisateur de saisir et de consulter les messages.
"
Class {
	#name : #TinyChat,
	#superclass : #Object,
	#instVars : [
		'url',
		'login',
		'exit',
		'messages',
		'console',
		'lastMessageIndex'
	],
	#classInstVars : [
		'lastMessageIndex'
	],
	#category : #MyTinyChat
}

{ #category : #accessing }
TinyChat class >> connect: aHost port: aPort login: aLogin [
^ self new
host: aHost port: aPort login: aLogin;
start
]

{ #category : #accessing }
TinyChat class >> lastMessageIndex [
	^ lastMessageIndex
]

{ #category : #accessing }
TinyChat >> cmdLastMessageID [
^ self command: '/messages/count'
]

{ #category : #accessing }
TinyChat >> cmdMessagesFromLastIndexToEnd [
"Returns the server messages from my current last index to the
last one on the server."
^ self command: '/messages' argument: lastMessageIndex
]

{ #category : #accessing }
TinyChat >> cmdNewMessage [
^self command: '/messages/add'
]

{ #category : #accessing }
TinyChat >> command: aPath [
	^'{1}{2}' format: { url . aPath }
]

{ #category : #accessing }
TinyChat >> command: aPath argument: anArgument [
^'{1}{2}/{3}' format: { url . aPath . anArgument asString }
]

{ #category : #accessing }
TinyChat >> disconnect [
self sendNewMessage: (TCMessage from: login text: 'I exited from the chat room.').
exit := true
]

{ #category : #accesing }
TinyChat >> exit [
	^ exit
]

{ #category : #accessing }
TinyChat >> host: aHost port: aPort login: aLogin [
url := 'http://' , aHost , ':' , aPort asString.
login := aLogin
]

{ #category : #initialization }
TinyChat >> initialize [
	"c ? "
	super initialize.
	exit := false.
	lastMessageIndex := 0.
	messages := OrderedCollection new.
]

{ #category : #accessing }
TinyChat >> lastMessageIndex [ 
	^ lastMessageIndex 
]

{ #category : #accessing }
TinyChat >> messages [
	^ messages
]

{ #category : #accessing }
TinyChat >> readLastMessageID [
| id |
id := (ZnClient new url: self cmdLastMessageID; get) asInteger.
id = 0 ifTrue: [ id := 1 ].
^ id
]

{ #category : #accessing }
TinyChat >> readMissingMessages [
"Gets the new messages that have been posted since the last
request."
| response receivedMessages |
response := (ZnClient new url: self cmdMessagesFromLastIndexToEnd;
get).
^ response
ifNil: [ 0 ]
ifNotNil: [
receivedMessages := response substrings: (String crlf).
receivedMessages do: [ :msg | messages add: (TCMessage fromString: msg) ].
receivedMessages size.
].
]

{ #category : #accessing }
TinyChat >> refreshMessages [
[
[ exit ] whileFalse: [
(Delay forSeconds: 2) wait.
lastMessageIndex := lastMessageIndex + (self
readMissingMessages).
console print: messages.
]
] fork
]

{ #category : #accessing }
TinyChat >> send: aString [
"When we send a message, we push it to the server and in addition
we update the local list of posted messages."
| msg |
msg := TCMessage from: login text: aString.
self sendNewMessage: msg.
lastMessageIndex := lastMessageIndex + (self readMissingMessages).
console print: messages.
]

{ #category : #accessing }
TinyChat >> sendNewMessage: aMessage [
^ ZnClient new
url: self cmdNewMessage;
formAt: 'sender' put: (aMessage sender);
formAt: 'text' put: (aMessage text);
post
]

{ #category : #accessing }
TinyChat >> start [
console := TCConsole attach: self.
self sendNewMessage: (TCMessage from: login text: 'I joined the
chat room').
lastMessageIndex := self readLastMessageID.
self refreshMessages.
]
