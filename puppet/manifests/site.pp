include bootstrap
include puppet

$fichier_apache = $hostname ? {
  "node2" => "debian",
  default => "node",
}

class { 'apache':
  fichier => "$fichier_apache",
}
