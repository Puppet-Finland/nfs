##
# == Class nfs::install
#
# Installs common NFS packages.
#
# == Authors
#
# Mikko Vilpponen <vilpponen@protecomp.fi>
##
class nfs::install inherits nfs::params {
	
    package {'nfs-common':
        name => $::nfs::params::nfs_common_package,
        ensure => 'installed',
    }
}