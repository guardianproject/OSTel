Description
===========

PostgreSQL is a powerful, open source object-relational database system. It has more than 15 years of active development and a proven architecture that has earned it a strong reputation for reliability, data integrity, and correctness. It runs on all major operating systems, including Linux, UNIX (AIX, BSD, HP-UX, SGI IRIX, Mac OS X, Solaris, Tru64), and Windows. It is fully ACID compliant, has full support for foreign keys, joins, views, triggers, and stored procedures (in multiple languages). It includes most SQL:2008 data types, including INTEGER, NUMERIC, BOOLEAN, CHAR, VARCHAR, DATE, INTERVAL, and TIMESTAMP. It also supports storage of binary large objects, including pictures, sounds, or video. It has native programming interfaces for C/C++, Java, .Net, Perl, Python, Ruby, Tcl, ODBC, among others, and exceptional documentation.

An enterprise class database, PostgreSQL boasts sophisticated features such as Multi-Version Concurrency Control (MVCC), point in time recovery, tablespaces, asynchronous replication, nested transactions (savepoints), online/hot backups, a sophisticated query planner/optimizer, and write ahead logging for fault tolerance. It supports international character sets, multibyte character encodings, Unicode, and it is locale-aware for sorting, case-sensitivity, and formatting. It is highly scalable both in the sheer quantity of data it can manage and in the number of concurrent users it can accommodate. There are active PostgreSQL systems in production environments that manage in excess of 4 terabytes of data.

PostgreSQL has won [praise from its users][1] and [industry recognition][2], including the Linux New Media Award for Best Database System and five time winner of the The Linux Journal Editors' Choice Award for best DBMS. 

Requirements
============

## Platforms

* Ubuntu

Tested on:

* Ubuntu 11.10, 12.04

## Cookboooks

Requires Opscode's `openssl` cookbook for secure password generation.

Requires a C compiler and development headers in order to build the
`pg` RubyGem to provide Ruby bindings so they're available in other
cookbooks.

Opscode's `build-essential` cookbook provides this functionality on
Debian, Ubuntu, and EL6-family.

While not required, Opscode's `database` cookbook contains resources
and providers that can interact with a PostgreSQL database. This
cookbook is a dependency of that one.

Attributes
==========

The following attributes are set based on the platform, see the
`attributes/default.rb` file for default values.

