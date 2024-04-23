//
// Created by Garrison Creek on 2/26/24.
//

#include <iostream>
#include <vector>
#include <string>
#include "Goal.cpp"
#include "Habit.cpp"
#include <fstream>
#include <sstream>


class Tracker {
private:
    std::vector<Goal> goal_list;
    std::vector<Habit> habit_list;

public:

    void create_goal (std::string title, std::time_t deadline)
    {
        Goal goal(title, deadline);
        goal_list.push_back(goal);
    }

    void create_habit (std::string title, std::time_t date_created, Habit::Frequency frequency)
    {
        Habit habit(title, date_created, frequency);
        habit_list.push_back(habit);
    }

    void complete_goal (size_t index)
    {
        goal_list[index].complete();
    }

    void complete_habit (size_t index)
    {
        habit_list[index].complete();
    }

    void miss_habit (size_t index)
    {
        habit_list[index].miss();
    }

    void remove_goal (size_t index)
    {
        goal_list.erase(goal_list.begin() + index);
    }

    void remove_habit (size_t index)
    {
        habit_list.erase(habit_list.begin() + index);
    }

    void displayGoals()
    {
        std::cout << "Goals:\n";
        for (size_t i = 0; i < goal_list.size(); ++i) {
            std::cout << i + 1 << ". " << goal_list[i].title << (goal_list[i].is_complete ? " (Completed)" : "") << "\n";
        }
    }

    void display_habits()
    {
        std::cout << "Habits:\n";
        for (size_t i = 0; i < habit_list.size(); ++i) {
            std::cout << i + 1 << ". " << habit_list[i].title << (habit_list[i].is_complete ? " (Completed)" : "") << "\n";
        }
    }


    void save ()
    {
        std::ofstream file("src/data/prototypedata.txt");
        if (file.is_open()) {
            for (const auto &goal : goal_list) {
                file << goal.title << ',' << goal.content << ',' << goal.date_due << ',' << goal.is_complete << ',' << goal.date_completed << ',' << goal.date_created << std::endl;
            }
            file.close();
        }
        else {
            std::cerr << "Error: Unable to open file for writing." << std::endl;
        }
    }

    void load ()
    {
        std::ifstream file("src/data/prototypedata.txt");
        goal_list.clear();

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

                Goal goal = Goal(name, dueDate);
                goal.is_complete = isComplete;
                goal.date_created = dateCompleted;
                goal.date_created = dateCreated;
                goal_list.push_back(goal);
            }
            file.close();
        }
        else {
            std::cerr << "Error: Unable to open file for reading." << std::endl;
        }
    }
};