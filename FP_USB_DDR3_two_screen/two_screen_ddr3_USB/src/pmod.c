#include "bitmap.h"
#include "pmod/PmodOLEDrgb.h"
#include "sleep.h"
#include "xil_cache.h"
#include "xparameters.h"
#include "lw_usb_main.h"
#include <stdio.h>
#include <stdlib.h>
#include "lw_usb/GenericTypeDefs.h"


void DemoInitialize();
void DemoRun();
void DemoCleanup();
void EnableCaches();
void DisableCaches();
void Pong();
void Pong_open();
void Pong_wait();
void Pong_game_main();
void init_game();
void draw_pad();
void draw_ball();
void update_PAD_location();
void update_ball_location();
void left_side_score();
void right_side_score();
void update_score();
int random_fire();
void check_score();
void decide_win_lose();

void Pong_game_main_double();
void draw_pad_double();
void draw_ball_double();

int score1, score2;
int endgame; //
int pad_position1[2], pad_position2[2];
int ball_position[2];
int ball_vector[2];
uint8_t arena_b[12288];


extern BYTE keycode_global[6];

PmodOLEDrgb oledrgb;
PmodOLEDrgb oledrgb_sec;

//test font from vender, not used for project, only testing
u8 rgbUserFont[] = {
   0x00, 0x04, 0x02, 0x1F, 0x02, 0x04, 0x00, 0x00, // 0x00
   0x0E, 0x1F, 0x15, 0x1F, 0x17, 0x10, 0x1F, 0x0E, // 0x01
   0x00, 0x1F, 0x11, 0x00, 0x00, 0x11, 0x1F, 0x00, // 0x02
   0x00, 0x0A, 0x15, 0x11, 0x0A, 0x04, 0x00, 0x00, // 0x03
   0x07, 0x0C, 0xFA, 0x2F, 0x2F, 0xFA, 0x0C, 0x07  // 0x04
}; // This table defines 5 user characters, although only one is used



void DemoInitialize() {
   EnableCaches();
   OLEDrgb_begin(&oledrgb, XPAR_GPIO_PMOD_A_BASEADDR,
		   XPAR_SPI_PMOD_A_BASEADDR);
   OLEDrgb_begin(&oledrgb_sec, XPAR_GPIO_PMOD_B_BASEADDR,
		   XPAR_SPI_PMOD_B_BASEADDR);
}

//Test code from the vendor
void DemoRun() {
   char ch;

   // Define the user definable characters
   for (ch = 0; ch < 5; ch++) {
      OLEDrgb_DefUserChar(&oledrgb, ch, &rgbUserFont[ch * 8]);
   }

   OLEDrgb_SetCursor(&oledrgb, 0, 0);
   OLEDrgb_PutString(&oledrgb, "Digilent"); // Default color (green)
   OLEDrgb_SetCursor(&oledrgb, 4, 4);
   OLEDrgb_SetFontColor(&oledrgb, OLEDrgb_BuildRGB(0, 0, 255)); // Blue font
   OLEDrgb_PutString(&oledrgb, "OledRGB");

   OLEDrgb_SetFontColor(&oledrgb, OLEDrgb_BuildRGB(200, 200, 44));
   OLEDrgb_SetCursor(&oledrgb, 1, 6);
   OLEDrgb_PutChar(&oledrgb, 4);

   OLEDrgb_SetFontColor(&oledrgb, OLEDrgb_BuildRGB(200, 12, 44));
   OLEDrgb_SetCursor(&oledrgb, 5, 6);
   OLEDrgb_PutString(&oledrgb, "Demo");
   OLEDrgb_PutChar(&oledrgb, 0);

   sleep(5); // Wait 5 seconds


   OLEDrgb_DrawBitmap(&oledrgb, 0, 0, 95, 63, (u8*) tommy);
}

//Pong game opening scene
void Pong_open(){
	OLEDrgb_SetCursor(&oledrgb, 3, 3);
	OLEDrgb_PutString(&oledrgb, "ECE385");
	OLEDrgb_SetCursor(&oledrgb, 4, 4);
	OLEDrgb_PutString(&oledrgb, "Final");
	OLEDrgb_SetCursor(&oledrgb, 3, 5);
	OLEDrgb_PutString(&oledrgb, "Project");

	sleep(2);
	OLEDrgb_Clear(&oledrgb);
}

