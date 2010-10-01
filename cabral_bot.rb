require 'rubygems'
require 'percy'

@online = false

conf = YAML.load('config/irc.yml')

configure do |c|
  c.nick     = "cabral_robot"
  c.username = 'Robô assistente do Cabral'
  c.server   = "irc.freenode.net"
  c.password = "maileebotsofta"
  c.port     = 6667
end

def softas
  users_on('#maileeme') & NICKS
end

on :connect do
  join "#maileeme"
end

NICKS = %w{cabral leotartari joaomilho diobob danielw pedroaxl}
on [:join,:quit,:nickchange] do |env|
  @online = ! softas.empty?
  message env[:channel], "Verificando... tem alguém da Softa online? #{@online ? 'Sim' : 'Não'}"
  File.open('online.txt','w'){|f| f.write @online.to_s }
end

#on :channel do |env|
#  msg "O Cabral não está. Por favor, mande um e-mail para ele em suporte@mailee.me"
#end
on [:channel] do |env|  
  unless @online
    message env[:channel], "Ninguém da Softa está online neste momento. Por favor, encaminhe suas dúvidas para o Cabral no email."
  end
end

on [:query] do |env|  
  if @online
    message env[:nick], "Eu sou só um robô. Por favor, fale com o #{softas.first}."
    message softas.first, "Hey! #{env[:nick]} precisa de suporte!"
  else
    message env[:nick], "Ninguém da Softa está online neste momento. Por favor, encaminhe suas dúvidas para o Cabral no email."
  end
end

connect