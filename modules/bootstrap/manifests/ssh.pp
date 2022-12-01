class bootstrap::ssh {   
  augeas { "sshd_authent":
    context => "/files/etc/ssh/sshd_config",
    changes => "set PasswordAuthentication no",
    require => Ssh_authorized_key["bootstrap_userkeyfile"],
    notify => Service["sshd"],
  }
  
  service { "sshd":
    ensure => "running",
    enable   => true,
  }
}
