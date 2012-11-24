APPS_DIR = File.dirname(__FILE__)


def generic_monitoring(w, options = {})
  w.start_if do |start|
    start.condition(:process_running) do |c|
      c.interval = 10.seconds
      c.running = false
    end
  end
  
  w.restart_if do |restart|
    restart.condition(:memory_usage) do |c|
      c.above = options[:memory_limit]
      c.times = [3, 5] # 3 out of 5 intervals
    end
  
    restart.condition(:cpu_usage) do |c|
      c.above = options[:cpu_limit]
      c.times = 5
    end
  end
  
  w.lifecycle do |on|
    on.condition(:flapping) do |c|
      c.to_state = [:start, :restart]
      c.times = 5
      c.within = 5.minute
      c.transition = :unmonitored
      c.retry_in = 10.minutes
      c.retry_times = 5
      c.retry_within = 2.hours
    end
  end
end

God.watch do |w|
  script = "#{APPS_DIR}/work1_ctl.rb"
  w.name = "work1"
  w.group = "daemon"
  w.interval = 60.seconds
  w.start = "cd #{APPS_DIR} && #{script} start"
  w.restart = "cd #{APPS_DIR} &&  #{script} restart"
  w.stop = "cd #{APPS_DIR} &&  #{script} stop"
  w.start_grace = 20.seconds
  w.restart_grace = 20.seconds
  w.pid_file = "#{APPS_DIR}/work1.pid"
  w.behavior(:clean_pid_file)
  generic_monitoring(w, :cpu_limit => 80.percent, :memory_limit => 512.megabytes)
end

God.watch do |w|
  script = "#{APPS_DIR}/work2_ctl.rb"
  w.name = "work2"
  w.group = "daemon"
  w.interval = 60.seconds
  w.start = "cd #{APPS_DIR} && #{script} start"
  w.restart = "cd #{APPS_DIR} &&  #{script} restart"
  w.stop = "cd #{APPS_DIR} &&  #{script} stop"
  w.start_grace = 20.seconds
  w.restart_grace = 20.seconds
  w.pid_file = "#{APPS_DIR}/work2.pid"
  w.behavior(:clean_pid_file)
  generic_monitoring(w, :cpu_limit => 80.percent, :memory_limit => 512.megabytes)
end

God.watch do |w|
  script = "#{APPS_DIR}/work3_ctl.rb"
  w.name = "work3"
  w.group = "daemon"
  w.interval = 60.seconds
  w.start = "cd #{APPS_DIR} && #{script} start"
  w.restart = "cd #{APPS_DIR} &&  #{script} restart"
  w.stop = "cd #{APPS_DIR} &&  #{script} stop"
  w.start_grace = 20.seconds
  w.restart_grace = 20.seconds
  w.pid_file = "#{APPS_DIR}/work3.pid"
  w.behavior(:clean_pid_file)
  generic_monitoring(w, :cpu_limit => 80.percent, :memory_limit => 512.megabytes)
end

God.watch do |w|
  script = "#{APPS_DIR}/work4_ctl.rb"
  w.name = "work4"
  w.group = "daemon"
  w.interval = 60.seconds
  w.start = "cd #{APPS_DIR} && #{script} start"
  w.restart = "cd #{APPS_DIR} &&  #{script} restart"
  w.stop = "cd #{APPS_DIR} &&  #{script} stop"
  w.start_grace = 20.seconds
  w.restart_grace = 20.seconds
  w.pid_file = "#{APPS_DIR}/work4.pid"
  w.behavior(:clean_pid_file)
  generic_monitoring(w, :cpu_limit => 80.percent, :memory_limit => 512.megabytes)
end

