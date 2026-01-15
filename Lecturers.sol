// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Lecturers {
    struct Lecturer {
        string name;
        uint256 age;
    }

    Lecturer[] public lecturers;

    function addLecturer(string memory _name, uint256 _age) public {
        lecturers.push(Lecturer(_name, _age));
    }
}