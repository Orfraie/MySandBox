"
TCServer startOn: 8181

ZnClient new url: 'http://localhost:8181/messages/count' ; get

Ca retourne le nbre de messages , ici 0 , on a encore rien créé

puis

ZnClient new
	url: 'http://localhost:8181/messages/add';
	formAt: 'sender' put: 'olivier';
	formAt: 'text' put: 'Super cool ce tinychat' ; post
	
La, on a un msg,...
ZnClient new url: 'http://localhost:8181/messages/count' ; get
Ca retourne 1, on vient de le créer,..

TCServer stopAll

Ca aborte toutes les instances de TCServer,...

2dagerm@oscar:~$ curl http://localhost:8181/messages/count
curl: (7) Failed to connect to localhost port 8181: Connection refused
dagerm@oscar:~$ 

Avec un coup de curl , on voit que le server s'est arrêté.
"
Class {
	#name : #ManifestMyTinyChat,
	#superclass : #PackageManifest,
	#category : #'MyTinyChat-Manifest'
}
