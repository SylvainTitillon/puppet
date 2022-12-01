class puppet {
 if $osfamily == "RedHat" {
   yumrepo {"puppet":
     ensure => 'present',
     baseurl => "http://yum.puppetlabs.com/puppet/el/8/$basearch",
     descr => "Add repo yum puppet",
     enabled => 1,
     gpgcheck => 0,
     gpgkey => "https://yum.puppet.com/RPM-GPG-KEY-puppet-200250406",
   }
 }
 elsif $osid == "Debian" {
   file { "/etc/apt/sources.list.d/puppet.list":
    ensure => 'present',
    content => "https://apt.puppetlabs.com bullseye release",  
   }
 }

 package {"puppet-agent":
   ensure => 'latest',
 }

 service {'puppet':
   ensure => 'running',
   enable => 'true',
 }

}
