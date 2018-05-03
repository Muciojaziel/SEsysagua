/*
 MQTTClient.cpp - A simple client for MQTT.
  Nicholas O'Leary
  http://knolleary.net

  Ported to mbed by Zoltan Hudak <hudakz@inbox.com>
*/
#include "MQTTClient.h"
#include <string.h>
#include <time.h>

/**
 * @brief
 * @note
 * @param
 * @retval
 */
MQTTClient::MQTTClient(void) {
    this->_client = NULL;
    this->stream = NULL;
}

/**
 * @brief
 * @note
 * @param
 * @retval
 */
MQTTClient::MQTTClient
(
    IPAddress&  ip,
    uint16_t    port,
    void (*onMessage) (char*, uint8_t*, unsigned int),
    Client& client
) {
    this->_client = &client;
    this->onMessage = onMessage;
    this->ip = ip;
    this->port = port;
    this->domain = NULL;
    this->stream = NULL;
}

/**
 * @brief
 * @note
 * @param
 * @retval
 */
MQTTClient::MQTTClient(char* domain, uint16_t port, void (*onMessage) (char*, uint8_t*, unsigned int), Client& client) {
    this->_client = &client;
    this->onMessage = onMessage;
    this->domain = domain;
    this->port = port;
    this->stream = NULL;
}

/**
 * @brief
 * @note
 * @param
 * @retval
 */
MQTTClient::MQTTClient
(
    IPAddress&  ip,
    uint16_t    port,
    void (*onMessage) (char*, uint8_t*, unsigned int),
    Client& client,
    Stream& stream
) {
    this->_client = &client;
    this->onMessage = onMessage;
    this->ip = ip;
    this->port = port;
    this->domain = NULL;
    this->stream = &stream;
}

/**
 * @brief
 * @note
 * @param
 * @retval
 */
MQTTClient::MQTTClient
(
    char*       domain,
    uint16_t    port,
    void (*onMessage) (char*, uint8_t*, unsigned int),
    Client& client,
    Stream& stream
) {
    this->_client = &client;
    this->onMessage = onMessage;
    this->domain = domain;
    this->port = port;
    this->stream = &stream;
}

/**
 * @brief
 * @note
 * @param
 * @retval
 */
bool MQTTClient::connect(char* id) {
    return connect(id, NULL, NULL, 0, 0, 0, 0);
}

/**
 * @brief
 * @note
 * @param
 * @retval
 */
bool MQTTClient::connect(char* id, char* user, char* pass) {
    return connect(id, user, pass, 0, 0, 0, 0);
}

/**
 * @brief
 * @note
 * @param
 * @retval
 */
bool MQTTClient::connect(char* id, char* willTopic, uint8_t willQos, uint8_t willRetain, char* willMessage) {
    return connect(id, NULL, NULL, willTopic, willQos, willRetain, willMessage);
}

/**
 * @brief
 * @note
 * @param
 * @retval
 */
bool MQTTClient::connect
(
    char*   id,
    char*   user,
    char*   pass,
    char*   willTopic,
    uint8_t willQos,
    uint8_t willRetain,
    char*   willMessage
) {
    if(!connected()) {
        int result = 0;

        if(domain != NULL) {
            result = _client->connect(this->domain, this->port);
        }
        else {
            result = _client->connect(this->ip, this->port);
        }

        if(result) {
            nextMsgId = 1;

            uint8_t         d[9] = { 0x00, 0x06, 'M', 'Q', 'I', 's', 'd', 'p', MQTTPROTOCOLVERSION };

            // Leave room in the buffer for header and variable length field
            uint16_t        length = 5;
            unsigned int    j;
            for(j = 0; j < 9; j++) {
                buffer[length++] = d[j];
            }

            uint8_t v;
            if(willTopic) {
                v = 0x06 | (willQos << 3) | (willRetain << 5);
            }
            else {
                v = 0x02;
            }

            if(user != NULL) {
                v = v | 0x80;

                if(pass != NULL) {
                    v = v | (0x80 >> 1);
                }
            }

            buffer[length++] = v;

            buffer[length++] = ((MQTT_KEEPALIVE) >> 8);
            buffer[length++] = ((MQTT_KEEPALIVE) & 0xFF);
            length = writeString(id, buffer, length);
            if(willTopic) {
                length = writeString(willTopic, buffer, length);
                length = writeString(willMessage, buffer, length);
            }

            if(user != NULL) {
                length = writeString(user, buffer, length);
                if(pass != NULL) {
                    length = writeString(pass, buffer, length);
                }
            }

            write(MQTTCONNECT, buffer, length - 5);

            lastInActivity = lastOutActivity = time(NULL);

            while(!_client->available()) {
                unsigned long   t = time(NULL);
                if(t - lastInActivity > MQTT_KEEPALIVE) {
                    _client->stop();
                    return false;
                }
            }

            uint8_t     llen;
            uint16_t    len = readPacket(&llen);

            if(len == 4 && buffer[3] == 0) {
                lastInActivity = time(NULL);
                pingOutstanding = false;
                return true;
            }
        }

        _client->stop();
    }

    return false;
}

