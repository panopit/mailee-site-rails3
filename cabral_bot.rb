require 'rubygems'
require 'percy'

online = false

configure do |c|
  c.nick    = "cabral_bot"
  c.server  = "irc.freenode.net"
  c.port    = 6667
end

on :connect do
  join "#maileeme"
end

NICKS = %w{leotartari cabral joaomilho diobob danielw pedroaxl}
on [:join,:quit] do |env|
  online = ! NICKS.select{|nick| is_online(nick) != false }.empty?
  File.open('online.txt','w'){|f| f.write online.to_s }
end

#on :channel do |env|
#  msg "O Cabral não está. Por favor, mande um e-mail para ele em suporte@mailee.me"
#end
on :channel do |env|  
  message env[:channel], "O Cabral não está. Por favor, mande um e-mail para ele em suporte@mailee.me"
end
connect
