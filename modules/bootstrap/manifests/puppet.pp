class bootstrap::puppet {
  if $osfamily == "RedHat" {
    # Garantie de présence pour puppet et le repo puppet-release
    yumrepo { 'puppet':
      ensure   => 'present',
      baseurl  => 'http://yum.puppetlabs.com/puppet/el/8/$basearch',
      descr    => 'Puppet Repository el 8 - $basearch',
      enabled  => '1',
      gpgcheck => '1',
      gpgkey   => "http://yum.puppet.com/RPM-GPG-KEY-puppet-20250406",
      before => Package["puppet-agent"],
    }
  }
  if $operatingsystem == "Debian" {
    include apt
    apt::source { 'puppetlabs':
      location => 'http://apt.puppetlabs.com',
      repos    => 'main',
      key      => {
          'id'     => '6F6B15509CF8E59E6E469F327F438280EF8D349F',
          'server' => 'pgp.mit.edu',
      },
    }
  }
  
  package { 'puppet-agent':
    ensure => 'latest',
  }
  
  service { 'puppet':
    ensure => 'running',
    enable => 'true',
    subscribe => Package['puppet-agent'],
  }
}
