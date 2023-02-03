// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract UserData {
    struct User {
        string name;
        string email;
        uint phone;
        string gender;
        string alamat;
        string birthdate;
        address wallet;
    }

    event UserAdded(
        string name,
        string email,
        uint phone,
        string gender,
        string alamat,
        string birthdate,
        address wallet
    );

    User[] public users;

    function addUser(string memory _name, string memory _email, uint _phone, string memory _gender, string memory _alamat, string memory _birthdate) public {
        User memory newUser = User(_name, _email, _phone, _gender, _alamat, _birthdate, msg.sender);
        users.push(newUser);
        emit UserAdded(_name, _email, _phone, _gender, _alamat, _birthdate, msg.sender);
    }

    function getUserByWallet(address _wallet) public view returns (string memory, string memory, uint, string memory, string memory, string memory) {
        for (uint i = 0; i < users.length; i++) {
            if (users[i].wallet == _wallet) {
                return (users[i].name, users[i].email, users[i].phone, users[i].gender, users[i].alamat, users[i].birthdate);
            }
        }
        return ("", "", 0, "", "", "");
    }

    function getAllUsers() public view returns (User[] memory) {
        return users;
    }

    function updateUserByWallet(address _wallet, string memory _name, string memory _email, uint _phone, string memory _gender, string memory _alamat, string memory _birthdate) public {
        for (uint i = 0; i < users.length; i++) {
            if (users[i].wallet == _wallet) {
                users[i].name = _name;
                users[i].email = _email;
                users[i].phone = _phone;
                users[i].gender = _gender;
                users[i].alamat = _alamat;
                users[i].birthdate = _birthdate;
                break;
            }
        }
    }
}