* `node[`postgersql`][`allow`]` - Hash - Specifies the ip address range to be allowed to connect.
* `node['postgresql']['data_directory']` - Specifies the directory to use for data storage.
* `node['postgresql']['wal_directory']` - Speciies the directory to use for WAL storage.
* `node['postgresql']['data_path']` - Base directory structure for the 2 paths above to be constructed from.
* `node['postgresql']['temp_tablespaces']` - Specifies where to write temporary tablespaces
* `node['postgresql']['local_authentication']` - Specifies the authentication to use locally
* `node['postgresql']['encoding']` - Specifies the default encoding to be specified during initdb.
* `node['postgresql']['locale']` - Specifies the locale to be specified during initdb.
* `node['postgresql']['max_connections']` - Specifies the maximum connections allowed.  
* `node['postgresql']['wal_level']`  - Specifies the wal level.
* `node['postgresql']['hot_standby']` - if parameter is set to true on a standby server, it will begin accepting connections once the recovery has brought the system to a consistent state. All such connections are strictly read-only; not even temporary tables may be written.
* `node['postgresql']['hot_standby_feedback']` - Defaulted to on.  Allows you to check how far behind the replica in seconds.
* `node['postgresql']['swappiness']` - Swappiness is a property for the Linux kernel that changes the balance between swapping out runtime memory, as opposed to dropping pages from the system page cache. Swappiness can be set to values between 0 and 100 inclusive. A low value means the kernel will try to avoid swapping as much as possible where a higher value instead will make the kernel aggressively try to use swap space. 
* `node['postgresql']['kernel_sem']` - Due to the default of 65535 max_connections a higher kernel.sem sysctl must be applied.  If you raise this higher it may be required to be modified.  Defaulted to "4096 6553555 1600 65535"
* `node['postgresql']['password']` - randomly generated password by the cookbook's library.
* `node['postgresql']['ssl']` - whether to enable SSL (off for version  8.3, true for 8.4).
* `node['postgresql']['default_statistics_target']` - Sets the default statistics target for table columns that have not had a column-specific target set via ALTER TABLE SET STATISTICS. Larger values increase the time needed to do ANALYZE, but might improve the quality of the planner's estimates. The default is 10. For more information on the use of statistics by the PostgreSQL query planner, refer to [Setion 14.2][3].
* `node['postgresql']['logging_collector']` - This parameter captures plain and CSV-format log messages sent to stderr and redirects them into log files. This approach is often more useful than logging to syslog, since some types of messages might not appear in syslog output (a common example is dynamic-linker failure messages). This parameter can only be set at server start.
* `node['postgresql']['log_rotation_age']` - When logging_collector is enabled, this parameter determines the maximum lifetime of an individual log file. After this many minutes have elapsed, a new log file will be created. Set to zero to disable time-based creation of new log files. This parameter can only be set in the postgresql.conf file or on the server command line.
* `node['postgresql']['log_ratation_size']` - When logging_collector is enabled, this parameter determines the maximum size of an individual log file. After this many kilobytes have been emitted into a log file, a new log file will be created. Set to zero to disable size-based creation of new log files. This parameter can only be set in the postgresql.conf file or on the server command line.
* `node['postgresql']['checkpoint_timeout']` - Maximum time between automatic WAL checkpoints, in seconds. The default is five minutes (5min). Increasing this parameter can increase the amount of time needed for crash recovery. This parameter can only be set in the postgresql.conf file or on the server command line.
* `node['postgresql']['checkpoint_completion_target']` - Specifies the target of checkpoint completion, as a fraction of total time between checkpoints. The default is 0.5. This parameter can only be set in the postgresql.conf file or on the server command line.
* `node['postgresql']['checkpoint_warning']` - Write a message to the server log if checkpoints caused by the filling of checkpoint segment files happen closer together than this many seconds (which suggests that checkpoint_segments ought to be raised). The default is 30 seconds (30s). Zero disables the warning. This parameter can only be set in the postgresql.conf file or on the server command line.
* `node['postgresql']['checkpoint_segments']` - Maximum number of log file segments between automatic WAL checkpoints (each segment is normally 16 megabytes). The default is three segments. Increasing this parameter can increase the amount of time needed for crash recovery. This parameter can only be set in the postgresql.conf file or on the server command line.
* `node['postgresql']['shared_buffers']` - Sets the amount of memory the database server uses for shared memory buffers. The default is typically 32 megabytes (32MB), but might be less if your kernel settings will not support it (as determined during initdb). This setting must be at least 128 kilobytes.
* `node['postgresql']['effective_cache_size']` - Sets the planner's assumption about the effective size of the disk cache that is available to a single query. This is factored into estimates of the cost of using an index; a higher value makes it more likely index scans will be used, a lower value makes it more likely sequential scans will be used. When setting this parameter you should consider both PostgreSQL's shared buffers and the portion of the kernel's disk cache that will be used for PostgreSQL data files. Also, take into account the expected number of concurrent queries on different tables, since they will have to share the available space. This parameter has no effect on the size of shared memory allocated by PostgreSQL, nor does it reserve kernel disk cache; it is used only for estimation purposes. The system also does not assume data remains in the disk cache between queries. The default is 128 megabytes (128MB).
* `node['postgresql']['maintenance_work_mem']` - Specifies the maximum amount of memory to be used by maintenance operations, such as VACUUM, CREATE INDEX, and ALTER TABLE ADD FOREIGN KEY. It defaults to 16 megabytes (16MB). Since only one of these operations can be executed at a time by a database session, and an installation normally doesn't have many of them running concurrently, it's safe to set this value significantly larger than work_mem. Larger settings might improve performance for vacuuming and for restoring database dumps.
* `node['postgresql']['work_mem']` - Specifies the amount of memory to be used by internal sort operations and hash tables before writing to temporary disk files. The value defaults to one megabyte (1MB). Note that for a complex query, several sort or hash operations might be running in parallel; each operation will be allowed to use as much memory as this value specifies before it starts to write data into temporary files. Also, several running sessions could be doing such operations concurrently. Therefore, the total memory used could be many times the value of work_mem; it is necessary to keep this fact in mind when choosing the value. Sort operations are used for ORDER BY, DISTINCT, and merge joins. Hash tables are used in hash joins, hash-based aggregation, and hash-based processing of IN subqueries.
* `node['postgresql']['overcommit']` - If you need to oom-proof your postgresql server so it never runs out of memory, set this to 2.


Default Attributes
==========

