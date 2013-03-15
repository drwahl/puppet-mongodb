# Add a node to a replica set. This definition should only exist in one node
# file for the entire cluster (a "master" server, if you will)
define mongodb::replica_set (
    $arbiterOnly = false,
    $hosts       = []
) {

    exec { 'initialize_replset':
        command => '/usr/local/bin/mongo/rs_initialize.sh',
        unless  => '/usr/local/bin/mongo/rs_status.py',
        user    => 'root',
        group   => 'root'
    }

    mongodb::add_rs_node { $hosts:
        require => Exec['initialize_replset']
    }

}
