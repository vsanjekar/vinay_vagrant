class db::mysql ($root_password = 'root123', $config_path = 'puppet:///modules/db/my.cnf') {
  $bin = '/usr/bin:/usr/sbin'

  if ! defined(Package['mysql-server']) {
    package { 'mysql-server':
      ensure => 'present',
    }
  }

  if ! defined(Package['mysql-client']) {
    package { 'mysql-client':
      ensure => 'present',
    }
  }

/*
  service { 'mysqld':
    enable => 'true',
    ensure => 'running',
    require => Package['mysql-server'],
  }
*/

  service { 'mysql':
    alias   => 'mysql::mysql',
    enable  => 'true',
    ensure  => 'running',
    require => Package['mysql-server'],
  }

  # Override default MySQL settings.
  file { '/etc/mysql/conf.d/vagrant.cnf':
    owner   => 'mysql',
    group   => 'mysql',
    source  => $config_path,
    notify  => Service['mysql::mysql'],
    require => Package['mysql-server'],
  }

  # Set the root password.
  exec { 'mysql::set_root_password':
    unless  => "mysqladmin -uroot -p${root_password} status",
    command => "mysqladmin -uroot password ${root_password}",
    path    => $bin,
    require => Service['mysql::mysql'],
  }

}

define create_mysqldb( $user, $password ) {
  exec { "create-${name}-db":
    unless => "/usr/bin/mysql -u${user} -p${password} ${name}",
    command => "/usr/bin/mysql -uroot -p$mysql_password -e \"create database ${name}; grant all on ${name}.* to ${user}@localhost identified by '$password';\"",
    require => Service["mysql"],
  }
}

class testapp::db {
    create_mysqldb { "testapp_db":
        user => "root",
        password => "root123",
    }
}

/*
define mysql::db::create ($dbname = $title) {
  exec { "mysql::db::create_${dbname}":
    command => "mysql -uroot -p${mysql::root_password} -e \"CREATE DATABASE IF NOT EXISTS ${dbname}\"",
    path    => $mysql::bin,
    require => Exec['mysql::set_root_password'],
  }
}

mysql::db::create { 'testdb':
    user     => 'root',
    password => 'root123',
    host     => 'localhost',
    grant    => ['SELECT', 'UPDATE', 'DELETE'],
} 
*/

/*
  # Delete the anonymous accounts.
  mysql::user::drop { 'anonymous':
    user => '',
  }
*/

/*
define mysql::user::drop ($user = $title, $host = '') {
  if $host == '' {
    $check_sql = "SELECT EXISTS(SELECT `user` FROM `mysql`.`user` WHERE `user` = '${user}' AND `host` = '${host}');"
    $drop_sql  = "DROP USER '${user}"
  } else {
    $check_sql = "SELECT EXISTS(SELECT `user` FROM `mysql`.`user` WHERE `user` = '${user}');"
    $drop_sql  = "DROP USER '${user}@${host}'"
  }

  exec { "mysql::user::drop_${user}_${host}":
    command => "mysql -uroot -p${mysql::root_password} -e \"${drop_sql}\"",
    returns => '1',
    unless  => "mysql -uroot -p${mysql::root_password} -e \"${check_sql}\"",
    path    => $mysql::bin,
    require => Exec['mysql::set_root_password'],
  }
}
*/

/*
class mysql {
  
  exec { "apt-update-repo":
    command => "/usr/bin/apt-get -y update"
  }

  package {
    ["mysql-client", "mysql-server", "libmysqlclient-dev", "redis-server", "postgresql", "postgresql-client"]: 
      ensure => installed, 
      require => Exec['apt-update']
  }
  
  service { "mysql":
    ensure    => running,
    enable    => true,
    require => Package["mysql-server"],  
  }

  exec { "set-mysql-password":
    unless  => "mysql -uroot -proot",
    path    => ["/bin", "/usr/bin"],
    command => "mysqladmin -uroot password root",
    require => Service["mysql"],

  }

  service { "redis-server":
    ensure    => running,
    enable    => true,
    require => Package["redis-server"],  
  }

  service { "postgresql-8.4":
    ensure    => running,
    enable    => true,
    require => Package["postgresql"],  
  }
  
}

define sql::db::create ($dbname = $title) {
  exec { "mysql::db::create_${dbname}":
    command => "mysql -uroot -p${mysql::root_password} -e \"CREATE DATABASE IF NOT EXISTS ${dbname}\"",
    path    => $mysql::bin,
    require => Exec['mysql::set_root_password'],
  }
}

class blogpost {

  class { '::mysql::server':
    root_password    => 'strongpassword',
    override_options => { 'mysqld' => { 'max_connections' => '1024' } }
  }

  mysql::db { 'statedb':
    user     => 'admin',
    password => 'secret',
    host     => 'master.puppetlabs.vm',
    sql        => '/tmp/states.sql',
    require => File['/tmp/states.sql'],
  }

  file { "/tmp/states.sql":
    ensure => present,
    source => "puppet:///modules/blogpost/states.sql",
  }

  mysql_user { 'bob@localhost':
    ensure                   => 'present',
    max_connections_per_hour => '60',
    max_queries_per_hour     => '120',
    max_updates_per_hour     => '120',
    max_user_connections     => '10',
  }

  mysql_grant { 'bob@localhost/statedb.states':
    ensure     => 'present',
    options    => ['GRANT'],
    privileges => ['ALL'],
    table      => 'statedbl.states',
    user       => 'bob@localhost',
  }

}
*/