* `default[:postgresql][:default_statistics_target]` - 100
* `default[:postgresql][:logging_collector]` - on
* `default[:postgresql][:log_rotation_age]` - 1d
* `default[:postgresql][:log_rotation_size]` - 100MB
* `default[:postgresql][:temp_buffers]` - 8MB
* `default[:postgresql][:checkpoint_timeout]` - 5min
* `default[:postgresql][:checkpoint_completion_target]` - 0.5
* `default[:postgresql][:checkpoint_warning]` - 30s
* `default[:postgresql][:checkpoint_segments]` - 100
* `default[:postgresql][:wal_buffers]` - 8MB
* `default[:postgresql][:wal_writer_delay]` - 200ms
* `default[:postgresql][:max_stack_depth]` - 7MB
* `default[:postgresql][:encoding]` - UTF8
* `default[:postgresql][:locale]` - en_US.UTF-8"
* `default[:postgresql][:max_connections]` - 65535"
* `default[:postgresql][:swappiness]` - 15
* `default[:postgresql][:kernel_sem]` - 4096 6553555 1600 65535
* `default[:postgresql][:data_path]` - /var/lib/postgresql
* `default[:postgresql][:data_directory]` - #{node[:postgresql][:data_path]}/#{node[:postgresql][:version]}/data
* `default[:postgresql][:wal_directory]` - #{node[:postgresql][:data_path]}/#{node[:postgresql][:version]}/pg_xlog
* `default[:postgresql][:hba_file]` - #{node[:postgresql][:data_path]}/#{node[:postgresql][:version]}/pg_hba.conf
* `default[:postgresql][:ident_file]` - #{node[:postgresql][:data_path]}/pg_ident.conf
* `default[:postgresql][:temp_tablespaces]` - /var/tmp/postgresql


Optimal Usage
=====

* `node['postgresql']['data_directory']` - Specify a unique volume or raided volume to store the data set.
* `node['postgresql']['wal_directory']` - Specify a unique volume to store the wal archives.
* `node['postgresql']['temp_tablespaces']` - Specify another unique volume for temporary tables.
* `node['postgresql']['swappiness']` - Specify a swappiness lower then 15.


Usage
=====

On systems that need to connect to a PostgreSQL database, add to a run
list `recipe[postgresql::client]`.

This does not install the `pg` RubyGem, which has native C extensions.  The PPA provided appears to not provide a fully working -dev package that works for Ruby.  Python PostgreSQL drivers appear to build and function appropriately.  If this is a problem for you run 8.4 on the clients.

On systems that should be PostgreSQL servers, use
`recipe[postgresql::server]` on a run list. This recipe does set a
password and expect to use it. It performs a node.save when Chef is
not running in `solo` mode. If you're using `chef-solo`, you'll need
to set the attribute `node['postgresql']['password']` in
your node's `json_attribs` file or in a role.

Replica Usage
=======

Due to trying to keep this cookbook as generic as possible the Hot Streaming is enabled but you will need to manually set up the replica.  You should review the [Streaming Guide][4] for the most up to date information.

* Requirements:
  * Master PostgreSQL server already running
  * Port 5432 open between the master and the slave
  * Same major version of postgresql between master and slave.

* On the master run the following

    psql -c "SELECT pg_start_backup('label', true)"

* Now start copying the data to your replica

    rsync -a /var/lib/postgresql/ standby:/var/lib/postgresql/ --exclude postmaster.pid

* Once it's completed stop the backup

    psql -c "SELECT pg_stop_backup()"

* Create a recovery.conf in /etc/postgresql/9.1/main/ with the following filled out correctly for your setup.

    standby_mode          = 'on'

    primary_conninfo      = 'host=192.168.0.10 port=5432 user=postgres password=whatever'

    trigger_file = '/path_to/trigger'

* Start postgresql on the replica now and verify that replication came up.

Recipes
=======

default
-------
Includes the client recipe.

client
------

Installs postgresql client packages and development headers during the
compile phase. Also installs the `pg` Ruby gem during the compile
phase so it can be made available for the `database` cookbook's
resources, providers and libraries.

server
------
Includes the `server_debian` or `server_redhat` recipe to get the
appropriate server packages installed and service managed. Also
manages the configuration for the server:

* generates a strong default password (via `openssl`) for `postgres`
* sets the password for postgres
* manages the `pg_hba.conf` file.

server\_debian
--------------

Installs the postgresql server packages, manages the postgresql
service and the postgresql.conf file.

Resources/Providers
===================

See the [database](http://community.opscode.com/cookbooks/database)
for resources and providers that can be used for managing PostgreSQL
users and databases.

License and Author
==================

Author:: Scott M. Likens (<scott@likens.us>)

Author:: Joshua Timberman (<joshua@opscode.com>)

Author:: Lamont Granquist (<lamont@opscode.com>)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

[1]: http://www.postgresql.org/about/quotesarchive
[2]: http://www.postgresql.org/about/awards
[3]: http://www.postgresql.org/docs/9.1/static/planner-stats.html
[4]: http://wiki.postgresql.org/wiki/Streaming_Replication
