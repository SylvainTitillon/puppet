class apache {

 $apache_package = $osfamily ? {
    "RedHat" => "httpd",
    "Debian" => "apache2",
 }

 $apache_service = $apache_package

 package {"$apache_package":
   ensure => "present",
 }
 
 service { "$apache_package":
  ensure => "running",
  enable => true,
  require => Package["$apache_package"],
 }
 
 file { "/var/www/html/index.html":
  ensure => "present",
  content => "Bonjour, vous etes sur $hostname",
  require => Package["$apache_package"],
 }
}

notify { 'déclaration': }
include apache
