#pragma once

class employees {
public:
    int skill_level; //0 - 100 (Higher is better)
    int time; //How much time they spent at work in a week (20 - 100 hours)
    employees(); //Randomly create the employee
};

class customers {
public:
    int monthly; //How often in a month a customer interacts with the organization (1 - 30)
    int payments; //How much the customer pays each interaction (10 - 10000)
    customers(); //Randomly create the customer
};

class equipments {
public:
    int quantity; //How many items of this category (1-1000)
    int price; //The price of each item (1-1000)
    equipments(); //Randomly create the equipment
};

class services {
public:
    int cost; //The cost of the service (1000 - 6000)
    int renewalInterval; //Every x week the payment has to be done (1 - 4)
    services(); //Randomly create the service
};

class base_organization {
private:
    int numEmp, numCust, numEquip, numServ; //Number of actual structure members (used for the arrays)
public:
    int getNumEmp() { return numEmp; }
    int getNumCust() { return numCust; }
    int getNumEquip() { return numEquip; }
    int getNumServ() { return numServ; }
    void setNumEmp();
    void setNumCust();
    void setNumEquip();
    void setNumServ();
    void output();
};

class organization : public base_organization {
private:
    std::string name;
    employees emp[50];
    customers cust[50];
    equipments equip[50];
    services serv[50];

    long int valueEmp[50], valueCust[50], valueEquip[50], valueServ[50]; //Amount of money each one individually brings or expends for their own time interval 
    long int valueEmpTOTAL = 0, valueCustTOTAL = 0, valueEquipTOTAL = 0, valueServTOTAL = 0; //The profit function calculates and sets the 3 year values into these variables
    long int profit; //The 3 year profitability will be stored here for all 3
public:
    organization();
    std::string getName() { return name; }
    long int getProfit() { return profit; }
    void output();

    void calcEmp();
    void calcCust();
    void calcEquip();
    void calcServ();
    void calcProfit();

    void infoEmp();
    void infoCust();
    void infoEquip();
    void infoServ();
};