class apache (String $fichier = "node") {
  # Installation apache sur debian/rocky, avec une page d'accueil custom

  $apache_package = $osfamily ? {
    "RedHat" => "httpd",
    "Debian" => "apache2",
  }
  
  $apache_service = $apache_package

  package { "$apache_package":
    ensure => "present",
  }

  service { "$apache_service":
    ensure => "running",
    enable => true,
    require => Package["$apache_package"],
  }

  file { "/var/www/html/index.html":
    ensure => "present",
    content => "Bonjour, vous etes sur $hostname, je tourne sur ${facts['operatingsystem']}",
    require => Package["$apache_package"],
  }

  file { "/var/www/html/$fichier.html":
    ensure => "present",
    content => "Exemple de site à déployer",
    require => Package["$apache_package"],
  }
}

