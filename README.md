#Puppet modules

About:
-----

My puppet library. Some modules are experimental, others are fully functional, but in general they are simple classes that try to achieve their goals in a simple manner. 

Modules: 
-------

### Java 6 and Java 7 for Ubuntu 

Classes with some inspiration in [puzzle's puppet-java] (https://github.com/puzzle/puppet-java) and based in then update-alternatives command. 

To use, extract the jdk file from Oracle, create a tar.gz and put it in the files folder for the respective version. If the version is different from the one there, edit the deploy.pp  

Limitations:

*  You can't use both at same time cause they try to update a path updating file on profile.d. Use one at a time. Both java6 and java7 classes depend on the java class. 
*  When installing, all java binaries paths are updated, but binaries that are exclusive to a post/previous version will still point to that version (ex java-rmi.cgi)  
*  To make it fast, the files are copied in a tar.gz and extracted on site. This is a simple implementation that leaves the archive and a installation file in /var/tmp due to puppet nature. 

### Cassandra

Still an experimental class but working under certain conditions. The idea here is to provide a away to deploy a N node cluster that already as assigned tokens for that number of nodes. To do this you will have to have a variable 'servers' that contains the IP addresses of all nodes.   
Token assignment based on Benjamin Black token function, and overall Cassandra deploy based on Edward Capriolo puppet class    

To use, extract the Cassandra folder to the file directory, and check the costumized files in /files and templates. 

`TODO:` Due to the number of files in the Cassadra folder, the deploy is slow so a folder strip or a tar strategy is advised. 

License:
-------

This program is free software; you can redistribute 
it and/or modify it under the terms of the GNU 
General Public License version 3 as published by 
the Free Software Foundation.

Feedback:
---------

If you found a bug or saw me do something noob, please, your feedback is welcome. 


