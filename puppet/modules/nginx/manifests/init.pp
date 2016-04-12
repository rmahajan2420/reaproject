class nginx {
  require nginx::params
  service { 'nginx':
    ensure => true,
    enable => true,
    require => Package ['nginx'];
  }
  package { 'nginx':
    ensure => present,
  }
  group {
    'web':
    ensure => present,
    require => Package ['nginx'];
  }
  file {
    '/etc/nginx/nginx.conf':
      content => template('nginx/nginx.erb'),
      require => Package ['nginx'],
      notify => Exec [ 'restart nginx'];
  }
  exec {
    'restart nginx':
      command => '/bin/systemctl restart nginx.service',
      refreshonly => true,
      require => Service ['nginx'];
  }
}
