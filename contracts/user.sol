// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract UserData {
    struct User {
        string nama;
        string email;
        string telepon;
        string gender;
        string tanggalLahir;
        address wallet;
        bool status;
        string role;
    }

    event UserAdded(
        string nama,
        string email,
        string telepon,
        string gender,
        string tanggalLahir,
        address wallet,
        bool status,
        string role
    );

    User[] public users;
    string public defaultRole = "Pasien";

    // add user for pasien
    function addUserPasien(
        string memory _nama,
        string memory _email,
        string memory _telepon,
        string memory _gender,
        string memory _tanggalLahir,
        bool _status
    ) public {
        User memory newUser = User(
            _nama,
            _email,
            _telepon,
            _gender,
            _tanggalLahir,
            msg.sender,
            _status,
            defaultRole
        );
        users.push(newUser);
        emit UserAdded(
            _nama,
            _email,
            _telepon,
            _gender,
            _tanggalLahir,
            msg.sender,
            _status,
            defaultRole
        );
    }

    // add user for admin
    function addUser(
        address _wallet,
        string memory _nama,
        string memory _email,
        string memory _telepon,
        string memory _gender,
        string memory _tanggalLahir,
        bool _status,
        string memory _role
    ) public {
        User memory newUser = User(
            _nama,
            _email,
            _telepon,
            _gender,
            _tanggalLahir,
            _wallet,
            _status,
            _role
        );
        users.push(newUser);
        emit UserAdded(
            _nama,
            _email,
            _telepon,
            _gender,
            _tanggalLahir,
            _wallet,
            _status,
            _role
        );
    }

    // update for admin
    function updateUser(
        address _wallet,
        string memory _nama,
        string memory _email,
        string memory _telepon,
        string memory _gender,
        string memory _tanggalLahir,
        bool _status,
        string memory _role
    ) public {
        for (uint256 i = 0; i < users.length; i++) {
            if (users[i].wallet == _wallet) {
                users[i].nama = _nama;
                users[i].email = _email;
                users[i].telepon = _telepon;
                users[i].gender = _gender;
                users[i].tanggalLahir = _tanggalLahir;
                users[i].status = _status;
                users[i].role = _role;
                break;
            }
        }
    }

    // update for pasien
    function updateUserPasien(
        string memory _nama,
        string memory _email,
        string memory _telepon,
        string memory _gender,
        string memory _tanggalLahir,
        bool _status
    ) public {
        for (uint256 i = 0; i < users.length; i++) {
            if (users[i].wallet == msg.sender) {
                users[i].nama = _nama;
                users[i].email = _email;
                users[i].telepon = _telepon;
                users[i].gender = _gender;
                users[i].tanggalLahir = _tanggalLahir;
                users[i].status = _status;
                break;
            }
        }
    }

    // get for user
    function getUserByWallet(address _wallet)
        public
        view
        returns (
            string memory,
            string memory,
            string memory,
            string memory,
            string memory,
            bool,
            string memory
        )
    {
        for (uint256 i = 0; i < users.length; i++) {
            if (users[i].wallet == _wallet) {
                return (
                    users[i].nama,
                    users[i].email,
                    users[i].telepon,
                    users[i].gender,
                    users[i].tanggalLahir,
                    users[i].status,
                    users[i].role
                );
            }
        }
        return ("", "", "", "", "", true, "");
    }

    // get for admin
    function getAllUsers() public view returns (User[] memory) {
        return users;
    }
}
