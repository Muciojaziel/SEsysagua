/*
  MQTTClient.h - A simple client for MQTT.
  Nicholas O'Leary
  http://knolleary.net

  Ported to mbed by Zoltan Hudak <hudakz@inbox.com>
*/
#ifndef MQTTClient_h
#define MQTTClient_h

#include <mbed.h>
#include "Client.h"
//#include "Stream.h"


#define MQTT_MAX_PACKET_SIZE   256  // MQTT_MAX_PACKET_SIZE : Maximum packet size
#define MQTT_KEEPALIVE          15  // MQTT_KEEPALIVE : keepAlive interval in Seconds 
#define MQTTPROTOCOLVERSION      3
#define MQTTCONNECT         1 << 4  // Client request to connect to Server
#define MQTTCONNACK         2 << 4  // Connect Acknowledgment
#define MQTTPUBLISH         3 << 4  // Publish message
#define MQTTPUBACK          4 << 4  // Publish Acknowledgment
#define MQTTPUBREC          5 << 4  // Publish Received (assured delivery part 1)
#define MQTTPUBREL          6 << 4  // Publish Release (assured delivery part 2)
#define MQTTPUBCOMP         7 << 4  // Publish Complete (assured delivery part 3)
#define MQTTSUBSCRIBE       8 << 4  // Client Subscribe request
#define MQTTSUBACK          9 << 4  // Subscribe Acknowledgment
#define MQTTUNSUBSCRIBE     10 << 4 // Client Unsubscribe request
#define MQTTUNSUBACK        11 << 4 // Unsubscribe Acknowledgment
#define MQTTPINGREQ         12 << 4 // PING Request
#define MQTTPINGRESP        13 << 4 // PING Response
#define MQTTDISCONNECT      14 << 4 // Client is Disconnecting
#define MQTTReserved        15 << 4 // Reserved
#define MQTTQOS0            (0 << 1)
#define MQTTQOS1            (1 << 1)
#define MQTTQOS2            (2 << 1)

class   MQTTClient
{
private:
    Client*         _client;
    uint8_t         buffer[MQTT_MAX_PACKET_SIZE];
    uint16_t        nextMsgId;
    unsigned long   lastOutActivity;
    unsigned long   lastInActivity;
    bool            pingOutstanding;
    void (*onMessage) (char*, uint8_t*, unsigned int);
    uint16_t    readPacket(uint8_t* );
    uint8_t     readByte(void);
    bool        write(uint8_t header, uint8_t* buf, uint16_t length);
    uint16_t    writeString(char* string, uint8_t* buf, uint16_t pos);
    IPAddress   ip;
    char*       domain;
    uint16_t    port;
    Stream*     stream;
public:
    MQTTClient(void);
    MQTTClient(IPAddress& , uint16_t, void (* ) (char*, uint8_t*, unsigned int), Client& client);
    MQTTClient(IPAddress& , uint16_t, void (* ) (char*, uint8_t*, unsigned int), Client& client, Stream& );
    MQTTClient(char* , uint16_t, void (* ) (char*, uint8_t*, unsigned int), Client& client);
    MQTTClient(char* , uint16_t, void (* ) (char*, uint8_t*, unsigned int), Client& client, Stream& );
    bool    connect(char* );
    bool    connect(char* , char* , char* );
    bool    connect(char* , char* , uint8_t, uint8_t, char* );
    bool    connect(char* , char* , char* , char* , uint8_t, uint8_t, char* );
    void    disconnect(void);
    bool    publish(char* , char* );
    bool    publish(char* , uint8_t* , unsigned int);
    bool    publish(char* , uint8_t* , unsigned int, bool);
    bool    subscribe(char* );
    bool    subscribe(char* , uint8_t qos);
    bool    unsubscribe(char* );
    bool    loop(void);
    bool    connected(void);
};
#endif
