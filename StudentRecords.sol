// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract StudentRecords {
    struct Student {
        string name;
        uint256 age;
        string gender;
        string department;
    }

    Student[] public students;

    mapping(string => Student) public nameToRecord;

    function registerStudent(
        string memory _name,
        uint256 _age,
        string memory _gender,
        string memory _department
    ) public {
        Student memory newStudent = Student(_name, _age, _gender, _department);
        students.push(newStudent);
        nameToRecord[_name] = newStudent;
    }

    function getStudentByIndex(uint256 _index) public view returns (Student memory) {
        return students[_index];
    }
}