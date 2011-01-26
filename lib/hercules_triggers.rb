module Hercules
  class Triggers
    def self.before_deploy(options)
      env = (options[:branch] == "master" ? "development" : options[:branch])
      cmd = options[:shell]
      cmd.run "cp /home/mailee/configs/site-rails3/irc.yml config/"
      cmd.run "cp /home/mailee/configs/site-rails3/pivotal_tracker.yml config/"
      true
    end 

    def self.after_deploy(options)
      cmd = options[:shell]
      cmd.run "kill -HUP \`cat /home/mailee/pids/#{options[:branch]}/site-unicorn.pid\`"
    end 
  end 
end

