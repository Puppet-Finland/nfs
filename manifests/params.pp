##
# == Class nfs::params
#
# Parametres for NFS packages and services
#
# == Authors
#
# Mikko Vilpponen <vilpponen@protecomp.fi>
##
class nfs::params {
	
	$nfs_common_package = 'nfs-common'
	
	$nfs_server_package = 'nfs-kernel-server'
	$nfs_server_service = 'nfs-kernel-server'
	
}