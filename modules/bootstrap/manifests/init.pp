# Bootstrap dans une classe


class bootstrap () {
  
  include bootstrap::user
  include bootstrap::ssh

  
  file { "/etc/motd":
    ensure => "present",
    owner  => "root",
    group  => "root",
    mode   => "0644",
    content => epp("bootstrap/motd.epp"),
  }
  
}

