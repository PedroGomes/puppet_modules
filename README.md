#Puppet modules

About:
-----

My puppet library. Some modules are experimental, others are fully functional, but in general they are simple classes that try to achieve their goals in a simple manner. 

Modules: 
-------

### Java 6 and Java 7 for Ubuntu 

Classes with some inspiration in [puzzle's puppet-java] (https://github.com/puzzle/puppet-java) and based in the update-alternatives command. 

To use, extract the jdk file from Oracle, create a tar.gz and put it in the files folder for the respective version. If the version is different from the one there, edit the deploy.pp. Both java6 and java7 classes depend on the java class.  

Limitations:

*  When installing, all java binaries paths are updated, but binaries that are exclusive to a post/previous version will still point to that version (ex java-rmi.cgi). Some of this binaries are also unacessary and should go to sbin.   
*  To make it fast, the files are copied in a tar.gz and extracted on site. This is a simple implementation that due to puppet nature is only viable for a one time deploy trough puppet. 

### Cassandra

Still an experimental class but working under certain conditions. The idea here is to provide a away to deploy a N node cluster that already as assigned tokens for that number of nodes. To do this you will have to have a variable 'servers' that contains the IP addresses of all nodes.   
Token assignment based on Benjamin Black token function, and overall Cassandra deploy based on Edward Capriolo puppet class    

To use, extract the Cassandra folder to the file directory, and check the costumized files in /files and templates. 

`TODO:` Due to the number of files in the Cassadra folder, the deploy is slow so a folder strip or a tar strategy is advised. 

### SSH

An simple ssh configuration module to disable password access and give access to desired users trough public key. It is hard-coded for one user, so change it for your use case and put your ssh keys in the authorized_keys file.   

### Wakeonlan

Small module for the deploy of a init.d script for wakeonlan in Ubuntu.   
Note: It should include the installation of the package ethtool, but in my case it was not necessary. 

### Ganglia

Small module for ganglia installation, prepared to cope with the current bug that affects the Ubuntu Oneric repository.    
To use, change the gmod configuration file. 

License:
-------

This program is free software; you can redistribute 
it and/or modify it under the terms of the GNU 
General Public License version 3 as published by 
the Free Software Foundation.

Feedback:
---------

If you found a bug or saw me do something stupid, please, your feedback is welcome. 


