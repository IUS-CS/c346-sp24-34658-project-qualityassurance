//
// Created by Garrison Creek on 2/26/24.
//

#include <iostream>
#include <vector>

struct Goal {
    std::string title;
    std::string content;
    bool is_complete;
    std::time_t date_due;
    std::time_t date_created;
    std::time_t date_completed;

    Goal(std::string title, std::time_t date_due) {
        this->title = title;
        this->date_due = date_due;
        this->date_created = std::time(nullptr);
        this->is_complete = false;
    }

    void complete() {
        this->is_complete = true;
        this->date_completed = std::time(nullptr);
    }

    void remove() {
        delete this;
    }

};