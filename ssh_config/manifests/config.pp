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

   exec{'backup_config':
        path => "/usr/bin/:/bin:/usr/sbin:/sbin",
        command => 'cp /etc/ssh/sshd_config /etc/ssh/sshd_config.orig',
        require => File["/home/gsd/.ssh"]
   }

  
   exec{'change_sshd_config':
        path => "/usr/bin/:/bin:/usr/sbin:/sbin",
        #dummy end command to garatee the last sed execution
        command => 'sed -i "s/PermitRootLogin yes/PermitRootLogin no/" /etc/ssh/sshd_config ; sed -i "s/#PasswordAuthentication yes/PasswordAuthentication no/" /etc/ssh/sshd_config  ; sed -i "s/UsePAM yes/UsePAM no/" /etc/ssh/sshd_config',
        require => Exec["backup_config"]
   }
   
   exec{'restart_ssh':
        path => "/usr/bin/:/bin:/usr/sbin:/sbin",
        command => "service ssh restart",
        require => Exec["change_sshd_config"]
   }
  

}
