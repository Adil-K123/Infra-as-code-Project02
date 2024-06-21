[EC2_WebServers]
%{ for ip in webServers ~}
${ip}
%{ endfor ~}
