class ssh_config::config{

   file {"/home/gsd/.ssh":
        ensure => directory,
        owner => gsd,
        group => gsd,
        mode => 700,
        path => "/home/gsd/.ssh",
   }

   file{'/home/gsd/.ssh/authorized_keys':
         ensure => file ,
         owner => gsd, group => gsd, mode => 600,
         source => "puppet:///modules/ssh_config/authorized_keys",
         require => File["/home/gsd/.ssh"]
   }

   file{'/etc/ssh/sshd_config':
         ensure => file ,
         owner => root, group => root, mode => 644,
         source => "puppet:///modules/ssh_config/sshd_config",
         require => File["/home/gsd/.ssh"]
   }

   exec{'restart_ssh':
        path => "/usr/bin/:/bin:/usr/sbin:/sbin",
        command => "service ssh restart",
        require => File["/etc/ssh/ssh_host_dsa_key.pub"]   
   }  
  
}
