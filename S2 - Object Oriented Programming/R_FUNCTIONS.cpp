#include <iostream>
#include "R_COMMON.h"

using namespace std;

//Game functions

    //Sections of the game
void beginning() {
    clean();
    line();
    cout << "Welcome to GUESS DA PROFIT (GDP)!\n";
    line();
    LBlistBest();
    pause();
}

void menu() {
    char input;
    do {
        clean();
        line();
        cout << "GUESS DA PROFIT (GDP)\n";
        line();
        cout << "To start playing, press 1\nTo view the rules, press 2\nTo view the leaderboard, press 3\nTo exit the game, press 4\n";
        line();
        cin >> input;

        switch (input) {
        case '1': //The input value remains '1'
            break;
        case '2':
            rules(); //Display the rules, the input value remains '2'
            break;
        case '3':
            LBlistAll(); //Display the leaderboard, the input value remains '3'
            break;
        case '4':
            ending(); //Exit the game & credits
            break;
        default:
            input = '\0'; //Null character for safety purposes
        }    
    }
    while (input != '1');
}

void rules() {
    clean();
    line();
    cout << "The premise of the game is as follows:\n";
    cout << "You are offered 3 different organizations.\n";
    cout << "All of them have different structures.\n\n";
    cout << "You are given 6 reveal tokens.\n";
    cout << "You can expend 1 reveal token to look at a detailed list of information about 1 of the organizations.\n";
    cout << "You can choose between: Employees, Customers, Equipment and Services.\n\n";
    cout << "Employees - Each employee produces money.\n";
    cout << "The amount of money they produce depends on their skill level and amount of time they spend at work.\n\n";
    cout << "Customers - Are another source of money.\n";
    cout << "The amount of money customers produce depends on how often they visit and how much they spend.\n\n";
    cout << "Equipment - Is where money is spent.\n";
    cout << "These are one time expenses only, you buy them once and you have them forever.\n\n";
    cout << "Services - Are weekly subscriptions where organizations spend their money.\n";
    cout << "These services are paid every X weeks where X depends on the type of service.\n\n";
    cout << "To win, you have to choose only 1 organization that you believe will make the most money in 3 years.\n";
    cout << "If you win, you get 3 new organizations to choose from and the game continues.\n";
    cout << "If you choose wrongly, it's GAME OVER!\n";
    line();
    pause();
}

void ending() {
    clean();
    line();
    cout << "Thanks for playing!\n";
    cout << "A game made by Ron Ismaili\n";
    line();
    cout << "\n\n\n\n";
    cout << " ++++++++++ " << "      +++++++++  " << " ++++      ++ " << " +++" << endl;
    cout << " +++++++++++ " << "    +++++++++++ " << " +++++     ++ " << " +++" << endl;
    cout << " +++     +++ " << "    ++       ++ " << " ++ +++    ++ " << "    " << endl;
    cout << " +++   ++++ " << "     ++       ++ " << " ++   +++  ++ " << " +++" << endl;
    cout << " ++++++++++ " << "     ++       ++ " << " ++    +++ ++ " << " +++" << endl;
    cout << " +++     ++++ " << "   ++       ++ " << " ++     +++++ " << " +++" << endl;
    cout << " +++      +++++ " << " +++++++++++ " << " ++      ++++ " << " +++" << endl;
    cout << " +++        ++++ " << " +++++++++  " << " ++       +++ " << " +++" << endl;
    cout << "\n\n\n\n";
    line();
    exit(0);
}

void gameover() {
    string username;
    clean();
    line();
    cout << "GUESS DA PROFIT (GDP)\n";
    line();
    cout << "Add your name to the leaderboard:\n";
    cout << "Input your username: ";
    cin >> username;
    LBadd(username);
    line();
    pause();
}

    //Primary game mechanics
void start_game(organization& org1, organization& org2, organization& org3, int rounds) {
    clean();
    line();
    cout << "ROUND " << rounds << endl;
    line();
    cout << "These are your organizations:\n";
    line();
    cout << "Organization 1: " << org1.getName() << endl;
    cout << "Organization 2: " << org2.getName() << endl;
    cout << "Organization 3: " << org3.getName() << endl;
    line();
    pause();
    clean();
};

