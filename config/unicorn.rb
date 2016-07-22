worker_processes 2 # this should be >= nr_cpus
pid "/usr/local/freeswitch/webapp/log/unicorn.pid"
stderr_path "/usr/local/freeswitch/webapp/log/unicorn.log"
stdout_path "/usr/local/freeswitch/webapp/log/unicorn.log"
