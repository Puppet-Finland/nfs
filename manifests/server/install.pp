##
# == Class: nfs::server::install
#
# Installs NFS server components
#
# == Authors
#
# Mikko Vilpponen <vilpponen@protecomp.fi>
##

class nfs::server::install inherits nfs::params {
    # Install common NFS packages
    include nfs::install

    package {"nfs-server":
        name   => $::nfs::params::nfs_server_package,
        ensure => installed,
    }
}