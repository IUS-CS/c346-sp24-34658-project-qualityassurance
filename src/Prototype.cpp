//
// Created by Garrison Creek on 2/13/24.
//

#include "Goals.h"
#include <iostream>
#include <string>
#include <vector>
#include <fstream>
#include <sstream>

struct Goal
{
    std::string name;
    std::string description;
    std::time_t dueDate;
    bool isComplete;
    // stat keeping
    std::time_t dateCompleted;
    std::time_t dateCreated;
//    int timesCompleted;
//    int timesFailed;
//    int timesExtended;

    Goal (std::string name, std::string description, std::time_t dueDate)
    {
        this->name = name;
        this->description = description;
        this->dueDate = dueDate;
        this->isComplete = false;
        this->dateCreated = std::time(nullptr); // current time at creation
        this->dateCompleted = 0;
    }

};

class GoalTracker
{
private:

    std::vector <Goal> goalList;

public:

    void displayGoals ()
    {
        for (int i = 0; i < goalList.size(); i++)
        {
            if (goalList[i].isComplete)
            {
                std::cout << i+1 << "   . " << goalList[i].name << " - (Completed)" << std::endl;
            }
            else
            {
                std::cout << i+1 << "   . " << goalList[i].name << " - Due: " << std::asctime(std::localtime(&goalList[i].dueDate));
            }
        }
    }
    void createGoal (std::string name, std::string description, std::time_t dueDate )
    {
        Goal newGoal = Goal(name, description, dueDate);
        goalList.push_back(newGoal);
    }

    void completeGoal (int index)
    {
        goalList[index].isComplete = true;
        goalList[index].dateCompleted = std::time(nullptr);
        std::cout << "Goal \"" << goalList[index].name << "\" completed on " << std::asctime(std::localtime(&goalList[index].dateCompleted)) << std::endl;
    }

    void deleteGoal (int index)
    {
        goalList.erase(goalList.begin() + index);
    }

    void saveGoals ()
    {
        std::ofstream file("../src/data/prototypedata.txt");
        if (file.is_open()) {
            for (const auto &goal : goalList) {
                file << goal.name << ',' << goal.description << ',' << goal.dueDate << ',' << goal.isComplete << ',' << goal.dateCompleted << ',' << goal.dateCreated << std::endl;
            }
            file.close();
        }
        else {
            std::cerr << "Error: Unable to open file for writing." << std::endl;
        }
    }

    void loadGoals ()
    {
        std::ifstream file("../src/data/prototypedata.txt");
        goalList.clear();

        if (file.is_open()) {
            std::string line;
            while (std::getline(file, line)) {
                std::string name;
                std::string description;
                std::time_t dueDate;
                bool isComplete;
                std::time_t dateCompleted;
                std::time_t dateCreated;

                std::stringstream ss(line);
                std::getline(ss, name, ',');
                std::getline(ss, description, ',');
                ss >> dueDate;
                ss.ignore();
                ss >> isComplete;
                ss.ignore();
                ss >> dateCompleted;
                ss.ignore();
                ss >> dateCreated;

                Goal goal = Goal(name, description, dueDate);
                goal.isComplete = isComplete;
                goal.dateCompleted = dateCompleted;
                goal.dateCreated = dateCreated;
                goalList.push_back(goal);
            }
            file.close();
        }
        else {
            std::cerr << "Error: Unable to open file for reading." << std::endl;
        }
    }


};

int main()
{
    GoalTracker tracker;
    tracker.loadGoals();
//    tracker.createGoal("Lose 10 lbs", "", std::time(nullptr));
//    tracker.createGoal("Read 10 books", "", std::time(nullptr));
//    tracker.createGoal("Run a marathon", "", std::time(nullptr));

    while (true) {
        std::cout << "Goals:" << std::endl;
        tracker.displayGoals();
        std::cout << std::endl;
        std::cout << "Enter C to create a new goal." << std::endl;
        std::cout << "Enter F to complete a goal." << std::endl;
        std::cout << "Enter D to delete a goal." << std::endl;
        std::cout << "Enter Q to exit." << std::endl;
        std::cout << ": ";


        std::string userChoice;
        std::cin >> userChoice;

        if (userChoice == "q")
        {
            break;
        }
        else if (userChoice == "c")
        {
            std::string name;
            std::cout << "Enter the name of the goal: ";
            getline(std::cin, name); // buffer TODO: fix this
            getline(std::cin, name);
            tracker.createGoal(name, name, std::time(nullptr));
        }
        else if (userChoice == "f")
        {
            int index;
            std::cout << "Enter the index of the goal to complete: ";
            std::cin >> index;
            tracker.completeGoal(index - 1);
        }
        else if (userChoice == "d")
        {
            int index;
            std::cout << "Enter the index of the goal to delete: ";
            std::cin >> index;
            tracker.deleteGoal(index - 1);
        }
    }
    tracker.saveGoals();

    return 0;
}