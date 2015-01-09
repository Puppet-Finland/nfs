#
# == Class: nfs::server
# 
# Installs and configures NFS server
#
# == Authors
#
# Mikko Vilpponen <vilpponen@protecomp.fi>
#
class nfs::server
(
    $exports = {}

) inherits nfs::params 
{

    create_resources('nfs::export', $exports)

    include nfs::install

    include nfs::server::install
    include nfs::server::config
    include nfs::server::service
}
