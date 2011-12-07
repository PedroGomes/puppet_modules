class java6::deploy inherits java::base{

     file {"/var/tmp/jdk1.6.0_27.tar.gz":
        ensure => present,
        owner => root,
        group => root,
        path => "/var/tmp/jdk1.6.0_27.tar.gz",
        source => "puppet:///modules/java6/jdk1.6.0_27.tar.gz",
        require => File[ "/usr/lib/jvm/"]
     }

    exec {"copy_jdk6":
        path => "/usr/bin/:/bin:/usr/sbin:/sbin",
        cwd => "/usr/lib/jvm/",
        creates => "/usr/lib/jvm/jdk1.6.0_27/", 
        command => 'tar -zxvf /var/tmp/jdk1.6.0_27.tar.gz',
	require => File[ "/var/tmp/jdk1.6.0_27.tar.gz"]
     }

     file {"/usr/lib/jvm/jdk1.6.0_27":
        owner => root,
        group => root,
        path => "/usr/lib/jvm/jdk1.6.0_27",
        require => Exec[ "copy_jdk6"]
     }

    file { "/usr/lib/jvm/java-6-sun":
    	ensure => link,
    	target => "/usr/lib/jvm/jdk1.6.0_27",
    	require => File [ "/usr/lib/jvm/jdk1.6.0_27" ]
    }
	
    file {"/usr/lib/jvm/java-6-sun.jinfo":
        owner => root,
        group => root,
        path => "/usr/lib/jvm/java-6-sun.jinfo",
        source => "puppet:///modules/java6/java-6-sun.jinfo",
        require => File[ "/usr/lib/jvm/jdk1.6.0_27"]   
   }


   file {"/var/tmp/update_alternatives_6.sh":
        owner => root,
        group => root,
        mode => 755,
        path => "/var/tmp/update_alternatives_6.sh",
        source => "puppet:///modules/java6/update_alternatives.sh",
        require => File[ "/usr/lib/jvm/java-6-sun.jinfo"] 
   }
    
   exec{'execute_alternatives_install_6':
        command => '/var/tmp/update_alternatives_6.sh',
        require => File["/var/tmp/update_alternatives_6.sh"]
    }
  
    exec{"set_jdk6":
	path => "/usr/bin/:/bin:/usr/sbin:/sbin",
        command => 'update-alternatives --set java /usr/lib/jvm/java-6-sun/jre/bin/java',
        unless => "update-alternatives --display java | grep 'points to' | grep -q '/usr/lib/jvm/java-6-sun/jre/bin/java'",
        require => Exec["execute_alternatives_install_6"]
    }

    exec{"set_jdk6_paths":
        path => "/usr/bin/:/bin:/usr/sbin:/sbin", 
        command => 'update-java-alternatives --set java-6-sun',
        require => Exec["set_jdk6"]
    }

    File["/etc/profile.d/java.sh"]{
	content => template("java6/java.erb"),
    }

}
