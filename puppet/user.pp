# Définition basique d'un utilisateur
user { 'sylvain':
  ensure   => 'present',
  comment  => 'Créé via puppet',
  shell    => '/bin/zsh',
}
