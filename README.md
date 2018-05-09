# SEsysagua

## Trabalho do curso de Pós-Graduação em Inovação, Desenvolvimento Web e Mobile - Disciplina Sistemas Embarcados

O trabalho consiste em utilizar 01 placa Microcontroladora STM32 ARMBed modelo F303RE e sensores: 01(um) HC-SR04(sonar) e 01(um) YF-S201(Medidor de Fluxo de Água),
para monitorar o fluxo de uso de água de caixas dágua de uso residencial, e medir o fluxo de entrada do fornecimento de água pela empresa COMPESA, permitindo o usuário fazer consultas
que reportem como está o seu consumo e criação de Front-End web para usuário.

Optou-se como protocolo de comunicação, MQTT, o mesmo usa uma arquitetura de comunicação baseada em publicadores (***PUBLISH***) - agentes que irão ler informações e fazer comunicação com o servidor 
que pode estar alojado na internet ou localmente, chamados ***BROKER's*** (lê-se brôkers), e ***SUBSCRIBER*** que irão se inscrever no broker e receber as informações vindas dos publisher
1. Atuando como PUBLISH, usamos a placa e sensores.
2. Para o Broker, usamos um servidor **Broker** local, **EMQ Erlang**, você pode aprender mais em: <http://emqtt.io/>, usamos a versão 2.3.7._Obs: você pode usar também o mosquitto ou o hivemq_.
3. Para front-end:
+ PHP: v.5.6.4
+ Banco de dados: Mysql
+ Servidor web: apache.
+ Gráficos: Javascript

Você pode conferir na arquitetura abaixo o esquema montado, considere que de forma geral o subscribe, é tudo após o broker.
!(https://drive.google.com/open?id=1-c7LKJWCRaklu-z5Bh4YW_HBgk1_qqBB)

Videos e outros arquivos pode ser conferido aqui:
https://drive.google.com/open?id=101LDy5_mWZq7URaEvZny26zWwZ76nvRU

Confira aqui o front-end:
https://github.com/Muciojaziel/sysagua

Parceiros de projeto podem ser contactados por:
@muciojaziel - https://github.com/Muciojaziel/
@gcsgivanildo - https://github.com/gcsgivanildo
@edjaniorodrigues - https://github.com/edjaniorodrigues





