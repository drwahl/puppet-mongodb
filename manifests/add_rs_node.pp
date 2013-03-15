# process for adding a node to a replica set
define mongodb::add_rs_node(
){

    exec { "add_node_${name}":
        command => "/usr/local/bin/mongo/rs_add_node.py ${name}",
        unless  => "/usr/local/bin/mongo/rs_verify_node.py ${name}",
    }
}