God.watch do |w|
  script = "#{APPS_DIR}/work5_ctl.rb"
  w.name = "work5"
  w.group = "daemon"
  w.interval = 60.seconds
  w.start = "cd #{APPS_DIR} && #{script} start"
  w.restart = "cd #{APPS_DIR} &&  #{script} restart"
  w.stop = "cd #{APPS_DIR} &&  #{script} stop"
  w.start_grace = 20.seconds
  w.restart_grace = 20.seconds
  w.pid_file = "#{APPS_DIR}/work5.pid"
  w.behavior(:clean_pid_file)
  generic_monitoring(w, :cpu_limit => 80.percent, :memory_limit => 512.megabytes)
end

God.watch do |w|
  script = "#{APPS_DIR}/work6_ctl.rb"
  w.name = "work6"
  w.group = "daemon"
  w.interval = 60.seconds
  w.start = "cd #{APPS_DIR} && #{script} start"
  w.restart = "cd #{APPS_DIR} &&  #{script} restart"
  w.stop = "cd #{APPS_DIR} &&  #{script} stop"
  w.start_grace = 20.seconds
  w.restart_grace = 20.seconds
  w.pid_file = "#{APPS_DIR}/work6.pid"
  w.behavior(:clean_pid_file)
  generic_monitoring(w, :cpu_limit => 80.percent, :memory_limit => 512.megabytes)
end

God.watch do |w|
  script = "#{APPS_DIR}/work7_ctl.rb"
  w.name = "work7"
  w.group = "daemon"
  w.interval = 60.seconds
  w.start = "cd #{APPS_DIR} && #{script} start"
  w.restart = "cd #{APPS_DIR} &&  #{script} restart"
  w.stop = "cd #{APPS_DIR} &&  #{script} stop"
  w.start_grace = 20.seconds
  w.restart_grace = 20.seconds
  w.pid_file = "#{APPS_DIR}/work7.pid"
  w.behavior(:clean_pid_file)
  generic_monitoring(w, :cpu_limit => 80.percent, :memory_limit => 512.megabytes)
end

God.watch do |w|
  script = "#{APPS_DIR}/work8_ctl.rb"
  w.name = "work8"
  w.group = "daemon"
  w.interval = 60.seconds
  w.start = "cd #{APPS_DIR} && #{script} start"
  w.restart = "cd #{APPS_DIR} &&  #{script} restart"
  w.stop = "cd #{APPS_DIR} &&  #{script} stop"
  w.start_grace = 20.seconds
  w.restart_grace = 20.seconds
  w.pid_file = "#{APPS_DIR}/work8.pid"
  w.behavior(:clean_pid_file)
  generic_monitoring(w, :cpu_limit => 80.percent, :memory_limit => 512.megabytes)
end

God.watch do |w|
  script = "#{APPS_DIR}/clicks_email_ctl.rb"
  w.name = "clicks email"
  w.group = "daemon"
  w.interval = 60.seconds
  w.start = "cd #{APPS_DIR} && #{script} start"
  w.restart = "cd #{APPS_DIR} &&  #{script} restart"
  w.stop = "cd #{APPS_DIR} &&  #{script} stop"
  w.start_grace = 20.seconds
  w.restart_grace = 20.seconds
  w.pid_file = "#{APPS_DIR}/clicks_email.pid"
  w.behavior(:clean_pid_file)
  generic_monitoring(w, :cpu_limit => 80.percent, :memory_limit => 512.megabytes)
end

God.watch do |w|
  script = "#{APPS_DIR}/restart_daemon.rb"
  w.name = "restart_daemon"
  w.group = "daemon"
  w.interval = 60.seconds
  w.start = "cd #{APPS_DIR} && #{script} start"
  w.restart = "cd #{APPS_DIR} &&  #{script} restart"
  w.stop = "cd #{APPS_DIR} &&  #{script} stop"
  w.start_grace = 20.seconds
  w.restart_grace = 20.seconds
  w.pid_file = "#{APPS_DIR}/restart_daemon.pid"
  w.behavior(:clean_pid_file)
  generic_monitoring(w, :cpu_limit => 80.percent, :memory_limit => 512.megabytes)
end