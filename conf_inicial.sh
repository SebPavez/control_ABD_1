#!/usr/bin/env bash

echo "Inicia script!"
#Se crea grupo para realizar instalación
/usr/sbin/groupadd dba

#Se crea usuario con el que se realizará instalación
/usr/sbin/useradd -g dba oracle

#Se crea contraseña para el usuario recién creado
#IMPORTANTE: Este parametro debería pasarse como entrada al script!
echo "PassW0rD.." | /usr/bin/passwd oracle --stdin

#Cambio a usuario recién creado
su - oracle

#Creacion de variables de entorno para instalacion
echo "ORACLE_BASE=/spm/app/oracle; export ORACLE_BASE" >> .bash_profile
echo "ORACLE_HOME=\$ORACLE_BASE/product/11.2.0/db_spm; export ORACLE_HOME" >> .bash_profile
echo "ORACLE_SID=spmpro; export ORACLE_SID" >> .bash_profile

#Volvemos a usuario root
exit

#Cambiamos nuevamente a usuario oracle para revisar variables de entorno
su - oracle

echo $ORACLE_BASE
echo $ORACLE_HOME
echo $ORACLE_SID

#Volvemos a usuario root
exit

#creamos carpetas necesarias para instalación y otorgamos permisos a usuario creado para su manipulación
mkdir -p /spm/app/oracle/product/11.2.0/db_spm
chmod -R 755 /spm
chown -R oracle:dba /spm

#Descomprimimos ficheros de instalación y los movemos a la carpeta home del usuario creado
cd /root/Oracle11g
unzip p10404530_112030_Linux-x86-64_1of7.zip 
unzip p10404530_112030_Linux-x86-64_2of7.zip 
mv database /home/oracle/database
xhost +

#Ingresamos nuevamente al usuario creado
su - oracle

#Ejecutamos instalador
./database/runInstaller
