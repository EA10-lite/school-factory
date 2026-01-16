// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Courses} from "./Courses.sol";
import {StudentRecords} from "./StudentRecords.sol";
import {Lecturers} from "./Lecturers.sol";

contract SchoolFactory {
    struct School {
        uint256 id;
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

        uint256 _schoolId = schools.length + 1;

        School memory newSchool = School(
            _schoolId,
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

    function getMySchool(uint256 _schoolId) public view returns (School memory) {
        // Use the school id to find the school
        School memory mySchool;
        bool found = false;

        for (uint256 i = 0; i < schools.length; i++) {
            if(schools[i].id == _schoolId) {
                mySchool = schools[i];
                found = true;
                break;
            }
        }

        // Check if my school exist
        require(found, "School not found");

        // Ensure the caller is the owner of the school
        require(msg.sender == mySchool.owner, "You are not the owner of this school");
        return mySchool;
    }

    function _getMySchool(uint256 _schoolId) internal view returns (School storage) {
        for(uint256 i = 0; i < schools.length; i++) {
            if(schools[i].id == _schoolId) {
                require(
                    schools[i].owner == msg.sender, 
                    "You are not the owner of this school"
                );
                return schools[i];
            }
        }

        revert("School not found");
    }

    function registerStudent(
        uint256 _schoolId,
        string memory name,
        string memory gender,
        string memory department,
        uint256 age
    ) public {
        School storage mySchool = _getMySchool(_schoolId);
        mySchool.students.registerStudent(
            name,
            age,
            gender,
            department
        );
    }

    function addLecturerToSchool(
        uint256 _schoolId,
        string memory _name,
        uint256 _age
    ) public {
        School storage mySchool = _getMySchool(_schoolId);
        mySchool.lecturers.addLecturer(_name, _age);
    }


    function addCourseToSchoo(
        uint256 _schoolId,
        string memory _courseTitle,
        string memory _courseCode,
        uint256 _courseUnit,
        string memory _lecturerName
    ) public {
        School storage school = _getMySchool(_schoolId);
        require(msg.sender == school.owner, "Only owner can add courses");

        school.courses.createCourse(
            _courseTitle,
            _courseCode,
            _courseUnit,
            _lecturerName
        );
    }
}