/**
 * @brief
 * @note
 * @param
 * @retval
 */
uint8_t MQTTClient::readByte(void) {
    while(!_client->available()) { }

    return _client->read();
}

/**
 * @brief
 * @note
 * @param
 * @retval
 */
uint16_t MQTTClient::readPacket(uint8_t* lengthLength) {
    uint16_t    len = 0;
    buffer[len++] = readByte();

    bool        isPublish = (buffer[0] & 0xF0) == MQTTPUBLISH;
    uint32_t    multiplier = 1;
    uint16_t    length = 0;
    uint8_t     digit = 0;
    uint16_t    skip = 0;
    uint8_t     start = 0;

    do
    {
        digit = readByte();
        buffer[len++] = digit;
        length += (digit & 127) * multiplier;
        multiplier *= 128;
    } while((digit & 128) != 0);
    *lengthLength = len - 1;

    if(isPublish) {

        // Read in topic length to calculate bytes to skip over for Stream writing
        buffer[len++] = readByte();
        buffer[len++] = readByte();
        skip = (buffer[*lengthLength + 1] << 8) + buffer[*lengthLength + 2];
        start = 2;
        if(buffer[0] & MQTTQOS1) {

            // skip message id
            skip += 2;
        }
    }

    for(uint16_t i = start; i < length; i++) {
        digit = readByte();
        if(this->stream) {
            if(isPublish && len -*lengthLength - 2 > skip) {
                this->stream->putc(digit);
            }
        }

        if(len < MQTT_MAX_PACKET_SIZE) {
            buffer[len] = digit;
        }

        len++;
    }

    if(!this->stream && len > MQTT_MAX_PACKET_SIZE) {
        len = 0;    // This will cause the packet to be ignored.
    }

    return len;
}

/**
 * @brief
 * @note
 * @param
 * @retval
 */
bool MQTTClient::loop(void) {
    if(connected()) {
        unsigned long   t = time(NULL);
        if((t - lastInActivity > MQTT_KEEPALIVE) || (t - lastOutActivity > MQTT_KEEPALIVE)) {
            if(pingOutstanding) {
                _client->stop();
                return false;
            }
            else {
                buffer[0] = MQTTPINGREQ;
                buffer[1] = 0;
                _client->write(buffer, 2);
                lastOutActivity = t;
                lastInActivity = t;
                pingOutstanding = true;
            }
        }

        if(_client->available()) {
            uint8_t     llen;
            uint16_t    len = readPacket(&llen);
            uint16_t    msgId = 0;
            uint8_t*    payload;
            if(len > 0) {
                lastInActivity = t;

                uint8_t type = buffer[0] & 0xF0;
                if(type == MQTTPUBLISH) {
                    if(onMessage) {
                        uint16_t    tl = (buffer[llen + 1] << 8) + buffer[llen + 2];
                        char        topic[tl + 1];
                        for(uint16_t i = 0; i < tl; i++) {
                            topic[i] = buffer[llen + 3 + i];
                        }

                        topic[tl] = 0;

                        // msgId only present for QOS>0
                        if((buffer[0] & 0x06) == MQTTQOS1) {
                            msgId = (buffer[llen + 3 + tl] << 8) + buffer[llen + 3 + tl + 1];
                            payload = buffer + llen + 3 + tl + 2;
                            onMessage(topic, payload, len - llen - 3 - tl - 2);

                            buffer[0] = MQTTPUBACK;
                            buffer[1] = 2;
                            buffer[2] = (msgId >> 8);
                            buffer[3] = (msgId & 0xFF);
                            _client->write(buffer, 4);
                            lastOutActivity = t;
                        }
                        else {
                            payload = buffer + llen + 3 + tl;
                            onMessage(topic, payload, len - llen - 3 - tl);
                        }
                    }
                }
                else
                if(type == MQTTPINGREQ) {
                    buffer[0] = MQTTPINGRESP;
                    buffer[1] = 0;
                    _client->write(buffer, 2);
                }
                else
                if(type == MQTTPINGRESP) {
                    pingOutstanding = false;
                }
            }
        }

        return true;
    }

    return false;
}

