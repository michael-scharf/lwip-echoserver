#include <stdio.h>
#include <stdlib.h>

#include "lwip/init.h"
#include "lwip/timeouts.h"

#include "examples/example_app/default_netif.h"

#include "tcpecho_raw_example.h"

#define PORT_NUMBER 60000

int main(int argc, char *argv[])
{
  ip4_addr_t ipaddr, netmask, gw;

  IP4_ADDR(&ipaddr, 192, 0, 2, 1);
  IP4_ADDR(&netmask, 255, 255, 255, 0);
  IP4_ADDR(&gw, 192, 0, 2, 254);

  printf("Inititalizing lwip...\n");

  lwip_init();

  printf("Inititalizing default netif...\n");

  init_default_netif(&ipaddr, &netmask, &gw);

  printf("Inititalizing TCP echo server...\n");

  tcpecho_raw_init(PORT_NUMBER);

  printf("Running main loop...\n");

  while (1) {
    sys_check_timeouts();

    default_netif_poll();
  }

  return 0;
}
