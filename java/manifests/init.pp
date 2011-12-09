
class java::base {

     file {"/usr/lib/jvm/":
        ensure => directory,
        owner => root,
        group => root,
        path => "/usr/lib/jvm/",
     }
	
     file{'/etc/profile.d/java.sh':
	 ensure => file ,       
         owner => root, group => 0, mode => 644,
	 source => "puppet:///modules/java/java.sh"
     }

}
