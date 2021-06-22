co ukazat?

lokal superadmin:
running/untested status - na ruby
filtrovanie v historii - ruby
dashboardy - ruby

lokal prezentacia:
import standard - zlib
defect types - zlib alebo ruby
metadata + filtre - zlib 
celkovo strukturu vysvetlit


product:
spustit scratch build a ukazat ze sa to automaticky importuje - zlib alebo cpio
vysvetlit infrastrukturu - datagrepper + logy ukazat - pozri gcc - pekne to vidiet
vysvetlit listenera, watchera import skripty + parsera


+ ukazat video ze to bolo nasadene
+ ukazat konverzaciu na RP upstreame ze to chcu mergnut


postup:
uvod do prace, preco sme ju robili, co bolo jej cielom - toto je len prva verzia aplikacie a dalej rozsirenia budu nahradzovat nitrate

cielom bolo navrhnut a nasadit novy system pre spravu vysledkov testov nahradzujucich nastroj nitrate
reportportal je open-source, bolo potrebne doimplementovat chybajucu funckcionalitu na zaklade poziadaviek 

na uvod povedat ze je to interna aplikacia ktoru by som nemal ukazovat, ale mam ju napojenu na lokal a tam ju ukazem
som pripojeny na VPN a pripojeny a UMB - message broker a z tadial taham data

cely system sa sklada z dvoch casti - infrastruktury a aplikacie

na uvod vysvetlit jednotlive casti infrastruktury popisat parser listener, standardizator atd
zapnut scratch build a ukazat ze sa to tam reportuje


zaroven ze reportportal je rodeleny do viac repozitarov -> ukazat pull-requesty ze ich budu chciet prijat


ukazat nasadenie a video - nemozno ukazat appku lebo je to interna aplikacia

zacat ukazovat funkcionalitu reportportalu
ukazat ze na pociatocnej obrazovke su mena komponent s verziami a k nim sa viazu jednotlive vysledky testov -> vysvetlit strukturu a s tym suvisiacu implementaciu importu daneho standu, ktory bol navrhnuty a je popisany v praci

lokal superadmin:
novy defect type - pridane nove defect-types - ukazat menenie statusu a noveho defect type
running/untested status - na ruby
filtrovanie v historii - ruby
import standard - navrhnuty mnou - zodpoveda tomu struktura, kde import funkcionalitu som musel upravit - ak tak pozret aj default alebo tak
dashboardy - ruby - s tym suvisiace filtrovanie voci metadatam a ukladanie metadat

+ dalsie drobne zmeny uzivatelskeho rozhrania

na konci ukazat ze cpio sa importlo

najtzsim na praci bola komunikacia s uzivatelmi a pokrytie poziadaviek tak, aby s tym boli spokojne viacere strany	


