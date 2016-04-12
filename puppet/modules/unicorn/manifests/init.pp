class unicorn {
  require nginx
  require nginx::params
 package{
    'ruby':
      ensure => present;
      'ruby-devel':
      ensure => present,
      provider => rpm,
      source => '/tmp/ruby-devel-2.0.0.598-25.el7_1.x86_64.rpm';
    'git':
      ensure => present;
    'gcc':
      ensure => present;
    'rubygems':
      ensure => present;
    'bundle':
      ensure => present,
      provider => gem,
      require => Package ['rubygems'];
    'io-console':
      ensure => present,
      provider => gem,
      require => Package ['rubygems'];
    'unicorn':
      ensure => present,
      provider => gem,
      require => [Package ['rubygems'], Package['io-console'], Package ['gcc'], Package['bundle'], ];
  }
   file {
    '/var/www/':
      ensure => directory,
      mode => 0755,
      owner => 'nginx',
      group => 'web';
  }
}
