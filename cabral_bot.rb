require 'rubygems'
require 'percy'


configure do |c|
  c.nick    = "LTG"
  c.server  = "irc.freenode.net"
  c.port    = 6667
end

on :connect do
  join "#maileeme"
end

NICKS = %w{leotartari cabral joaomilho diobob danielw pedroaxl}
on [:join,:quit] do |env|
  File.open('online.txt','w'){|f| f.write (! NICKS.select{|nick| is_online(nick) != false }.empty?).to_s }
end

connect