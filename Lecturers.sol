// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Lecturers {
    struct Lecturer {
        string name;
        uint256 age;
    }

    Lecturer[] public lecturers;
    mapping(string => bool) private lecturerExist;

    function addLecturer(string memory _name, uint256 _age) public {
        require(bytes(_name).length > 0, "Name cannot be empty");
        require(!lecturerExist[_name], "Lecturer already exist!");
        lecturerExist[_name] = true;
        lecturers.push(Lecturer(_name, _age));
    }

    function getLecturers() public view returns (Lecturer[] memory) {
        return lecturers;
    }
}