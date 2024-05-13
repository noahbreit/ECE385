#ifndef PMOD_H
#define PMOD_H

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


#endif
