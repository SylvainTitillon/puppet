class bootstrap::user (String $bootstrap_username = 'gilles') { 
  user { "$bootstrap_username":
    ensure => "present",
    comment => "Utilisateur poussé par Puppet",
    shell => "/bin/bash",
    managehome => true,
  }
  
  # Home à garantir, dans le cas où l'user existe, sans home
  file { "/home/$bootstrap_username":
    ensure => "directory",
    mode => "0755",
    owner => "$bootstrap_username",
    group => "$bootstrap_username",
    require => User["$bootstrap_username"]
  }
  
  # Clé ssh pour vagrant@
  file { "/home/$bootstrap_username/.ssh":
    ensure => "directory",
    mode => "0700",
    owner => "$bootstrap_username",
    group => "$bootstrap_username",
    require => User["$bootstrap_username"]
  }
  
  ssh_authorized_key { "bootstrap_userkeyfile":
    key => "AAAAC3NzaC1lZDI1NTE5AAAAIJxkUl6nWag8Dk53gyPoXx6GQ2qmIvjNGjtke+CoD9W4",
    user => "$bootstrap_username",
    type => "ssh-ed25519",
    require => File["/home/$bootstrap_username/.ssh"],
  }
 
  file { "/etc/sudoers.d/puppet":
    owner => "root",
    group => "root",
    mode => "0600",
    content => "$bootstrap_username ALL=(ALL) NOPASSWD: ALL",
  }
}
