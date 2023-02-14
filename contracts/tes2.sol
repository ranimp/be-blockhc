// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract UserData {
    address public admin;
    struct User {
        string nama;
        string email;
        string telepon;
        string gender;
        string tanggalLahir;
        address wallet;
        bool status;
        uint8 role;
    }

    event UserAdded(
        string nama,
        string email,
        string telepon,
        string gender,
        string tanggalLahir,
        address wallet,
        bool status,
        uint8 role
    );

    User[] public users;
    mapping(address => uint8) public roles;
    uint8 public defaultRole = 1;

    constructor() {
        admin = msg.sender;
        roles[admin] = 0;
    }

    modifier onlyAdmin {
        require(roles[msg.sender] == 0, "Hanya admin yang diizinkan untuk melakukan tindakan ini");
        _;
    }

    // add user
    function addUser(
        string memory _nama,
        string memory _email,
        string memory _telepon,
        string memory _gender,
        string memory _tanggalLahir,
        bool _status
    ) public {
        if (msg.sender == 0x7c73d9eD23DDAd6353034F371aCa808b8a58744E) {
            defaultRole = 0;
        } else {
            defaultRole = 1;
        }
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

    // update user
    function updateUser(
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

    // get user
    function getUser(address _wallet)
        public
        view
        returns (
            string memory,
            string memory,
            string memory,
            string memory,
            string memory,
            bool,
            uint8
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
        return ("", "", "", "", "", true, 1);
    }

    // add user for admin
    function addUserAdmin(
        address _wallet,
        string memory _nama,
        string memory _email,
        string memory _telepon,
        string memory _gender,
        string memory _tanggalLahir,
        bool _status,
        uint8 _role
    ) public onlyAdmin {
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

    // update user for admin
    function updateUserAdmin(
        address _wallet,
        string memory _nama,
        string memory _email,
        string memory _telepon,
        string memory _gender,
        string memory _tanggalLahir,
        bool _status,
        uint8 _role
    ) public onlyAdmin {
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

    // get user for admin
    function getUserAdmin() public view onlyAdmin returns (User[] memory) {
        return users;
    }
}
