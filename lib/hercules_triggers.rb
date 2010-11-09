module Hercules
  class Triggers
    def self.before_deploy(options)
      env = (options[:branch] == "master" ? "development" : options[:branch])
      cmd = options[:shell]
      cmd.run "cp config/pivotal_tracker.sample.yml config/pivotal_tracker.yml"
      true
    end 

    def self.after_deploy(options)
      cmd = options[:shell]
      #cmd.run "kill -HUP \`cat /home/mailee/pids/#{options[:branch]}/site-unicorn.pid\`"
    end 
  end 
end