//wait screen
void Pong_wait(){
	int i;
	int press_button;
	press_button = 1;
	OLEDrgb_SetCursor(&oledrgb, 2, 2);
	OLEDrgb_PutString(&oledrgb, "Pong Game");
	OLEDrgb_SetCursor(&oledrgb, 4, 3);
	OLEDrgb_PutString(&oledrgb, "Press");
	OLEDrgb_SetCursor(&oledrgb, 4, 4);
	OLEDrgb_PutString(&oledrgb, "Space");
	OLEDrgb_SetCursor(&oledrgb, 2, 5);
	OLEDrgb_PutString(&oledrgb, "to start");

//	while(press_button){
//		if( (*player1_up == 0x1) || (*player1_dn == 0x1) || (*player2_up == 0x1) || (*player2_dn == 0x1)){
//			press_button = 0;
//		}
//	}

	while(press_button){
		copy_usb_code();
		for(i = 0; i < 6; i++){
			xil_printf("%x \n", keycode_global[i]);
			if(keycode_global[i] == space_hex){
				press_button = 0;
			}
		}
	}

	// add the press space command here
	OLEDrgb_Clear(&oledrgb);
	OLEDrgb_SetCursor(&oledrgb, 3, 2);
	OLEDrgb_PutString(&oledrgb, "Rules:");
	OLEDrgb_SetCursor(&oledrgb, 2, 3);
	OLEDrgb_PutString(&oledrgb, "first to ");
	OLEDrgb_SetCursor(&oledrgb, 2, 4);
	OLEDrgb_PutString(&oledrgb, "reach 5");
	OLEDrgb_SetCursor(&oledrgb, 4, 5);
	OLEDrgb_PutString(&oledrgb, "wins");
	sleep(3);
	OLEDrgb_Clear(&oledrgb);

	OLEDrgb_SetCursor(&oledrgb, 6, 3);
	OLEDrgb_PutString(&oledrgb, "3");
	sleep(1);
	OLEDrgb_Clear(&oledrgb);

	OLEDrgb_SetCursor(&oledrgb, 6, 3);
	OLEDrgb_PutString(&oledrgb, "2");
	sleep(1);
	OLEDrgb_Clear(&oledrgb);

	OLEDrgb_SetCursor(&oledrgb, 6, 3);
	OLEDrgb_PutString(&oledrgb, "1");
	sleep(1);
	OLEDrgb_Clear(&oledrgb);
}


void init_game(){
	score1=0;
	score2=0;
	endgame = 1; //0 means game over
//	keycode_global = GetKeyboardData();
	//{x,y} coordinates
	copy_usb_code();

	pad_position1[0] = 2;
	pad_position1[1] = pad_default;
	pad_position2[0] = 92;
	pad_position2[1] = pad_default;
	ball_position[0] = ball_x_default;
	ball_position[1] = ball_y_defalut;
	ball_vector[0] = 1;
	ball_vector[1] = 1;
	update_score();
}

void draw_pad( ){
	int i,j;
	for (i = pad_position1[0]; i < pad_position1[0] + PAD_WIDTH; i++){  //draw pad 1
		for (j = pad_position1[1]; j < pad_position1[1] + PAD_LENGTH; j++){
			OLEDrgb_DrawPixel(&oledrgb, (u8) i, (u8) j, 0xffff);
		}
	}

	for (i = pad_position2[0]; i < pad_position2[0] + PAD_WIDTH; i++){  //draw pad 2
			for (j = pad_position2[1]; j < pad_position2[1] + PAD_LENGTH; j++){
				OLEDrgb_DrawPixel(&oledrgb, (u8) i, (u8) j, 0xffff);
			}
		}
}

void draw_ball(){
	int i,j;
	for (i = ball_position[0]; i < ball_position[0] + ball_dimen; i++){  //draw ball
		for (j = ball_position[1]; j < ball_position[1] + ball_dimen; j++){
			OLEDrgb_DrawPixel(&oledrgb, (u8) i, (u8) j, 0xffe0);
		}
	}
}


int random_fire(){
	int i;

	i = rand()%2;

	if(i==1){
		return 1;
	}
	else if(i==0){
		return -1;
	}
	return 0;
}


void left_side_score(){

	score1 ++;

	pad_position1[1] = pad_default; //reset pad positioning
	pad_position2[1] = pad_default;

	ball_position[0] = ball_x_default; //set ball position to default and fire ball at left
	ball_position[1] = ball_y_defalut;
	ball_vector[0] = -1;
	ball_vector[1] = random_fire();
}

void right_side_score(){
	score2 ++;

	pad_position1[1] = pad_default; //reset pad positioning
	pad_position2[1] = pad_default;

	ball_position[0] = ball_x_default; //set ball position to default and fire ball at right
	ball_position[1] = ball_y_defalut;
	ball_vector[0] = 1;
	ball_vector[1] = random_fire();
}

