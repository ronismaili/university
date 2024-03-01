#include <iostream>
#include "R_COMMON.h"

using namespace std;

//Employees class implementation
employees::employees() {
    skill_level = rand() % 101;
    time = rand() % 100 + 21;
}

//Customers class implementation
customers::customers() {
    monthly = rand() % 30 + 1;
    payments = rand() % 10000 + 11;
}

//Equipments class implementation
equipments::equipments() {
    quantity = rand() % 1000 + 1;
    price = rand() % 1000 + 1;
}

//Services class implementation
services::services() {
    cost = rand() % 5000 + 1001;
    renewalInterval = rand() % 4 + 1;
}

//Base_organization class implementation
void base_organization::setNumEmp() {
    numEmp = rand() % 50 + 1;
}
void base_organization::setNumCust() {
    numCust = rand() % 50 + 1;
}
void base_organization::setNumEquip() {
    numEquip = rand() % 50 + 1;
}
void base_organization::setNumServ() {
    numServ = rand() % 50 + 1;
}
void base_organization::output() {
    cout << "Number of employees: " << numEmp << endl;
    cout << "Number of customers: " << numCust << endl;
    cout << "Number of equipments: " << numEquip << endl;
    cout << "Number of services: " << numServ << endl;
}

//Organization class implementation
organization::organization() {
    char prefixCha[35], suffixCha[35];
    string prefix[10] = { "The Big", "The Famous", "The Bloody", "The Busy", "The Cautious", "The Bored", "The Calm", "The Clean", "The Bright", "The Charming" };
    string suffix[10] = { " Apples", " Technicians", " Potatos", " Beards", " Kings", " Carpets", " Diamonds", " Lizards", " Dogs", " Glasses" };

    strcpy_s(prefixCha, prefix[rand() % 10].c_str());
    strcpy_s(suffixCha, suffix[rand() % 10].c_str());

    strcat_s(prefixCha, suffixCha);
    name = prefixCha;

    setNumEmp();
    setNumCust();
    setNumEquip();
    setNumServ();

    calcEmp();
    calcCust();
    calcEquip();
    calcServ();

    calcProfit();
}
void organization::output() {
    cout << "Name of the organization: " << name << endl << endl;
    base_organization::output();
    cout << "\nEmployees total profit: " << valueEmpTOTAL << endl;
    cout << "Customers total profit: " << valueCustTOTAL << endl;
    cout << "Equipments total cost: " << valueEquipTOTAL << endl;
    cout << "Services total cost: " << valueServTOTAL << endl;
    cout << "\nTotal profit: " << profit << endl;
    line();
}
void organization::calcEmp() {
    for (int i = 0; i < getNumEmp(); i++) {
        valueEmp[i] = emp[i].skill_level * emp[i].time * 4 * 12 * 3; //Get the 3 year profit for each one individually
    }
    for (int i = 0; i < getNumEmp(); i++) { //Get the 3 year total profit
        valueEmpTOTAL += valueEmp[i];
    }
}
void organization::calcCust() {
    for (int i = 0; i < getNumCust(); i++) {
        valueCust[i] = cust[i].monthly * cust[i].payments * 12 * 3; //Get the 3 year profit for each one individually
    }
    for (int i = 0; i < getNumCust(); i++) { //Get the 3 year total profit
        valueCustTOTAL += valueCust[i];
    }
}
void organization::calcEquip() {
    for (int i = 0; i < getNumEquip(); i++) {
        valueEquip[i] = equip[i].quantity * equip[i].price; //Get the price for each item individually
    }
    for (int i = 0; i < getNumEquip(); i++) {
        valueEquipTOTAL += valueEquip[i]; //Calculate the cost of ALL equipment combined (one time payment)
    }
}
void organization::calcServ() {
    int x;
    for (int i = 0; i < getNumServ(); i++) { //Calculate the cost for every single service individually 
        x = 12 / serv[i].renewalInterval; //x is used to turn all renewal intervals into 12 
        valueServ[i] = x * serv[i].renewalInterval * serv[i].cost; //We multiply by x to get the result for the 12 week cost
        valueServ[i] *= (4 * 3); //Multiply the 12 weeks with 4 to get 1 year and then with 3 to get the result for the 3 year cost
    }

    valueServTOTAL = 0; //Find the total of all different services
    for (int i = 0; i < getNumServ(); i++) {
        valueServTOTAL += valueServ[i];
    }
}
void organization::calcProfit() {
    profit = valueEmpTOTAL + valueCustTOTAL - valueEquipTOTAL - valueServTOTAL;
}
void organization::infoEmp() {
    clean();
    line();
    cout << getName() << " made a total of:\n" << valueEmpTOTAL << "\nfrom their employees.\n";
    line();
}
void organization::infoCust() {
    clean();
    line();
    cout << getName() << " made a total of:\n" << valueCustTOTAL << "\nfrom their customers.\n";
    line();
}
void organization::infoEquip() {
    clean();
    line();
    cout << getName() << " had total expenses of:\n" << valueEquipTOTAL << "\nfrom their equipment.\n";
    line();
}
void organization::infoServ() {
    clean();
    line();
    cout << getName() << " had total expenses of:\n" << valueServTOTAL << "\nfrom their services.\n";
    line();
}