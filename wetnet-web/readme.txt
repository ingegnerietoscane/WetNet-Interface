Per deployare in locale su jetty:  http://localhost:8889/wetnet/welcome
- abilitare le properties in business.properties dentro wetnet-business
- commentare google analytics in script/wetnet-google-analytics.js 
- runnare wetnetBuildRun.sh


Per deployare in locale su tomcat: https://localhost:8443/wetnet/welcome
- disabilitare le properties in business.properties dentro wetnet-business
- commentare google analytics
- runnare wetnetBuild.sh
- copiare war dentro wetnet-web in webapps rinominandolo ROOT


Per produzione:
- aggiornare versioni
- controllare dipendenza versione wetnet-business in wetnet-web
- disabilitare le properties in business.properties dentro wetnet-business
- disabilitare le properties in wetnet-configuration.properties dentro wetnet-business
- togliere commento google analytics in wetnet-google-analytics.js
- runnare wetnetBuild_Produzione.sh
- consegnare war dentro wetnet-web/target rinominandolo con ROOT
- consegnare zip con wetnet-web/wetnet-business
NB: sul loro ambiente hanno un file wetnet-configuration.properties esternato in Tomcat per le proprietà



Per compilare con maven
- dentro wetnet-business prima e poi dentro wetnet-web ---> mvn clean install -Dmaven.test.skip=true




NB: il file business-prod.properties non viene più utilizzato
