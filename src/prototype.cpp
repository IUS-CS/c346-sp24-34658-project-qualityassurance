//
// Created by Garrison Creek on 2/13/24.
//

#include <iostream>
#include <string>
#include <vector>
#include <fstream>
#include <sstream>
#include <map>
#include <ctime>

struct Goal
{
    std::string name;
    std::string description;
    std::time_t dueDate;
    bool isComplete;
    // stat keeping
    std::time_t dateCompleted;
    std::time_t dateCreated;
    std::string progress;
//    int timesCompleted;
//    int timesFailed;
//    int timesExtended;

    Goal (std::string name, std::string description, std::time_t dueDate, std:: string progress)
    //{
        :name(name), description(description),dueDate(dueDate) ,isComplete(false)
        ,dateCreated(std::time(nullptr)) ,dateCompleted(0), progress(progress) {}

//        this->name = name;
//        this->description = description;
//        this->dueDate = dueDate;
//        this->isComplete = false;
//        this->dateCreated = std::time(nullptr); // current time at creation
//        this->dateCompleted = 0;
//        this->progress = progress;
   // }

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
                std::cout << i+1 << ". " << goalList[i].name << " - (Completed)" << std::endl;
            }
            else
            {
                std::cout << i+1 << " . " << goalList[i].name << " - Due: " << std::asctime(std::localtime(&goalList[i].dueDate));
            }
        }
    }
    void createGoal (std::string name, std::string description, std::time_t dueDate )
    {
        Goal newGoal = Goal(name, description, dueDate,"");
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

                Goal goal = Goal(name, description, dueDate, "");
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
    void trackProgress(int index, int amount) {
        goalList[index].progress += amount;
        std::cout << "Progress updated for goal \"" << goalList[index].name << "\"" << std::endl;
    }

    void setReminder(int index, std::string reminder) {
        // Implement reminder functionality using a notification system
        std::cout << "Reminder set for goal \"" << goalList[index].name << "\": " << reminder << std::endl;
    }

    void viewStatistics(int index) {
        // Display detailed statistics and insights for a specific goal
        std::cout << "Name: " << goalList[index].name << std::endl;
        std::cout << "Description: " << goalList[index].description << std::endl;

        // Cover progress string to integer  for comparison
        int progress = std::stoi(goalList[index].progress);

        // Provide motivation quotes based on statistics
        if (progress < 25) {
            std::cout << "You've made a good start, keep going! Remember, every step counts." << std::endl;
        } else if (progress >= 25 && progress < 50) {
            std::cout << "Halfway there! Keep pushing yourself, you're doing great." << std::endl;
        } else if (progress >= 50 && progress < 75) {
            std::cout << "You're making great progress, keep up the good work!" << std::endl;
        } else {
            std::cout << "Almost there! You're so close to reaching your goal, keep going strong!" << std::endl;
        }
    }

    void shareProgress() {
        // Implement functionality to share progress with friends and family
        std::cout << "Sharing progress with friends and family." << std::endl;
    }

    void customizeApp(std::string theme) {
        // Implement app customization with different themes and colors
        std::cout << "App customized with theme: " << theme << std::endl;
    }
};

int main()
{
    GoalTracker tracker;
    //tracker.loadGoals();
    tracker.createGoal("Lose 10 lbs", "", std::time(nullptr));
    tracker.createGoal("Read 10 books", "", std::time(nullptr));
    tracker.createGoal("Run a marathon", "", std::time(nullptr));

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

        if (userChoice == "Q" || userChoice == "q") {
            break;
        } else if (userChoice == "C" || userChoice == "c") {
            std::string name, description;
            std::time_t dueDate = std::time(nullptr);
            std::cout << "Enter the name of the goal: ";
            std::cin.ignore();
            getline(std::cin, name); // buffer TODO: fix this
            //getline(std::cin, name);
            std::cout << "Enter the description of the goal: ";
            getline(std::cin, description);
            //tracker.createGoal(name, name, std::time(nullptr));
            tracker.createGoal(name, description, dueDate);
        }
            //else if (userChoice == "f")
        else if (userChoice == "F" || userChoice == "f") {
            int index;
            std::cout << "Enter the index of the goal to complete: ";
            std::cin >> index;
            tracker.completeGoal(index - 1);
        }
//        else if (userChoice == "d")
//        {
//            int index;
//            std::cout << "Enter the index of the goal to delete: ";
//            std::cin >> index;
//            tracker.deleteGoal(index - 1);
//        }
//    }
//    tracker.saveGoals();
    }

    return 0;
}