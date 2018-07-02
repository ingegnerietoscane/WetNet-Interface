WETNET progetto per monitoraggio contatori acqua

Per installare in locale su tomcat: https://localhost:8443/wetnet/welcome
- disabilitare le properties in business.properties dentro wetnet-business
- commentare google analytics
- avviare wetnetBuild.sh
- copiare war dentro wetnet-web in webapps rinominandolo ROOT

Per produzione:
- aggiornare versioni
- controllare dipendenza versione wetnet-business in wetnet-web
- disabilitare le properties in business.properties dentro wetnet-business
- disabilitare le properties in wetnet-configuration.properties dentro wetnet-business
- togliere commento google analytics in wetnet-google-analytics.js
- avviare wetnetBuild_Produzione.sh
- consegnare war rinominandolo con ROOT su macchina in cloud
NB: sull'ambiente di produzione (Tomcat) esiste un file wetnet-configuration.properties