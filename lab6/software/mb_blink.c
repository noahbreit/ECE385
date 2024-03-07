//mb_blink.c
//
//Provided boilerplate "LED Blink" code for ECE 385
//First released in ECE 385, Fall 2023 distribution
//
//Note: you will have to refer to the memory map of your MicroBlaze
//system to find the proper address for the LED GPIO peripheral.
//
//Modified on 7/25/23 Zuofu Cheng

#include <stdio.h>
#include <xparameters.h>
#include <xil_types.h>
#include <sleep.h>

#include "platform.h"

#define ACCUMULATE_FLAG 0x1

volatile uint32_t* led_gpio_out = XPAR_AXI_GPIO_0_BASEADDR;
volatile uint32_t* led_gpio_sw_in = XPAR_AXI_GPIO_1_BASEADDR;
volatile uint32_t* led_gpio_btn_in = XPAR_AXI_GPIO_2_BASEADDR;

//volatile uint32_t* led_gpio_data = <find the base address>;  //Hint: either find the manual address (via the memory map in the block diagram, or
															 //replace with the proper define in xparameters (part of the BSP). Either way
															 //this is the base address of the GPIO corresponding to your LEDs
															 //(similar to 0xFFFF from MEM2IO from previous labs).

int main()
{
	uint16_t sum = 0;
	uint16_t prev_sum = 0;
	uint16_t * sw_in = 0;
	uint8_t * btn_in = 0;

    init_platform();

	while (1+1 != 3)
	{
		sleep(1);

		// GPIO READ
		memcpy(sw_in, led_gpio_sw_in, sizeof(*sw_in));
		memcpy(btn_in, led_gpio_btn_in, sizeof(*btn_in));

		// UPDATE SUM
		prev_sum = sum;
		if ( (*btn_in) & ACCUMULATE_FLAG )
		{
			sum += (uint16_t)(*sw_in);
		}

		// GPIO WRITE
		*led_gpio_out &=  0x0;			// clear prev LEDs
		*led_gpio_out |=  sum;			// set LEDs to current sum

		// SERIAL OUTPUT
		if (sum != prev_sum)
		{
			printf("Led Update!\r\n");
		}
		else
		{
			printf("No Led Change!\r\n");
		}

		// CHECK OVERFLOW
		if (sum < prev_sum)
		{
			printf("Overflow!\r\n");
		}
	}

    cleanup_platform();

    return 0;
}
