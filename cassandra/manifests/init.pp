class cassandra::cassandra {

file { "/etc/init.d/cassandra":
    path => "/etc/init.d/cassandra",
    mode => 744,
    source => "puppet://puppetmaster/modules/cassandra/conf/cassandra.init",
}

file {
    "/usr/local/apache-cassandra-1.0.0":
     owner => root,
     group => root,
     path => "/usr/local/apache-cassandra-1.0.0",
     source => "puppet://puppetmaster/modules/cassandra/apache-cassandra-1.0.0",
     recurse => true ,
 }

 file {
    "/usr/local/apache-cassandra-1.0.0/bin":
    mode => 755,
    path => "/usr/local/apache-cassandra-1.0.0/bin",
    recurse => true,
    source => "puppet://puppetmaster/modules/cassandra/apache-cassandra-1.0.0/bin",
    require => File [ "/usr/local/apache-cassandra-1.0.0" ]
  }

 file { "/usr/local/cassandra":
    ensure => link,
    target => "/usr/local/apache-cassandra-1.0.0",
    require => File[ "/usr/local/apache-cassandra-1.0.0" ]
  }
}


class cassandra_sd  {

  include cassandra::cassandra
  include test_token

 # file { "/usr/local/cassandra/conf/cassandra.yaml":
 #   path => "/usr/local/cassandra/conf/cassandra.yaml",
 #  owner => "root",
 #   group => "root",
 #   content => template("cassandra/cassandra.erb"),
  #  source => "puppet://puppetmaster/modules/cassandra/conf/cassandra.yaml"
 # }
  file { "/usr/local/cassandra/bin/cassandra.in.sh":
    path => "/usr/local/cassandra/bin/cassandra.in.sh",
    owner => "root",
    group => "root",
    mode => 755,
    source => "puppet://puppetmaster/modules/cassandra/conf/cassandra.in.sh" 
 }
 notice('done') 

}
