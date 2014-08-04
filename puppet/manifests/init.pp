class core {
  
    exec { "apt-update":
      command => "/usr/bin/sudo apt-get -y update"
    }
  
    package { 
      [ "vim", "git-core", "build-essential" ]:
        ensure => ["installed"],
        require => Exec['apt-update']    
    }
}

class networking {
    package { 
      [ "curl", "wget" ]:
        ensure => ["installed"],
        require => Exec['apt-update']    
    }
    
}

class users {
    group {'vinay':
        ensure => present,
    }

    user {'vinay':
        ensure => present,
        gid => 'vinay',
        shell => '/bin/bash',
        home => '/home/vinay',
        managehome => 'true',
        password => 'vinay',
    }
}

include core
include networking
include users

include vs::python
include vs::web
include vs::flask

#include db::mongodb
$mysql_password = "root123"
include db::mysql
include testapp::db
