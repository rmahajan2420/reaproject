class rea_sinatra_app{
  require nginx
  require unicorn
 exec {
  'clone_rea':
    command => "/usr/bin/git clone git://github.com/tnh/simple-sinatra-app.git $nginx::params::appdir",
    creates => "$nginx::params::appdir",
    require => Package ['git'],
  }
 file {
    '/var/www/simple-sinatra-app/':
      ensure => directory,
      mode => 0755,
      owner => 'nginx',
      group => 'web',
      require => Exec ['clone_rea'];
    '/var/www/simple-sinatra-app/logs':
      ensure => directory,
      mode => 0755,
      owner => 'nginx',
      group => 'web',
      require => Exec ['clone_rea'];
    '/var/www/simple-sinatra-app/sockets':
      ensure => directory,
      mode => 0755,
      owner => 'nginx',
      group => 'web',
      require => Exec ['clone_rea'];
    '/var/www/simple-sinatra-app/pids':
      ensure => directory,
      mode => 0755,
      owner => 'nginx',
      group => 'web',
      require => Exec ['clone_rea'];
    "$nginx::params::appdir/unicorn.conf.rb":
      mode => 0755,
      owner => 'nginx',
      group => 'web',
      content => template('rea_sinatra_app/unicorn.erb'),
      require => [Package ['unicorn'], Exec ['clone_rea']],
      notify => Exec ['unicorn run'];
  }
  exec {
  'unicorn run':
    #command  => "/usr/local/bin/unicorn -D -c $nginx::params::appdir/unicorn.conf.rb",
    command  => "/etc/puppet/modules/rea_sinatra_app/files/unicorn_restart.sh",
    refreshonly => true,
    require => [Package ['unicorn'], Exec ['clone_rea']];
  'bundle run':
    command => "/usr/local/bin/bundle install --gemfile  $nginx::params::appdir/Gemfile",
    require     => [Package['bundle'],Exec['clone_rea']];
  }
}
