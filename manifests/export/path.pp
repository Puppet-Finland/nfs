#
# == Define: nfs::export::path
# 
# Definition for the directory side in nfs export.
# Use nfs::export instead, and nfs::export::client if needed.
#
# == Arguments
#
# title: The path to export
# client: Initial client
#
# == Authors
#
# Mikko Vilpponen <vilpponen@protecomp.fi>
#
define nfs::export::path
(
    $client,
    $ensure = 'present'
)
{
    if $ensure == 'present' {
        augeas{ "nfs export ${title}":
            context => '/files/etc/exports',
            changes => [
                "set dir[. = '${title}'] ${title}",
                "set dir[. = '${title}']/client[. = '${client}'] ${client}",
            ],
            notify  => Exec['nfs-reload'],
        }
    } else {
        augeas{ "nfs export ${title}":
            context => '/files/etc/exports',
            changes => [
                        "rm dir[. = '${title}']",
                        ],
            notify  => Exec['nfs-reload'],
        }
    }
}
