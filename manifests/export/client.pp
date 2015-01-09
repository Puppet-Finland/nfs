#
# == Define: nfs::export::client
# 
# Definition for the NFS export client-specific configuration. If you need 
# options for multiple clients, first use nfs::export and then add 
# nfs::export::client with the same path.
#
# == Arguments
#
# [*path*]
#   The exported path, should be already defined with nfs::export
# [*client*]
#   The client specifier, for example '*' or '192.168.0.0/16'
# [*options*]
#   Array of client-specific options, for example ['rw', 'root_squash']
#
# == Authors
#
# Mikko Vilpponen <vilpponen@protecomp.fi>
#
define nfs::export::client
(
    $path,
    $client,
    $options,
    $ensure = 'present',
)
{
    if $ensure == 'present' {
        # Make sure the client specifier is in place
        augeas { $title:
            context => "/files/etc/exports/dir[. = '${path}']",
            changes => [
                        "set client[. = ${client}] ${client}",
                        ],
            require => Nfs::Export::Path[$path],
            notify  => Exec['nfs-reload'],

        }
        # Convert options array to augeas commands
        $options_command_array = regsubst($options, '(.*)', "set option[. = '\1'] \1")

        # Then, add extra command to remove all non-specified options. Format and join options array as:
        # ['opt_1', 'opt_2', ... 'opt_n']  =>
        # ". != 'opt_1' and . != 'opt_2' and ... and . != 'opt_n'"

        # "join()" is puppetlabs-stdlib function
        $all_options = join(regsubst($options, '(.*)', ". != '\1'"), ' and ')
        $remove_extra_options = "rm option[${all_options}]"

        augeas { "options for ${title}":
            context => "/files/etc/exports/dir[. = '${path}']/client[. = '${client}']",
            changes => concat($options_command_array, $remove_extra_options),
            require => Augeas[$title],
            notify  => Exec['nfs-reload'],
        }
    }
    else {
        augeas{ $title:
            context => "/files/etc/exports",
            changes => [
                        "remove dir[. = '${title}']/client[. = ${client}]",
                        ],
            notify  => Exec['nfs-reload'],
        }
    }
}
