application = "t-media"

worker_processes = 2
working_directory "/home/rails/#{application}"

listen "/var/run/unicorn/unicorn_#{application}.sock"
pid "/home/rails/#{application}/tmp/pids/unicorn.pid"

stderr_path "/home/rails/#{application}/log/unicorn.stderr.log"
stdout_path "/home/rails/#{application}/log/unicorn.stdout.log"

preload_app true