#
# == Class: nfs::install
#
# Installs common NFS packages.
#
# == Authors
#
# Mikko Vilpponen <vilpponen@protecomp.fi>
#
class nfs::install inherits nfs::params {

    package { 'nfs-nfs-common':
        ensure => 'installed',
        name   => $::nfs::params::nfs_common_package,
    }
}
