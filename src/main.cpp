//
// Created by Garrison Creek on 2/26/24.
//
#include <iostream>
#include <vector>
#include <string>
#include "Tracker.cpp"

int main()
{
    Tracker tracker;
    tracker.load();
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
            tracker.create_goal(name, std::time(nullptr));
        }
        else if (userChoice == "f")
        {
            int index;
            std::cout << "Enter the index of the goal to complete: ";
            std::cin >> index;
            tracker.complete_goal(index - 1);
        }
        else if (userChoice == "d")
        {
            int index;
            std::cout << "Enter the index of the goal to delete: ";
            std::cin >> index;
            tracker.remove_goal(index - 1);
        }
    }
    tracker.save();

    return 0;
}