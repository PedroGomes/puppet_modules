hostclass :test_token  do 

	servers = scope.lookupvar("servers")
	
	tokens = Hash.new

	num_nodes = servers.size

	servers.each_with_index do |ipadd,idx|
 	   tokens[ipadd]  = 2** 127 / num_nodes * idx
	end

	ipaddress =  scope.lookupvar("ipaddress").to_s()        
	print tokens[ipaddress],"\n"
	
	scope.setvar("token", tokens[ipaddress].to_s())
	scope.setvar("seed_ip", servers[0])
                   
	file("/usr/local/cassandra/conf/cassandra.yaml",
   		 :path => "/usr/local/cassandra/conf/cassandra.yaml",
   	 	 :owner => "root",
  		 :group => "root",
 		 :content => template("cassandra/cassandra.erb"),
		 :subscribe  => File("/usr/local/cassandra/conf/")	 
)
end



 
