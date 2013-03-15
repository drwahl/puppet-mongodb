# == Class: mongodb
#
# This class will setup and configure a MongoDB server
#
# === Parameters
#
# [use_10gen]
# Default: False
# Specifies whether to use the 10gen packages or not.  Default is to use the
# Redhat supplied packages.
#
# [bind_ip]
# Default: 127.0.0.1
# The IP address to which the mongod service will bind
#
# [port]
# Default: undef
# The TCP port to which the mongod service will bind. If unset, mongodb will
# listen on 0.0.0.0 (all interfaces).
#
# [dbfork]
# Default: true
# If true, run mongod in daemon mode. If false, run mongod
# in foreground
#
# [pidfilepath]
# Default: /var/run/mongodb/mongodb.pid
# Filesystem location to store the pid file
#
# [logpath]
# Default: /var/log/mongodb/mongodb.log
# Filesystem location to write logs
#
# [dbpath]
# Default: /var/lib/mongodb/
# Filesystem location to store database binaries
#
# [directoryperdb}
# Default: False
# Store each database in a seperate folder inside dbpath
#
# [journal]
# Default: true
# If true, mongod will enable write-ahead journaling
#
# [cpu]
# Default: false
# Enables periodic logging of CPU utilization and I/O wait
#
# [noauth]
# Default: true
# Turn on/off security.  Off is currently the default
#
# [auth]
# Default: true
# Turn on/off security.  Off is currently the default
#
# [verbose]
# Default: true
# Verbose logging output
#
# [objcheck]
# Default: true
# Inspect all client data for validity on receipt (useful for
# developing drivers)
#
# [quota]
# Default: true
# Enable db quota management
#
# [oplog]
# Default: 0
# Set oplogging level where n is
#  0=off (default)
#  1=W
#  2=R
#  3=both
#  7=W+some reads
#
# [nocursors]
# Default: true
# Diagnostic/debugging option
#
# [nohints]
# Default: true
# Ignore query hints
#
# [nohttpinterface]
# Default: true
# Disable the HTTP interface (Defaults to port+1000)
#
# [noscripting]
# Default: true
# Turns off server-side scripting.  This will result in greatly
# limited functionality
#
# [notablescan]
# Default: true
# Turns off table scans.  Any query that would do a table scan fails.
#
# [noprealloc]
# Default: true
# Disable data file preallocation
#
# [nssize]
# Default:
# Specify .ns file size for new databases
#
# [mms_token]
# Default:
# Accout token for Mongo monitoring server
#
# [mms-name]
# Default:
# Server name for Mongo monitoring server
#
# [mms_interval]
# Default:
# Ping interval for Mongo monitoring server
#
# [slave]
# Default:
# In replicated mongo databases, specify here whether this is
# a slave or master. This is mutually exlusive with master/master_source
#
# [slave_source]
# Default:
# Specify here where what mongodb master to replicate from.
# This is mutually exlusive with master/master_source
#
# [slave_only]
# Default:
# Specify a single database to replicate. This is mutually
# exlusive with master/master_source
#
# [master]
# Default:
# Specifies that this instance is the master of a replication pair.
# This is mutually exlusive with slave/slave_source/slave_only
#
# [master_source]
# Default:
# Specifies a slave from which to initialize. This is mutually
# exlusive with slave/slave_source/slave_only
#
# [pairwith]
# Default:
# Address of a server to pair with
#
# [arbiter]
# Default:
# Address of arbiter server
#
# [autoresync]
# Default: false
# Automatically resync if slave data is stale
#
# [replset]
# Default: undef
# Name of the replication set to be apart of.  Mutually exclusive with
# all other clustering configurations.
#
# [replsetmembers]
# Default: undef
# Array of members that belong to a given replica set.  This should only be set
# on the master node.
#
# [configsvr]
# Default: undef
# Specify wheter this is a config server.  Valid settings are true or false.
#
# [configsdb]
# Default: undef
# Define what hosts to query for sharding configuration. This will be a comma
# seperated list. Example:
# "mongo-cfg01.example.com:27017,mongo-cfg02.example.com:27017,mongo-cfg03.example.com:27017"
#
# [oplogSize]
# Default: 2048 (2GB)
# Custom size for replication operation log. By default, MongoDB will try to
# pre-allocate up to 5% of the free space on the partition $dbpath resides on
# during replicaSet initialization. If the disk is very large, this can cause
# rs.initiate() to "hang". This value is in MB, so 1024 is 1GB.
#
# [opIdMem]
# Default:
# Size limit for in-memory storage of op ids
#
# [user]
# Default: False
# Specifies the user the mongod process will be running as. This is mostly used
# for ensuring permissions on files/folders. When set to False, the puppet
# module will determine what the user name should be.
#
# [group]
# Default: False
# Specifies the group the mongod process will be running as. This is mostly used
# for ensuring permissions on files/folders. When set to False, the puppet
# module will determine what the group name should be.
#
# === Examples
#
# === Author
#
# David Wahlstrom <dwahlstrom@classmates.com>
#
class mongodb (
    $use_10gen       = false,
    $bind_ip         = undef,
    $port            = 27017,
    $dbfork          = true,
    $pidfilepath     = '/var/run/mongodb/mongodb.pid',
    $logpath         = '/var/log/mongodb/mongodb.log',
    $dbpath          = '/var/lib/mongodb',
    $directoryperdb  = true,
    $journal         = true,
    $cpu             = undef,
    $noauth          = undef,
    $auth            = undef,
    $verbose         = undef,
    $objcheck        = undef,
    $quota           = undef,
    $oplog           = undef,
    $nocursors       = undef,
    $nohints         = undef,
    $nohttpinterface = true,
    $noscripting     = undef,
    $notablescan     = undef,
    $noprealloc      = undef,
    $nssize          = undef,
    $mms_token       = undef,
    $mms_name        = undef,
    $mms_interval    = undef,
    $slave           = undef,
    $slave_source    = undef,
    $slave_only      = undef,
    $master          = undef,
    $master_source   = undef,
    $pairwith        = undef,
    $arbiter         = undef,
    $autoresync      = undef,
    $replset         = undef,
    $replsetmembers  = undef,
    $configsvr       = undef,
    $configdb        = undef,
    $oplogSize       = 2048,
    $opIdMem         = undef,
    $user            = false,
    $group           = false
){

    if $use_10gen == true {
        $mongo_server = 'mongo-10gen-server'
        $mongo_client = 'mongo-10gen'
        $mongo_config = '/etc/mongod.conf'
        $not_mongo_config = '/etc/mongodb.conf'
        if $user == false {
            $dbuser = 'mongod'
        } else {
            $dbuser = $user
        }
        if $group == false {
            $dbgroup = 'mongod'
        } else {
            $dbgroup = $group
        }

        include yum::repo::10gen

    } else {
        $mongo_server = 'mongodb-server'
        $mongo_client = 'mongodb'
        $mongo_config = '/etc/mongodb.conf'
        $not_mongo_config = '/etc/mongod.conf'
        if $user == false {
            $dbuser = 'mongodb'
        } else {
            $dbuser = $user
        }
        if $group == false {
            $dbgroup = 'mongodb'
        } else {
            $dbgroup = $group
        }
    }

    package { 'pymongo':
        ensure => present
    }

    package { $mongo_server:
        ensure  => present
    }

    package { $mongo_client:
        ensure  => present
    }

    service { 'mongod':
        ensure  => running,
        enable  => true,
        require => Package[$mongo_server]
    }

    file { $mongo_config:
        ensure  => present,
        content => template('mongodb/mongodb.conf.erb'),
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        notify  => Service['mongod']
    }

    file { $not_mongo_config:
        ensure  => link,
        target  => $mongo_config
    }

    file { $dbpath:
        ensure  => directory,
        owner   => $dbuser,
        group   => $dbgroup,
        require => Package[$mongo_server]
    }

    #this directory is used for sharding/config server
    file { '/var/lib/mongodb-config':
        ensure  => directory,
        owner   => $dbuser,
        group   => $dbgroup,
        require => Package[$mongo_server]
    }

    file { '/var/log/mongodb':
        ensure  => directory,
        owner   => $dbuser,
        group   => $dbgroup,
        require => Package[$mongo_server]
    }

    file { '/usr/local/bin/mongo':
        ensure => directory,
        owner  => 'root',
        group  => 'root',
        mode   => '0755'
    }

    file { '/usr/local/bin/mongo/rs_status.py':
        ensure  => present,
        content => template('mongodb/rs_status.py.erb'),
        owner   => 'root',
        group   => 'root',
        mode    => '0755',
        require => File['/usr/local/bin/mongo']
    }

    file { '/usr/local/bin/mongo/rs_add_node.py':
        ensure  => present,
        content => template('mongodb/rs_add_node.py.erb'),
        owner   => 'root',
        group   => 'root',
        mode    => '0755',
        require => File['/usr/local/bin/mongo']
    }

    file { '/usr/local/bin/mongo/rs_initialize.sh':
        ensure  => present,
        content => template('mongodb/rs_initialize.sh.erb'),
        owner   => 'root',
        group   => 'root',
        mode    => '0755',
        require => File['/usr/local/bin/mongo']
    }

    file { '/usr/local/bin/mongo/rs_verify_node.py':
        ensure  => present,
        content => template('mongodb/rs_verify_node.py.erb'),
        owner   => 'root',
        group   => 'root',
        mode    => '0755',
        require => File['/usr/local/bin/mongo']
    }

}
