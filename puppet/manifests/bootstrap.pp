class bootstrap	{

 $bootstrap_username = "sylvain"

 user { "$bootstrap_username":
   ensure => "present",
   comment => "Utilisateur poussé par puppet",
   shell => "/bin/bash",
   managehome => true,
 }


 $key="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINzQotaZwITkQeWUy8EfqvdIYTJ0Sz/VTqvRqN3fcFX3 ib@ib-VirtualBox"

 file {"/etc/motd":
   ensure => "present",
   owner => "root",
   group => "root",
   content => "OS = $facts{['os']['name']}/n Distro = $facts{['os']['distro']['release']}",
 }

 package {"vim":
   ensure => 'latest',
 }

 file { "/home/$bootstrap_username/.ssh":
   ensure => "directory",
   mode => "0700",
   owner => "$bootstrap_username",
   group => "$bootstrap_username",
 }

 file { "/home/$bootstrap_username/.ssh/authorized_keys":
   content => "$key",
   mode => '0600',
   owner => "$bootstrap_username",
   group => "$bootstrap_username",
   require => File["/home/$bootstrap_username/.ssh"],
 }

 augeas { "modify_sshd_config":
   context => "/files/etc/ssh/sshd_config",
   changes => "set PasswordAuthentication no",
   require => File["/home/$bootstrap_username/.ssh/authorized_keys"],
   notify => Service["sshd"],
 }

 service { "sshd":
   ensure => "running",
   enable => 'true',
 }

 file {"/etc/sudoers.d/puppet":
   owner => "root",
   group => "root",
   mode => "0600",
   content => "$bootstrap_username ALL=(ALL) NOPASSWD: ALL",
 }

}

