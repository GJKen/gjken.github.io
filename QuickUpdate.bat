@echo off
echo ���´���
git fetch origin main
git pull origin main
git add .
git commit -m "update %date:~0,10% %time:~0,5%"
git push -u origin main
echo �����,3���ر�
timeout /t 3 /nobreak >nul
exit