
include bootstrap
include bootstrap::puppet

$message = lookup("message")

notify { "message: $message": }

node node1.localdomain {
  include apache
}

node node2.localdomain {
  include apache
}

node default {
  notify {'ras': }
}
