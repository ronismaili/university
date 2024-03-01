#pragma once

struct leaderboard {
    std::string name; //Userame of the player
    int rounds; //The amount of rounds the player has won
    bool exists; //Does this player exist (for when the file is empty / first runtime)
};