require 'rubygems'
require 'yaml'
require 'percy'

def conf; @conf ||= YAML.load_file('config/irc.yml') end
def channel; '#'+conf['channel'] end

def users; users_on(channel) end
def softas; users & conf['support']  end
def support; softas.first  end
def online; ! softas.empty? end
def write_file; File.open('online.txt','w'){|f| f.write online.to_s } end
def in_channel?(nick) users.include?(nick) end
def msg(m=:away,to=nil,*p) message (to or channel), conf['messages'][m.to_s]%p end

def support?(nick) conf['support'].include?(nick) end

configure{|c| conf.each{|k,v| c.send("#{k}=", v) } }

on(:connect){ join channel }
on([:quit,:nickchange]){ write_file }
on(:channel){ msg unless online }

on :join do |e|
  write_file
  return if support? e[:nick]
  online ? msg(:join, support, e[:nick]) : msg
end

on :query do |e|
  return msg(:pjoin, e[:nick]) unless in_channel?(e[:nick])
  online ? msg(:frwd, e[:nick], support) || msg(:help, support, e[:nick]) : msg(:away, e[:nick])
end

connect
