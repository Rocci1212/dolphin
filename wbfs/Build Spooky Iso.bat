@echo off
echo Deleting the Spooky ISO if it exists...
del R4QP03.wbfs
echo Extracting the PAL iso...
wit extract R4QP01.wbfs source
echo Done!
echo Copying over DATA folder...
echo Current contents of DATA folder:
echo sys/main.dol - patched to force english
# echo files/Art/fe/ukenglish - text updates in here
echo files/ini/Stadiums/craterfield.ini - made brighter
echo files/ini/Stadiums/pipelinecentral.ini - fog removed
echo files/ini/Stadiums/stormship.ini - fog removed
echo files/ini/Stadiums/wastelands.ini - fog removed, lighting fixes
echo files/ini/StrikerChallenges/tutorial6.ini - extended to 10 mins, removed all opposing sidekicks
cp DATA source -r
echo Done!
echo Patching main.dol with gecko codes...
cp R4QP01.gct source/data/sys
cd source/data/sys
wstrt patch main.dol --add-section R4QP01.gct
del R4QP01.gct
cd ../../..
echo Done!
echo Building iso and cleaning up...
wit copy source R4QP03.wbfs --id R4QP03 --name "Spooky MSC 0.4.5"
rmdir /s /q source
pause