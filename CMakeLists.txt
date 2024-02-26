cmake_minimum_required(VERSION 3.24)
project(c346_sp24_34658_project_qualityassurance)

set(CMAKE_CXX_STANDARD 14)

include_directories(src)

add_executable(c346_sp24_34658_project_qualityassurance
        src/main.cpp src/Goal.cpp src/Habit.cpp src/Tracker.cpp)