void update_score(){
	OLEDrgb_Clear(&oledrgb_sec);
	OLEDrgb_SetCursor(&oledrgb_sec, 0, 3);
	OLEDrgb_PutString(&oledrgb_sec, "Score Board:");

	switch(score1){
		case 0:
			OLEDrgb_SetCursor(&oledrgb_sec, 4, 4);
			OLEDrgb_PutString(&oledrgb_sec, "0");
			break;
		case 1:
			OLEDrgb_SetCursor(&oledrgb_sec, 4, 4);
			OLEDrgb_PutString(&oledrgb_sec, "1");
			break;
		case 2:
			OLEDrgb_SetCursor(&oledrgb_sec, 4, 4);
			OLEDrgb_PutString(&oledrgb_sec, "2");
			break;
		case 3:
			OLEDrgb_SetCursor(&oledrgb_sec, 4, 4);
			OLEDrgb_PutString(&oledrgb_sec, "3");
			break;
		case 4:
			OLEDrgb_SetCursor(&oledrgb_sec, 4, 4);
			OLEDrgb_PutString(&oledrgb_sec, "4");
			break;
		case 5:
			OLEDrgb_SetCursor(&oledrgb_sec, 4, 4);
			OLEDrgb_PutString(&oledrgb_sec, "5");
			break;
	}
	OLEDrgb_SetCursor(&oledrgb_sec, 5, 4);
	OLEDrgb_PutString(&oledrgb_sec, ":");
	switch(score2){
		case 0:
			OLEDrgb_SetCursor(&oledrgb_sec, 6, 4);
			OLEDrgb_PutString(&oledrgb_sec, "0");
			break;
		case 1:
			OLEDrgb_SetCursor(&oledrgb_sec, 6, 4);
			OLEDrgb_PutString(&oledrgb_sec, "1");
			break;
		case 2:
			OLEDrgb_SetCursor(&oledrgb_sec, 6, 4);
			OLEDrgb_PutString(&oledrgb_sec, "2");
			break;
		case 3:
			OLEDrgb_SetCursor(&oledrgb_sec, 6, 4);
			OLEDrgb_PutString(&oledrgb_sec, "3");
			break;
		case 4:
			OLEDrgb_SetCursor(&oledrgb_sec, 6, 4);
			OLEDrgb_PutString(&oledrgb_sec, "4");
			break;
		case 5:
			OLEDrgb_SetCursor(&oledrgb_sec, 6, 4);
			OLEDrgb_PutString(&oledrgb_sec, "5");
			break;
		}
}

void check_score(){
	if ( (score1 == 5) || (score2 == 5) ){
		endgame = 0;
	}
}


void update_PAD_location(){ // the only code that needs to interact with the keyboard
	int i;
//	copy_usb_code();
	usb_keyboard_fetch();
	for(i = 0; i < 6; i++){
		xil_printf("%x \n", keycode_global[i]);
	}

	for(i = 0; i < 6; i++){

		if( (keycode_global[i] == player1_up) && (pad_position1[1] > PAD_upper_limit) ){
			pad_position1[1] = pad_position1[1] - 2;
		}
		if( (keycode_global[i] == player1_dn) && (pad_position1[1] < PAD_lower_limit) ){
			pad_position1[1] = pad_position1[1] + 2;
		}
		if( (keycode_global[i] == player2_up) && (pad_position2[1] > PAD_upper_limit) ){
			pad_position2[1] = pad_position2[1] - 2;
		}
		if( (keycode_global[i] == player2_dn) && (pad_position2[1] < PAD_lower_limit) ){
			pad_position2[1] = pad_position2[1] + 2;
		}
	}
}


void update_ball_location(){
	int ball_upper, ball_lower;
	int pad_range_up, pad_range_down;

	if (ball_position[0] == (int)pad1_right_coord){  	 //check if ball hit left pad
		ball_upper = ball_position[1];
		ball_lower = ball_position[1] + 2;
		pad_range_up = pad_position1[1];
		pad_range_down = pad_position1[1] + 11;

		if( (ball_lower>=pad_range_up) && (ball_upper<=pad_range_down) ){
			ball_vector[0] = -ball_vector[0];
		}
	}
	else if (ball_position[0] == (int)ball_left_limit ){  	 //if ball hit left wall
		right_side_score();
		update_score();
		}
	else if (ball_position[0] == (int)pad2_left_coord){  	 //check if ball hit left pad
		ball_upper = ball_position[1];
		ball_lower = ball_position[1] + 2;
		pad_range_up = pad_position2[1];
		pad_range_down = pad_position2[1] + 11;

		if( (ball_lower>=pad_range_up) && (ball_upper<=pad_range_down) ){
			ball_vector[0] = -ball_vector[0];
		}
	}
	else if (ball_position[0] == (int)ball_right_limit){     //temporary
		left_side_score();
		update_score();
	}
	if (ball_position[1] == (int)ball_upper_limit){  	//check y, just bounce
		ball_vector[1] = -ball_vector[1];
	}
	else if (ball_position[1] == (int)ball_lower_limit){
		ball_vector[1] = -ball_vector[1];
	}
	ball_position[0] = ball_position[0] + ball_vector[0]; //update x coordinates
	ball_position[1] = ball_position[1] + ball_vector[1]; //update y coordinates
}

