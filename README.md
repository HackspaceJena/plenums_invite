# Einladung zum Plenum des Hackspace Jena e.V.

Das Repository enthält Dateien zum automatischen Versenden von Einladungsmails
für das Plenum.

Das Shellskript ermittelt den kommenden Donnerstag, prüft, ob es ein erster
Donnerstag des Monats ist, und bricht sonst ab, ersetzt im Einladungstext (Datei
`email_text`) Platzhalter mit dem Datum des kommenden Donnerstag und verschickt
den Text als E-Mail.

Die Service- und Timer-Dateien lassen systemd das Skript einmal wöchentlich
ausführen.
