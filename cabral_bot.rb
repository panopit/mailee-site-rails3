require 'rubygems'
require 'percy'

AWAY_MESSAGE = "Ninguém da Softa está online neste momento. Por favor, encaminhe suas dúvidas para o Cabral no email *suporte@mailee.me*."
configure{|c| YAML.load_file('config/irc.yml').each{|k,v| c.send("#{k}=", v) } }

def softas; users_on('#maileeme') & %w{cabral leotartari joaomilho diobob danielw pedroaxl} end
def online; ! softas.empty? end

on(:connect){ join "#maileeme" }

on [:join,:quit,:nickchange] do |env|
  message env[:channel], "Verificando... tem alguém da Softa online? #{online ? 'Sim' : 'Não'}"
  File.open('online.txt','w'){|f| f.write online.to_s }
end

on :channel do |env|  
  message env[:channel], AWAY_MESSAGE unless online
end

on :query do |env|
  if users_on('#maileeme').include?(env[:nick])
    if online
      message env[:nick], "Eu sou só um robô. Por favor, fale com o #{softas.first}."
      message softas.first, "Hey! #{env[:nick]} precisa de suporte!"
    else
      message env[:nick], AWAY_MESSAGE
    end
  else
    message env[:nick], "Para ajuda com o Mailee.me entre na sala #maileeme (/join #maileeme)."
  end
end

connect