void decide_win_lose(){
	if(score1 > score2){  //player 1 wins
		OLEDrgb_SetCursor(&oledrgb, 3, 3);
		OLEDrgb_PutString(&oledrgb, "Player 1");
		OLEDrgb_SetCursor(&oledrgb, 3, 4);
		OLEDrgb_PutString(&oledrgb, "you win!");
		sleep(1);
	}
	else{                 //player 2 wins
		OLEDrgb_SetCursor(&oledrgb, 3, 3);
		OLEDrgb_PutString(&oledrgb, "Player 2");
		OLEDrgb_SetCursor(&oledrgb, 3, 4);
		OLEDrgb_PutString(&oledrgb, "you win!");
		sleep(1);
	}
}



void Pong_game_main(){
	init_game(); //initialize global parameters
	while(endgame){
		OLEDrgb_DrawBitmap(&oledrgb, 0, 0, 95, 63, (u8*) arena_default); // draw arena
		update_PAD_location();
		update_ball_location();
		draw_pad();
		draw_ball();
		usleep(100000); //us delay, in theory 1/15 => 66666us
		check_score();
		OLEDrgb_Clear(&oledrgb);
	}
}

void draw_pad_double(){
	int i,j;
	for (i = pad_position1[0]; i < pad_position1[0] + PAD_WIDTH; i++){  //draw pad 1
		for (j = pad_position1[1]; j < pad_position1[1] + PAD_LENGTH; j++){
			arena_b[i * 2 + j * x_reg] = 0xff;
			arena_b[i * 2 + j * x_reg + 1] = 0xff;
		}
	}
	for (i = pad_position2[0]; i < pad_position2[0] + PAD_WIDTH; i++){  //draw pad 2
		for (j = pad_position2[1]; j < pad_position2[1] + PAD_LENGTH; j++){
			arena_b[i * 2 + j * x_reg] = 0xff;
			arena_b[i * 2 + j * x_reg + 1] = 0xff;
		}
	}
}

void draw_ball_double(){
	int i,j;
	for (i = ball_position[0]; i < ball_position[0] + ball_dimen; i++){  //draw ball
		for (j = ball_position[1]; j < ball_position[1] + ball_dimen; j++){
			arena_b[i * 2 + j * x_reg] = 0xff;
			arena_b[i * 2 + j * x_reg + 1] = 0xe0;
		}
	}
}


void Pong_game_main_double(){ //using double buffering
	int i ;
	init_game(); //initialize global parameters
	while(endgame){
		for (i = 0; i < 12288; i++){ //draw arena to buffer
			arena_b[i] = arena_d[i];
		}
		update_PAD_location();
		update_ball_location();
		draw_pad_double();
		draw_ball_double();
		OLEDrgb_DrawBitmap(&oledrgb, 0, 0, 95, 63, (u8*) arena_b); //draw buffer to screen
		check_score();
		OLEDrgb_Clear(&oledrgb);
	}
}


void Pong(){ //controls the flow of the game
	Pong_open();
	while(1){
		Pong_wait();
		//Pong_game_main();
		Pong_game_main_double();
		decide_win_lose();
		sleep(5);
		OLEDrgb_Clear(&oledrgb);
		OLEDrgb_Clear(&oledrgb_sec);
	}
}





void DemoCleanup() {
   DisableCaches();
}

void EnableCaches() {
#ifdef __MICROBLAZE__
#ifdef XPAR_MICROBLAZE_USE_ICACHE
   Xil_ICacheEnable();
#endif
#ifdef XPAR_MICROBLAZE_USE_DCACHE
   Xil_DCacheEnable();
#endif
#endif
}

void DisableCaches() {
#ifdef __MICROBLAZE__
#ifdef XPAR_MICROBLAZE_USE_DCACHE
   Xil_DCacheDisable();
#endif
#ifdef XPAR_MICROBLAZE_USE_ICACHE
   Xil_ICacheDisable();
#endif
#endif
}

