// In this example we create an MQTT client.
// It's publishing messages with topic 'example/hello' and 'Hello World!' payload.
// The MQTT client also subscribes to some topics which are in its interest to receive.
// Ethernet connection is assured by an affordable ENC28J60 Ethernet module.
#include "mbed.h"
#include "UIPEthernet.h"
#include "MQTTClient.h"
#include "HCSR04.h"

Serial  pc(USBTX, USBRX);
HCSR04 sonar(D5, D6);
//Thread thread;

//#define DHCP    1 ;   // if you'd like to use static IP address comment out this line 

#if defined(TARGET_LPC1768)
UIPEthernet  uIPEthernet(p11, p12, p13, p8);         // mosi, miso, sck, cs
#elif defined(TARGET_NUCLEO_F103RB) || defined(TARGET_NUCLEO_L152RE) || defined(TARGET_NUCLEO_F030R8)  \
   || defined(TARGET_NUCLEO_F401RE) || defined(TARGET_NUCLEO_F302R8) || defined(TARGET_NUCLEO_L053R8)  \
   || defined(TARGET_NUCLEO_F411RE) || defined(TARGET_NUCLEO_F334R8) || defined(TARGET_NUCLEO_F072RB)  \
   || defined(TARGET_NUCLEO_F091RC) || defined(TARGET_NUCLEO_F303RE) || defined(TARGET_NUCLEO_F070RB)  \
   || defined(TARGET_KL25Z ) || defined(TARGET_KL46Z) || defined(TARGET_K64F) || defined(TARGET_KL05Z) \
   || defined(TARGET_K20D50M) || defined(TARGET_K22F) \
   || defined(TARGET_NRF51822) \
   || defined(TARGET_RZ_A1H)
UIPEthernet  uIPEthernet(D11, D12, D13, D10);        // mosi, miso, sck, cs
#endif

// MAC address must be unique within the connected network. Modify as appropriate.
const uint8_t       MY_MAC[6] = { 0x00, 0x01, 0x02, 0x03, 0x04, 0xBB };

// MQTT broker is like a post office.
// Its task is to distribute messages published by clients to all subscribers (other clients).
// So the 'example/hello' messages published by this client will be sent to the broker.
// Then the broker will send them to all clients which subscribed to such topic (example/hello).
// Also this client will receive all messages with topics it subscribed to (if published such by other clients).
// 'Mosquitto' is a free implementation of MQTT broker for Linux (e.g. Raspberry Pi, Ubuntu etc.)
IPAddress           serverIP(192, 168, 1, 100);  // IP address of your MQTT broker (change to match)
EthernetClient      ethernetClient;
void                onMqttMessage(char* topic, uint8_t* payload, unsigned int length);
MQTTClient          mqttClient(serverIP, 1883, onMqttMessage, ethernetClient);
char                message_buff[10];  // buffer to store received messages //tava 100

/**
 * @brief
 * @note
 * @param
 * @retval
 */

float calcularMedia();

int main(void) {
    float               resultado;
    const int           MAX_TRIES = 5; 
    //const unsigned long INTERVAL = 5; 
    int                 i = 0;
    bool                connected = false;
    char*               payload; // = "Hello World";
   // unsigned long       t = 0;//0
   // unsigned long       lastTime = t;
    float               valorSonar;
    char                valorSonarParse[8];
    /*float               arraySonar[15];
    //float               soma = 0;*/
    //float               media;
    
    /*while(1) {
        valorSonar = sonar.getCm();
        printf("Distancia detectada pelo sensor Frente %.2f cm \r\n", valorSonar); 
        wait_ms(5000);
    }*/
        
#if defined(DHCP)
    pc.printf("Searching for DHCP server..\r\n");
    if(uIPEthernet.begin(MY_MAC) != 1) {
        pc.printf("No DHCP server found.\r\n");
        pc.printf("Exiting application.\r\n");
        return 0;
    }
    pc.printf("DHCP server found.\r\n");
#else
    // IP address must be unique and compatible with your network.
    const IPAddress MY_IP(192, 168, 1, 181);    //  Change as appropriate.
    uIPEthernet.begin(MY_MAC, MY_IP);
#endif
    pc.printf("Local IP = %s\r\n", uIPEthernet.localIP().toString());
    pc.printf("Connecting to MQTT broker ..\r\n");
    do {
        wait(1.0);
        connected = mqttClient.connect("myMQTTHelloClient2");
    } while(!connected && (i++ < MAX_TRIES));
    
    
    
  while(1) {
       //t = time(NULL);
       //if(t > (lastTime + INTERVAL)) {
        //lastTime = t;
        
        //pc.printf("resultado %.2f", resultado);
            if(connected) {
            //
            resultado = calcularMedia();
            valorSonar = resultado;
            //printf ( "\nMedia total: %.2f\n", media);
            //
            sprintf(valorSonarParse,"%.2f", valorSonar);
            //pc.printf("O valor float convertido p char e:%s\r\n", valorSonarParse);
            //
             payload = valorSonarParse;
            //printf("nada");
            //
            if(mqttClient.publish("/ifpe/sysagua", payload)){
                mqttClient.publish("/ifpe/sysagua", payload);
                pc.printf("publicado!\r\n");
            }else{
                 pc.printf("nao publicado\r\n");
            }

            }else{
                 pc.printf("Nao conseguiu fazer o PUBLISH!.\r\n");
            }
             mqttClient.loop();  // MQTT client loop processing (receiving messages
       }         
 }
 
 float          media;
 float calcularMedia(){
         int i;
         float arrayNumbers[15], soma = 0;
         
         pc.printf("Calculando a media do array.\r\n");
         
         for(i=0; i < 15; i++){
           arrayNumbers[i] = sonar.getCm();
           printf("Arraynumbers [i]: %.1f\r\n", arrayNumbers[i]);
           soma += arrayNumbers[i];
           wait(1);
         }
        media = soma/15;
        printf("A media e: %.1f\r\n", media);
        return media;
}

/**
 * @brief   Called on new MQTT message arrival
 * @note
 * @param   topic:      The topic of the new message
 *          payload:    The payload of the new message
 *          length:     Payload's length
 * @retval
 */
void onMqttMessage(char* topic, uint8_t* payload, unsigned int length) {
    int i = 0;

    pc.printf("Message arrived:\r\n");
    pc.printf("    Topic: %s\r\n", topic);
    pc.printf("    Length: %d\r\n", length);

    // create character buffer with ending null terminator (string)
    for(i = 0; i < length; i++) {
        message_buff[i] = payload[i];
    }

    message_buff[i] = '\0';
    pc.printf("    Payload: %s\r\n", message_buff);
}