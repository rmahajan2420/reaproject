class nginx::params {
  $nginxVars = hiera_hash('nginx')
  $group   = $nginxVars['group']
  $owner   = $nginxVars['owner']
  $appdir = $nginxVars['appdir']
  $sockets = $nginxVars['sockets']
  $hostname = $nginxVars['hostname']
}

