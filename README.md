# ⚠️ Archived repository

This repository was moved to / Dieses Repository befindet sich nun unter:

🔗 https://git.kraut.space/Krautspace/plenums_invite

# Einladung zum Plenum des Hackspace Jena e.V.

Das Repository enthält Dateien zum automatischen Versenden von Einladungsmails
für das Plenum.

Das Shellskript ermittelt den kommenden Donnerstag, prüft, ob es ein erster
Donnerstag des Monats ist, und bricht sonst ab, ersetzt im Einladungstext (Datei
`email_text`) Platzhalter mit dem Datum des kommenden Donnerstag und verschickt
den Text als E-Mail.

Die Service- und Timer-Dateien lassen systemd das Skript einmal wöchentlich
ausführen.

# Installation

Dieses Repository muss nach `/opt` in das Verzeichnis `plenumsinvite` kopiert
werden:

```
mkdir -p /opt
cd /opt
git clone https://github.com/HackspaceJena/plenums_invite.git
cd /plenums_invite
```

Danach müssen die beiden systemd-Unit-Dateien nach `/etc/systemd/system`
verlinkt werden:

```
systemctl link /opt/plenums_invite/plenums_invite.service 
systemctl link /opt/plenums_invite/plenums_invite.timer
```

Schließlich muss die timer-Unit aktiviert werden:

```
systemctl enable plenums_invite.timer
```
