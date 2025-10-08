extends Node

var Facts : Array[String] = [
	"Kosmeetiku eriala oli 2025. aastal üks populaarsemaid erialasid",
	"VOCO on Eesti suurim kutseõppeasutus",
	"Vähemalt pool õppeajast moodustab praktiline õpe",
	"2024. aastal õppis VOCOs üle 3600 õppija tasemeõppes",
	"VOCOs saab omandada üle 80 erinevat eriala",
	"VOCO pakub rahvusvahelist praktikat Erasmus+ programmi raames",
	"VOCO pakub erialasid kaheksast valdkonnast: ehitus, ilu, turism, tehnika, toit, IT, äri ja isikuareng",
	"VOCO asutati 1922. aastal ja tegutseb juba üle 100 aasta",
	"Paljud lõpetajad jätkavad õpinguid rakenduskõrgkoolis või ülikoolis",
	"VOCOs on kaks kaasaegset õpilaskodu",
	"VOCO Tartu õppehooned asuvad Kopli 1C ja Põllu 11 aadressidel",
	"VOCO pakub rahvusvahelisi vahetusprogramme Erasmus+ kaudu",
	"Täienduskoolituses osaleb igal aastal tuhandeid täiskasvanuid",
	"VOCO õpilased saavutavad igal aastal edukalt tulemusi kutsevõistlustel"
]

func getRandomFact() -> String:
	if (Facts.size() <= 0):
		return ""
	
	var fact = Facts.pick_random()
	var index = Facts.find(fact, 0)
	Facts.remove_at(index)
	return fact
