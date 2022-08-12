# DebtSettlerWear
 Debttsettler app for Wear OS

Navodila za namestitev:

1. Namestitev Flutter SDK:
   1. Navodila in datoteke za Flutter SDK so dostopni na povezavi https://docs.flutter.dev/get-started/install 

2. Namestitev vtičnika Flutter za Android Studio:
   1. V Android Studiu odprite nastavitve vtičnikov (File > Settings > Plugins)
   2. V zavihu Marketplace, poišite in izberite Flutter vtičnik ter pritisnite gumb "Install".

3. Kloniranje repozitorija:
   1. Klonirajte ta repozitorij.
   2. Postavite se v mapo /debtsettler_wear in poženite ukaz flutter get za pridobitev vseh dependency-jev.

4. Vzpostavitev primernega emulatorja:
   1. v Android studio odprite zavihek Device Manager (Tools > Device Manager)
   2. Stisnite gumb "Create device" in izberite zavihe "Wear OS"
   3. Izberite željeno napravo (priporočam "Wear OS Large Round" in pritisnite gumb "Next"
   4. Izberite (in po potrebi naložite) sistemsko sliko R (API Level 30) in kliknite  gumb "Next"
   5. Izberite ime emulatorja in pritisnite gumb "Finish"
   
5. Pogon aplikacije:
   1. Zaženite izbran emulator in ga v zavihu za naprave izberite kot cilno napravo.
   2. Aplikacijo zaženete z gumbom "Run" ali ukazom flutter run v terminalu.

6. Dodatno:
   1. Aplikacija je trenutno v načinu "demo", saj je za prikaz funkcionalnosti tako ne potrebujemo intenretne povezave, prav tako pa izdelkov na pametni uri ni možno vnašati na seznam kar pomeni da jih bo ob poskušanju funkcionlanosti posledično zmanjkalo. Demo verzija aplikacije podatke bere is JSON datotek zato posodobitev seznama (ikona za seznam) naloži vse izdelke tudi če so ti bili izbrisani.
   2. Te nastavitve lahko spremenite v datoteki /lib/constants.dart, kjer zakomentirajte vrstico "const mode=demo" in odkomentirajte vrstico "const mode=release". Aplikacija se bo tako povezala na domač server, z žetonom uporabnika, ki ima nekaj vnosov in podatkov za prikaz. 
