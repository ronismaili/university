#include <iostream> //Used for input/output
#include <ctime> //Used for RNG
#include <stdio.h> //Used for RNG
#include <stdlib.h> //Used for RNG
#include "R_COMMON.h" //Common header file for all of my other user-defined header files

using namespace std;

int main() {
	srand(time(0)); //Randomizer seed for the entire project (USED ONLY ONCE OR ELSE THERE ARE ISSUES!!!)
	beginning();
	menu();
	int rounds = 1, tokens = 6;

	//Main body of the program
	do {
		organization org1, org2, org3;
		start_game(org1, org2, org3, rounds);
		reveal(org1, org2, org3, rounds, tokens);
		decision(org1, org2, org3, rounds, tokens);
	} while (tokens == 6);
}