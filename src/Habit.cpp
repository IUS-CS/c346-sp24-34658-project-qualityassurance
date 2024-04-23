//
// Created by Garrison Creek on 2/26/24.
//

#include <iostream>
#include <vector>

struct Habit {
    std::string title;
    std::string content;
    bool is_complete;
    std::time_t date_created;
    int streak;
    enum Frequency {
        DAILY,
        WEEKLY,
        MONTHLY
    } frequency;

    std::vector<std::time_t> dates_completed;
    std::vector<std::time_t> dates_missed;

    Habit(std::string title, std::time_t date_created, Frequency frequency) {
        this->title = title;
        this->date_created = date_created;
        this->is_complete = false;
        this->streak = 0;
        this->frequency = frequency;
    }

    void complete() {
        this->is_complete = true;
        this->dates_completed.push_back(std::time(nullptr));
        this->streak++;
    }
    void miss() {
        this->dates_missed.push_back(std::time(nullptr));
        this->streak = 0;
    }

    void remove() {
        delete this;
    }
};