void reveal(organization& org1, organization& org2, organization& org3, int rounds, int tokens) {
    organization org[3];
    org[0] = org1; org[1] = org2; org[2] = org3;
    char input1, input2;
    bool x;

    do {
        clean();
        line();
        cout << "ROUND " << rounds << endl;
        line();
        cout << "Your tokens: " << tokens << endl;
        line();
        cout << "Reveal information about:" << endl;
        cout << "Employees [1]\nCustomers [2]\nEquipment [3]\nServices  [4]" << endl;
        line();
        cout << "User input: ";

        x = true;
        do {
            cin >> input1;
            if (input1 == '1' || input1 == '2' || input1 == '3' || input1 == '4') { //Input validation
                x = false;
            }
            else {
                cout << "Wrong input, try again: ";
            }
        } while (x);

        clean();
        line();
        cout << "Which organization will you pick?" << endl;
        line();
        cout << "Organization [1]: " << org1.getName() << endl;
        cout << "Organization [2]: " << org2.getName() << endl;
        cout << "Organization [3]: " << org3.getName() << endl;
        line();
        cout << "User input: ";

        x = true;
        do {
            cin >> input2;
            if (input2 == '1' || input2 == '2' || input2 == '3') { //Input validation
                x = false;
            }
            else {
                cout << "Wrong input, try again: ";
            }
        } while (x);
        clean();

        showInfo(org, input1, input2);
        tokens--;
    } while (tokens != 0);
}

void showInfo(organization org[], char input1, char input2) {
    int x = (int)input2;
    switch (x) { //Turn the input2 into a integer using its ascii value
    case 49:
        x = 1;
        break;
    case 50:
        x = 2;
        break;
    case 51:
        x = 3;
        break;
    }

    switch (input1) {
    case '1': //Employees
        org[x - 1].infoEmp();
        break;
    case '2': //Customers
        org[x - 1].infoCust();
        break;
    case '3': //Equipment
        org[x - 1].infoEquip();
        break;
    case '4': //Services
        org[x - 1].infoServ();
        break;
    }

    pause();
}

void decision(organization& org1, organization& org2, organization& org3, int& rounds, int& tokens) {
    char input;
    bool x = true;
    int compare1, compare2;
    organization org[3];
    org[0] = org1; org[1] = org2; org[2] = org3;

    clean();
    line();
    cout << "You are out of Tokens!\n";
    line();
    cout << "Pick which organization you think has the\nmost profit in the next 3 years.\n";
    line();
    cout << "Organization 1: " << org1.getName() << endl;
    cout << "Organization 2: " << org2.getName() << endl;
    cout << "Organization 3: " << org3.getName() << endl;
    line();
    cout << "User input: ";
   
    do {
        cin >> input;
        if (input == '1' || input == '2' || input == '3') {
            x = false;
        }
        else {
            cout << "Wrong input, try again: ";
        }
    } while (x);

    switch (input) {
    case '1':
        compare1 = 1;
        break;
    case '2':
        compare1 = 2;
        break;
    case '3':
        compare1 = 3;
        break;
    }

    if (org1.getProfit() > org2.getProfit() && org1.getProfit() > org3.getProfit()) {
        compare2 = 1;
    }
    else if (org2.getProfit() > org3.getProfit()) {
        compare2 = 2;
    }
    else {
        compare2 = 3;
    }

    if (compare1 == compare2) { //Victory
        rounds++;
        tokens = 6;
        clean();
        line();
        cout << "Congratulations, you won this round!\n";
        line();
        pause();

        clean();
        line();
        cout << "Organization 1: " << endl;
        org1.output();
        cout << "Organization 2: " << endl;
        org2.output();
        cout << "Organization 3: " << endl;
        org3.output();
        pause();
    }
    else { //Defeat
        clean();
        line();
        cout << "Game Over, you lost this round!\n";
        line();
        pause();
        
        clean();
        line();
        cout << "Organization 1: " << endl;
        org1.output();
        cout << "Organization 2: " << endl;
        org2.output();
        cout << "Organization 3: " << endl;
        org3.output();
        cout << "You picked: " << org[compare1 - 1].getName() << "\nWinning organization: " << org[compare2 - 1].getName() << endl << endl;
        pause();
        gameover();
        ending();
    }
}

//Leaderboard functions
void LBlistBest() {
    leaderboard bestPlayer;
    LBfindBest(bestPlayer);

    cout << "The current best player is:\n";

    if (bestPlayer.exists) {
        cout << "USERNAME: " << bestPlayer.name << endl;
        cout << "ROUNDS: " << bestPlayer.rounds << endl;
        cout << "\nCan you beat them?\n";
    }
    else {
        cout << "\nThe leaderboard is currently empty.\nBe the first to claim a spot on the leaderboard!\n";

    }
    line();
}

void LBfindBest(leaderboard& best) {
    best.exists = false;
    //FIND THE BEST PLAYER IN THE FILE
}

void LBlistAll() {
    clean();
    cout << "STILL WIP\n";
    pause();
}

void LBadd(string username) {

}

//Utility functions

    //Console manipulation
void line() {
    cout << "===============================================\n";
}

void clean() {
    system("cls");
}

void pause() {
    system("pause");
}

//File functions
