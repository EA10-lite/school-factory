// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Courses} from "./Courses.sol";
import {StudentRecords} from "./StudentRecords.sol";

contract SchoolFactory {
    Courses[] public courses;
    StudentRecords[] public studentRecords;

    struct Schools {
        Courses courses;
        StudentRecords students;
    }

    Schools[] public schools;

    function registerSchool() public {
        Courses newCourses = new Courses();
        StudentRecords newStudentRecords = new StudentRecords();

        schools.push(Schools(newCourses, newStudentRecords));
    }
}