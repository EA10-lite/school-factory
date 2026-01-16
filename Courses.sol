// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Lecturers} from "./Lecturers.sol";

contract Courses {
    struct Course {
        string title;
        uint256 unit;
        string code;
        string lecturer;
    }

    Course[] public courses;

    mapping(string => Course) private codeToCourse;
    mapping(string => bool) private courseExist;


    function createCourse (
        string memory _title,
        string memory _code,
        uint256 _unit,
        string memory _lecturer
    ) public  {
        require(bytes(_title).length > 0, "Course title cannot be empty!");
        require(_unit > 0, "Course unit must be greater than 0!");
        require(!courseExist[_title], "Course already added!");
        courseExist[_title] = true;
        // courses can't be created without lecturer
        Course memory newCourse = Course({
            title: _title,
            unit: _unit,
            code: _code,
            lecturer: _lecturer
        });

        courses.push(newCourse);
        codeToCourse[_code] = newCourse;
    }
    

    function getCourses() public view returns (Course[] memory) {
        return courses;
    }
}