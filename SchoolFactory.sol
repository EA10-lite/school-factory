// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Courses} from "./Courses.sol";
import {StudentRecords} from "./StudentRecords.sol";
import {Lecturers} from "./Lecturers.sol";

contract SchoolFactory {
    struct School {
        string name;
        string country;
        string city;
        string schoolAddress;
        address owner;
        Courses courses;
        StudentRecords students;
        Lecturers lecturers;
    }

    School[] public schools;
    mapping(string => bool) private nameTaken;
    mapping(string => bool) private lecturerExist;

    function registerSchool(
        string memory _name,
        string memory _country,
        string memory _city,
        string memory _schoolAddress
    ) public {
        require(!nameTaken[_name], "School name already exists");
        nameTaken[_name] = true;

        Courses newCourses = new Courses();
        StudentRecords newStudentRecords = new StudentRecords();
        Lecturers newLecturer = new Lecturers();

        School memory newSchool = School(
            _name,
            _country,
            _city,
            _schoolAddress,
            msg.sender,
            newCourses,
            newStudentRecords,
            newLecturer
        );

        schools.push(newSchool);
    }

    function getMySchools() public view returns(School[] memory)  {
        address owner = msg.sender;
        // Count how many schools owned by msg.sender
        uint256 count = 0;
        for(uint256 i = 0; i < schools.length; i++) {
            if (schools[i].owner == owner) {
                count++;
            }
        }

        // Create a fixed array based on the count
        School[] memory mySchools = new School[](count);
        uint256 index = 0;
        for (uint256 i = 0; i < schools.length; i++) {
            if (schools[i].owner == owner) {
                mySchools[index] = schools[i];
                index++;
            }
        }

        return mySchools;
    }

    function addLecturerToSchool() public {

    }


    function addCourseToSchoo(
        uint256 _schoolIndex,
        string memory _courseTitle,
        string memory _courseCode,
        uint256 _courseUnit,
        string memory _lecturerName
    ) public {
        School storage school = schools[_schoolIndex];
        require(msg.sender == school.owner, "Only owner can add courses");

        school.courses.createCourse(
            _courseTitle,
            _courseCode,
            _courseUnit,
            _lecturerName
        );
    }
}