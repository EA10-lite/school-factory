// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Courses} from "./Courses.sol";
import {StudentRecords} from "./StudentRecords.sol";
import {Lecturers} from "./Lecturers.sol";

contract SchoolFactory {
    Courses[] public courses;
    StudentRecords[] public studentRecords;
    Lecturers[] public lecturers;

    struct Schools {
        Courses courses;
        StudentRecords students;
        Lecturers lecturers;
    }

    Schools[] public schools;

    function registerSchool() public {
        Courses newCourses = new Courses();
        StudentRecords newStudentRecords = new StudentRecords();
        Lecturers newLecturer = new Lecturers();

        schools.push(Schools(newCourses, newStudentRecords, newLecturer));
    }
}