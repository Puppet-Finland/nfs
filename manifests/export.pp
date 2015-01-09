#
# == Define: nfs::export
# 
# Definition for a NFS directory export with one client and options.
#
# A convenient wrapper for nfs::export::path and nfs::export::client 
# definitions. You can use additional nfs:export::client resources to add 
# different options to different clients.
#
# If you remove an export with ensure => absent argument, make sure there are no 
# additional nfs::export::client definitions for this export path.
#
# == Parameters
#
# [*title*]
#   The path to export
# [*client*]
#   Client specifier (for example '*', '127.0.0.1' or '192.168.0.0/16')
# [*options*]
#   An array of NFS options (for example ['rw', 'root_squash'])
#
# == Authors
#
# Mikko Vilpponen <vilpponen@protecomp.fi>
#
define nfs::export
(
    $client,
    $options,
    $ensure = 'present'
)
{
    nfs::export::path { $title:
        client => $client,
        ensure => $ensure,
    }
    nfs::export::client { "${client} on ${path}":
        client  => $client,
        path    => $title,
        options => $options,
        ensure  => $ensure,
    }
}
