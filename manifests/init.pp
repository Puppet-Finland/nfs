##
# == Class nfs
#
# Installs common NFS packages. This class is needed on nfs clients.
#
# == Authors
#
# Mikko Vilpponen <vilpponen@protecomp.fi>
##
class nfs {
	include nfs::install
}