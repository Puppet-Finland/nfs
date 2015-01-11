##
# == Class: nfs::server::service
# 
# Service definitions for NFS server
#
# == Authors
#
# Mikko Vilpponen <vilpponen@protecomp.fi>
##
class nfs::server::service inherits nfs::params {

    service {'nfs-server':
        ensure => 'running',
        name   => $::nfs::params::nfs_server_service,
        enable => true,
    }

    exec {'nfs-reload':
        command     => 'exportfs -a',
        path        => '/usr/sbin',
        refreshonly => true,
        require     => Service['nfs-server'],
    }
}