/**
 * @brief
 * @note
 * @param
 * @retval
 */
bool MQTTClient::publish(char* topic, char* payload) {
    return publish(topic, (uint8_t*)payload, strlen(payload), false);
}

/**
 * @brief
 * @note
 * @param
 * @retval
 */
bool MQTTClient::publish(char* topic, uint8_t* payload, unsigned int plength) {
    return publish(topic, payload, plength, false);
}

/**
 * @brief
 * @note
 * @param
 * @retval
 */
bool MQTTClient::publish(char* topic, uint8_t* payload, unsigned int plength, bool retained) {
    if(connected()) {

        // Leave room in the buffer for header and variable length field
        uint16_t    length = 5;
        length = writeString(topic, buffer, length);

        uint16_t    i;
        for(i = 0; i < plength; i++) {
            buffer[length++] = payload[i];
        }

        uint8_t header = MQTTPUBLISH;
        if(retained) {
            header |= 1;
        }

        return write(header, buffer, length - 5);
    }

    return false;
}

/**
 * @brief
 * @note
 * @param
 * @retval
 */
bool MQTTClient::write(uint8_t header, uint8_t* buf, uint16_t length) {
    uint8_t lenBuf[4];
    uint8_t llen = 0;
    uint8_t digit;
    uint8_t pos = 0;
    uint8_t rc;
    uint8_t len = length;
    do
    {
        digit = len % 128;
        len = len / 128;
        if(len > 0) {
            digit |= 0x80;
        }

        lenBuf[pos++] = digit;
        llen++;
    } while(len > 0);

    buf[4 - llen] = header;
    for(int i = 0; i < llen; i++) {
        buf[5 - llen + i] = lenBuf[i];
    }

    rc = _client->write(buf + (4 - llen), length + 1 + llen);

    lastOutActivity = time(NULL);
    return(rc == 1 + llen + length);
}

/**
 * @brief
 * @note
 * @param
 * @retval
 */
bool MQTTClient::subscribe(char* topic) {
    bool    result = subscribe(topic, 0);
    wait_ms(50); //tava 50
    return result;
}

/**
 * @brief
 * @note
 * @param
 * @retval
 */
bool MQTTClient::subscribe(char* topic, uint8_t qos) {
    if(qos > 1)
        return false;

    if(connected()) {

        // Leave room in the buffer for header and variable length field
        uint16_t    length = 5;
        nextMsgId++;
        if(nextMsgId == 0) {
            nextMsgId = 1;
        }

        buffer[length++] = (nextMsgId >> 8);
        buffer[length++] = (nextMsgId & 0xFF);
        length = writeString(topic, buffer, length);
        buffer[length++] = qos;
        return write(MQTTSUBSCRIBE | MQTTQOS1, buffer, length - 5);
    }

    return false;
}

/**
 * @brief
 * @note
 * @param
 * @retval
 */
bool MQTTClient::unsubscribe(char* topic) {
    if(connected()) {
        uint16_t    length = 5;
        nextMsgId++;
        if(nextMsgId == 0) {
            nextMsgId = 1;
        }

        buffer[length++] = (nextMsgId >> 8);
        buffer[length++] = (nextMsgId & 0xFF);
        length = writeString(topic, buffer, length);
        return write(MQTTUNSUBSCRIBE | MQTTQOS1, buffer, length - 5);
    }

    return false;
}

/**
 * @brief
 * @note
 * @param
 * @retval
 */
void MQTTClient::disconnect(void) {
    buffer[0] = MQTTDISCONNECT;
    buffer[1] = 0;
    _client->write(buffer, 2);
    _client->stop();
    lastInActivity = lastOutActivity = time(NULL);
}

/**
 * @brief
 * @note
 * @param
 * @retval
 */
uint16_t MQTTClient::writeString(char* string, uint8_t* buf, uint16_t pos) {
    char*       idp = string;
    uint16_t    i = 0;
    pos += 2;
    while(*idp) {
        buf[pos++] = *idp++;
        i++;
    }

    buf[pos - i - 2] = (i >> 8);
    buf[pos - i - 1] = (i & 0xFF);
    return pos;
}

/**
 * @brief
 * @note
 * @param
 * @retval
 */
bool MQTTClient::connected(void) {
    bool    rc;
    if(_client == NULL) {
        rc = false;
    }
    else {
        rc = (int)_client->connected();
        if(!rc)
            _client->stop();
    }

    return rc;
}

