// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract Courses {
    struct Course {
        string title;
        uint256 unit;
        string code;
        string lecturer;
    }

    Course[] public courses;

    mapping(string => Course) public codeToCourse;


    function createCourse (
        string memory _title,
        string memory _code,
        uint256 _unit,
        string memory _lecturer
    ) public  {
        Course memory newCourse = Course({
            title: _title,
            unit: _unit,
            code: _code,
            lecturer: _lecturer
        });

        courses.push(newCourse);
        codeToCourse[_code] = newCourse;
    }
}