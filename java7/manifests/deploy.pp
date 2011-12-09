class java7::deploy inherits java::base {

     file {"/var/tmp/jdk1.7.0.tar.gz":
        ensure => present,
        owner => root,
        group => root,
        path => "/var/tmp/jdk1.7.0.tar.gz",
        source => "puppet:///modules/java7/jdk1.7.0.tar.gz",
        require => File[ "/usr/lib/jvm/"]
     }
    
     exec {"copy_jdk7":
        path => "/usr/bin/:/bin:/usr/sbin:/sbin",
        cwd => "/usr/lib/jvm/",
        creates => "/usr/lib/jvm/jdk1.7.0/",
        command => 'tar -zxvf /var/tmp/jdk1.7.0.tar.gz',
        require => File[ "/var/tmp/jdk1.7.0.tar.gz"]
     }

    file {"/usr/lib/jvm/jdk1.7.0":
        owner => root,
     	group => root,
     	path => "/usr/lib/jvm/jdk1.7.0",
	require => Exec[ "copy_jdk7"]
     }

    file { "/usr/lib/jvm/java-7-oracle":
    	ensure => link,
    	target => "/usr/lib/jvm/jdk1.7.0",
    	require => File [ "/usr/lib/jvm/jdk1.7.0" ]
    }
	
    file {"/usr/lib/jvm/java-7-oracle.jinfo":
        owner => root,
        group => root,
        path => "/usr/lib/jvm/java-7-oracle.jinfo",
        source => "puppet:///modules/java7/java-7-oracle.jinfo",
        require => File[ "/usr/lib/jvm/jdk1.7.0"]   
   }


   file {"/var/tmp/update_alternatives_7.sh":
        owner => root,
        group => root,
        mode => 755,
        path => "/var/tmp/update_alternatives_7.sh",
        source => "puppet:///modules/java7/update_alternatives.sh",
        require => File[ "/usr/lib/jvm/java-7-oracle.jinfo"] 
   }
    
   exec{'execute_alternatives_install_7':
        command => '/var/tmp/update_alternatives_7.sh',
        require => File["/var/tmp/update_alternatives_7.sh"]
    }

    exec{"set_jdk7":
	path => "/usr/bin/:/bin:/usr/sbin:/sbin",
        command => 'update-alternatives --set java /usr/lib/jvm/java-7-oracle/jre/bin/java',
        unless => "update-alternatives --display java | grep 'points to' | grep -q '/usr/lib/jvm/java-7-oracle/jre/bin/java'",
        require => Exec["execute_alternatives_install_7"]
    }

    exec{"set_jdk7_paths":
        path => "/usr/bin/:/bin:/usr/sbin:/sbin", 
        command => 'update-java-alternatives --set java-7-oracle',
        require => Exec["set_jdk7"]
    }

}
