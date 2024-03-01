#pragma once
#include "R_STRUCTURES.h"

//Game functions - USED FOR OPERATING THE GAME 

	//Sections of the game
void beginning();						//The landing section of the game (on startup)
void menu();							//Pre-game menu (basically the main menu of the game)
void rules();							//Rules of the game
void ending();							//Exit section of the game (credits)
void gameover();						//Game over section of the game

	//Primary game mechanics
void start_game(organization& org1, organization& org2, organization& org3, int rounds);				//Starts the game by showing the 3 organizations
void reveal(organization& org1, organization& org2, organization& org3, int rounds, int tokens);		//Player picks what information to reveal
void showInfo(organization org[], char input1, char input2);											//Information about the chosen organization is revealed
void decision(organization& org1, organization& org2, organization& org3, int& rounds, int& tokens);	//Player guesses which organization made more profit

//Leaderboard functions - USED FOR KEEPING TRACK OF PLAYER SCORES
void LBlistBest();						//Show the best player
void LBfindBest(leaderboard& best);		//Find the best player
void LBlistAll();						//List all of the players in the leaderboard
void LBadd(std::string username);

//Utility functions - USED FOR MAKING MY LIFE EASIER (UTILITY) 
void line();							//Creates a line (purely aesthetical)
void clean();							//Cleans the console
void pause();							//Wait for user input (pause the console)

//File functions - USED FOR WORKING WITH FILES
