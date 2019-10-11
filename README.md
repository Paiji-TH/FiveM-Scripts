สคริปต์ FiveM - vRP เครดิต kasper

 โครงการเหล่านี้อยู่ในระหว่างการพัฒนาชั่วขณะหนึ่งและอีกไม่กี่โครงการได้รับการทดสอบบนเซิร์ฟเวอร์ DanDream ซึ่งฉันได้เลือกที่จะออก

 เนื่องจากฉันหวังว่าใครบางคนสามารถใช้พวกเขาตอนนี้พวกเขาแชร์ที่นี่และหวังว่าคุณจะต้อนรับพวกเขา

 อย่างไรก็ตามอย่างที่ฉันบอกว่าฉันไม่ได้ทดสอบพวกเขาทั้งหมดบนเซิร์ฟเวอร์อย่างเป็นทางการกับผู้เล่นหลายคนและดังนั้นฉันจึงชื่นชมข้อความที่มีข้อผิดพลาดข้อบกพร่องและสิ่งที่คล้าย ๆ

### Discord: https://discord.gg/uPQfJuu

<a href="https://discord.gg/uPQfJuu"><img src="https://kasper-rasmussen.dk/assets/images/icons/discord_logo.png" /></a>

## Projekter:

![alt text](https://kasper-rasmussen.dk/assets/images/icons/info_16x16.png "Waiting") kasperr_phone - kommende udgivelse (under udvikling)

![alt text](https://kasper-rasmussen.dk/assets/images/icons/info_16x16.png "Waiting") kasperr_base - kommende udgivelse (under udvikling)

![alt text](https://kasper-rasmussen.dk/assets/images/icons/check_16x16.png "Completed") kasperr_bank [NYT]

![alt text](https://kasper-rasmussen.dk/assets/images/icons/check_16x16.png "Completed") kasperr_helpdesk [NYT]

![alt text](https://kasper-rasmussen.dk/assets/images/icons/check_16x16.png "Completed") kasperr_player_ping

![alt text](https://kasper-rasmussen.dk/assets/images/icons/check_16x16.png "Completed") kasperr_carjack_alert

![alt text](https://kasper-rasmussen.dk/assets/images/icons/check_16x16.png "Completed") kasperr_info_menu [(video)](https://youtu.be/wizzv1FT7Tk "Info menu - video")

![alt text](https://kasper-rasmussen.dk/assets/images/icons/check_16x16.png "Completed") kasperr_inventory [(video)](https://youtu.be/loLkBvHa110 "Inventory - video") *- kasperr_progress_handler er påkrævet*

![alt text](https://kasper-rasmussen.dk/assets/images/icons/check_16x16.png "Completed") kasperr_jobcenter [(video)](https://youtu.be/CjaqFxzWaTM "Jobcenter - video")

![alt text](https://kasper-rasmussen.dk/assets/images/icons/check_16x16.png "Completed") kasperr_loadout [(video)](https://youtu.be/iAjVkuo1j3A "Loadout - video")

![alt text](https://kasper-rasmussen.dk/assets/images/icons/check_16x16.png "Completed") kasperr_police_equipment [(video)](https://youtu.be/WORBnH0MDuA "Police equipment - video")

![alt text](https://kasper-rasmussen.dk/assets/images/icons/check_16x16.png "Completed") kasperr_progress_handler

![alt text](https://kasper-rasmussen.dk/assets/images/icons/check_16x16.png "Completed") kasperr_richpresence

## Dokumentation:

Alle projekter har en inkluderet config fil, hvor der er mulighed for at gøre oplevelsen for jeres spillere mere personligt. 
Her vil i se en fil: `config.lua`, som primært er configs til diverse Lua filer.

Derudover vil der i visse tilfælde være en fil: `configNui.js`, hvor det omhandler den medfølgende NUI menu (lavet i HTML, CSS & JavaScript).

#### Progress Handler
Jeg har udarbejdet en "progress handler", som er beregnet til at køre et ønsket event efter kort tid. 

Det kan være smart at benytte den, hvis man ikke ønsker, at folk kan indtage mad, drikke eller samle genstande op meget hurtigt, eller man generalt ønsker at spilleren skal vente et par sekunder for at kunne fortsætte.

#### Brug af den omtalte "progress handler":

**Parametre:**

Titel: Overskrift

Tid: Her angiver vi hvor lang tid der skal gå før den er færdig

Type: Vælg om det event, som skal køres er "client" eller "server"

Event: Navnet på det event som skal køres

Args: Eventuelle variabler som man ønsker at sende med hen til det event, man ønsker at køre

```lua
TriggerClientEvent("kasperr_progress_handler:open", "My title", 5000, "client", "event:name", {"random string"}) 
```

## Retningslinjer

Vigtig: man må gerne redigere i mine scripts, men IKKE fjerne mit navn eller "credits". Det betyder også, at man ikke må fjerne mit navn fra mapperne.
Hvis man gør brug af følgende udgivelser, skal man nævne udgiveren (Kasper Rasmussen) ved alle forhåndsvisninger (videoer, billeder eller andet materiale som udgives til spillere/brugere). 
Man må benytte og redigere udgivelserne, men aldrig videregive dem, sælge eller udgive sig for at være udgiveren.

Hvis man er i tvivl om retningslinjerne eller har spørgsmål, skal man kontakt Kasper Rasmussen - find kontaktoplysninger i bunden af siden eller på https://www.kasper-rasmussen.dk/

## Kontakt 

Steam: https://steamcommunity.com/id/kasperrasmussen/

Discord: Kasper.Rasmussen#0001
