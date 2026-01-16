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
    mapping(string => bool) private studentExist;

    function registerStudent(
        string memory _name,
        uint256 _age,
        string memory _gender,
        string memory _department
    ) public {
        require(bytes(_name).length > 0, "Name cannot be empty");
        require(_age > 17, "Age cannot be less than 17");
        require(
            compareString(_gender, "male") || compareString(_gender, "female"),
            "Gender must be male or female"
        );
        require(!studentExist[_name], "Student already registered!");
        studentExist[_name] = true;
        Student memory newStudent = Student(_name, _age, _gender, _department);
        students.push(newStudent);
    }

    function getStudents() public view returns (Student[] memory) {
        return students;
    }

    function compareString(string memory a, string memory b) private pure returns (bool) {
        return keccak256(bytes(a)) == keccak256(bytes(b));
    }
}
