Vagrant.configure(2) do |config|

  config.vm.define :saltmaster01 do |saltmaster01|
    #mount root to ./saltmaster01 directory for using host machine editors
    #saltmaster01.vm.synced_folder "mnt/saltmaster01/", "/",
     # create: true

    saltmaster01.vm.box = "ubuntucloud/trusty64"
    saltmaster01.vm.network :private_network, :ip => "10.1.1.10"
    saltmaster01.vm.hostname = "saltmaster01"

    #upload files
    saltmaster01.vm.provision "file",
      source: "files/saltmaster01/master",
      destination: "/tmp/master"
    saltmaster01.vm.provision "file",
      source: "files/saltmaster01/db.local.lan",
      destination: "/tmp/db.local.lan"
    saltmaster01.vm.provision "file",
      source: "files/saltmaster01/named.conf.local",
      destination: "/tmp/named.conf.local"
    saltmaster01.vm.provision "file",
      source: "files/saltmaster01/named.conf.options",
      destination: "/tmp/named.conf.options"
    saltmaster01.vm.provision "file",
      source: "files/saltmaster01/install.sls",
      destination: "/tmp/install.sls"
    saltmaster01.vm.provision "file",
      source: "files/saltmaster01/state_top.sls",
      destination: "/tmp/state_top.sls"

    #install salt
    saltmaster01.vm.provision "shell",
      inline: "curl -L https://bootstrap.saltstack.com -o /tmp/install_salt.sh"
    saltmaster01.vm.provision "shell",
      inline: "sh /tmp/install_salt.sh -M -P git v2015.8.7"

    #setups up salt tree, and boostraps initial DNS server
    saltmaster01.vm.provision "shell",
      path: "scripts/saltmaster01/configure_salt"

  end

  config.vm.define :dns01 do |dns01|
    dns01.vm.box = "ubuntucloud/trusty64"
    dns01.vm.network :private_network, :ip => "10.1.1.2"
    dns01.vm.hostname = "dns01"

    #Boostrap salt resolution
    dns01.vm.provision "shell",
      inline: "echo '10.1.1.10 salt' >> /etc/hosts"

    #Install salt
    dns01.vm.provision "shell",
      inline: "curl -L https://bootstrap.saltstack.com -o /tmp/install_salt.sh"
    dns01.vm.provision "shell",
      inline: "sh /tmp/install_salt.sh -P git v2015.8.7"

    #Boostrap DNS (Needs to be done after salt install)
    #dns01.vm.provision "shell",
      #inline: "echo 'nameserver 10.1.1.2' > /etc/resolv.conf"
    #dns01.vm.provision "shell",
      #inline: "echo 'search local.lan' >> /etc/resolv.conf"
  end
end
