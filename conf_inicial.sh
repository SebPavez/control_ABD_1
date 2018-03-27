#!/usr/bin/env bash
echo "Inicia script!"
#Se crea grupo
/usr/sbin/groupadd dba
#Se crea usuario con el que se realizará instalación
/usr/sbin/useradd -g dba oracle
#Se crea contraseña para el usuario recién creado
#IMPORTANTE: Este parametro debería pasarse como entrada al script!
echo "PassW0rD.." | /usr/bin/passwd oracle --stdin
#Creacion de variables de entorno para instalacion para usuario oracle
echo "ORACLE_BASE=/spm/app/oracle; export ORACLE_BASE" >> /home/oracle/.bash_profile
echo "ORACLE_HOME=\$ORACLE_BASE/product/11.2.0/db_spm; export ORACLE_HOME" >> /home/oracle/.bash_profile
echo "ORACLE_SID=spmpro; export ORACLE_SID" >> /home/oracle/.bash_profile
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
#se agrega ruta de oracle a PATH
echo "PATH=\$ORACLE_HOME/bin:\$PATH; export PATH" >> /home/oracle/.bash_profile
echo "fin de script!"
