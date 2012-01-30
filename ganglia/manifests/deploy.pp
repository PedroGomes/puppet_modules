class ganglia::deploy{
   
   group { "ganglia":
      ensure => present,   
      system => true
   }

   user { "ganglia":
      ensure => present,
      comment => "Ganglia Monitor",
      system => true,
      gid => "ganglia",
      shell => "/bin/false",
      home => "/var/lib/ganglia",
      require => Group[ganglia],
   }

   package { ganglia-monitor:
    ensure => latest,
    require => User[ganglia] 
   } 

   file{'/etc/ganglia/gmond.conf':
         ensure => file,
         owner => root, group => root, mode => 0644,
         source => "puppet:///modules/ganglia/gmond.conf",
 	 require => package["ganglia-monitor"]
   }

}
