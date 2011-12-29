class wakeonlan::config{

   file{'/etc/init.d/wakeonlanconfig':
         ensure => file,
         owner => root, group => root, mode => 0755,
         source => "puppet:///modules/wakeonlan/wakeonlanconfig",
   }
   
   exec{'put_on_startup ':
        path => "/usr/bin/:/bin:/usr/sbin:/sbin",
	cwd => "/etc/init.d/",
        command => "update-rc.d -f wakeonlanconfig defaults",
        require => File["/etc/init.d/wakeonlanconfig"]
   }



}
