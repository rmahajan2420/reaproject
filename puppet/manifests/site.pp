## site.pp ##

# This file (/etc/puppetlabs/puppet/manifests/site.pp) is the main entry point
# used when an agent connects to a master and asks for an updated configuration.
#
# Global objects like filebuckets and resource defaults should go in this file,
# as should the default node definition. (The default node can be omitted
# if you use the console and don't define any other nodes in site.pp. See
# http://docs.puppetlabs.com/guides/language_guide.html#nodes for more on
# node definitions.)

## Active Configurations ##

# PRIMARY FILEBUCKET
# This configures puppet agent and puppet inspect to back up file contents when
# they run. The Puppet Enterprise console needs this to display file contents
# and differences.

# Define filebucket 'main':
filebucket { 'main':
  server => 'puppet',
  path   => false,
}

# Make filebucket 'main' the default backup location for all File resources:
File { backup => 'main' }

#resources { "firewall":
#  purge => false
#}

#Firewall {
#  before  => Class['redemption_firewall::post'],
#  require => Class['redemption_firewall::pre'],
#}

#class { ['redemption_firewall::pre', 'redemption_firewall::post']: }
#class { 'firewall': }

# DEFAULT NODE
# Node definitions in this file are merged with node data from the console. See
# http://docs.puppetlabs.com/guides/language_guide.html#nodes for more on
# node definitions.

# The default node definition matches any node lacking a more specific node
# definition. If there are no other nodes in this file, classes declared here
# will be included in every node's catalog, *in addition* to any classes
# specified in the console for that node.
#if $::puppetversion != '3.3.1 (Puppet Enterprise 3.1.0)' {
#  Package {
#    allow_virtual => true,
#  }
#}

node default {

  # This is where you can declare classes for all nodes.
  # Example:
  #   class { 'my_class': }
    hiera_include('classes')
}
#set the default for virtual pacakges needed in ver >3.3
#Package {  allow_virtual => false, }
if versioncmp($::puppetversion,'3.6.1') >= 0 {

  $allow_virtual_packages = hiera('allow_virtual_packages',false)

  Package {
    allow_virtual => $allow_virtual_packages,
  }
}
