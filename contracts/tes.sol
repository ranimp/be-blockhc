// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract UserData {
    enum Role {Pasien, Dokter, Admin}

    struct User {
        string nama;
        string email;
        string telepon;
        string gender;
        string alamat;
        string tanggalLahir;
        address wallet;
        bool status;
        string role;
    }

    mapping (address => User[]) public users;
    mapping(address => Role) public roles;

    // Default role untuk user baru
    string public defaultRole = "Pasien";

    // memberikan role
    function grantRoleAdmin(address _wallet, Role _role) public {
        require(roles[msg.sender] == Role.Admin, "Hanya admin yang dapat memberikan role");
        roles[_wallet] = _role;
    }
    
    // mencabut role
    function revokeRoleAdmin(address _wallet) public {
        require(roles[msg.sender] == Role.Admin, "Hanya admin yang dapat mencabut role");
        delete roles[_wallet];
    }

    // add user for pasien
    function addUserPasien(
        string memory _nama,
        string memory _email,
        string memory _telepon,
        string memory _gender,
        string memory _alamat,
        string memory _tanggalLahir,
        bool _status
    ) public {
        users[msg.sender].push(User(
            _nama,
            _email,
            _telepon,
            _gender,
            _alamat,
            _tanggalLahir,
            msg.sender,
            _status,
            defaultRole
        ));
    }

    // add user for admin
    function addUser(
        address _wallet,
        string memory _nama,
        string memory _email,
        string memory _telepon,
        string memory _gender,
        string memory _alamat,
        string memory _tanggalLahir,
        bool _status
    ) public {
        users[_wallet].push(User(
            _nama,
            _email,
            _telepon,
            _gender,
            _alamat,
            _tanggalLahir,
            msg.sender,
            _status,
            defaultRole
        ));
    }

    // update for admin
    function updateUser(
        address _wallet,
        string memory _nama,
        string memory _email,
        string memory _telepon,
        string memory _gender,
        string memory _alamat,
        string memory _tanggalLahir,
        bool _status
    ) public {
            users[_wallet].push(User(
            _nama,
            _email,
            _telepon,
            _gender,
            _alamat,
            _tanggalLahir,
            msg.sender,
            _status,
            defaultRole
        ));
    }

    // update for pasien
    function updateUserPasien(
        address _address,
        string memory _nama,
        string memory _email,
        string memory _telepon,
        string memory _gender,
        string memory _alamat,
        string memory _tanggalLahir,
        bool _status
    ) public {
            users[msg.sender].push(User(
            _nama,
            _email,
            _telepon,
            _gender,
            _alamat,
            _tanggalLahir,
            msg.sender,
            _status,
            defaultRole
        ));
    }

    // get for user
    function getUserByWallet(address _wallet) public view returns (User[] memory) {
        return users[_wallet];
    }

    // get for admin
function getAllUsers() public view returns (User[] memory) {
    uint256 count = 0;
    for (address wallet in userWallets) {
        count++;
    }

    User[] memory allUsers = new User[](count);
    uint256 index = 0;
    for (address wallet in userWallets) {
        allUsers[index] = users[wallet][0];
        index++;
    }

    return allUsers;
}

}


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract UserData {
    enum Role {Pasien, Dokter, Admin}

    struct User {
        string nama;
        string email;
        string telepon;
        string gender;
        string alamat;
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
        string alamat,
        string tanggalLahir,
        address wallet,
        bool status,
        string role
    );

    mapping (address => User[]) public users;
    mapping(address => Role) public roles;

    // Default role untuk user baru
    string public defaultRole = "Pasien";

    // memberikan role
    function grantRoleAdmin(address _wallet, Role _role) public {
        require(roles[msg.sender] == Role.Admin, "Hanya admin yang dapat memberikan role");
        roles[_wallet] = _role;
    }
    
    // mencabut role
    function revokeRoleAdmin(address _wallet) public {
        require(roles[msg.sender] == Role.Admin, "Hanya admin yang dapat mencabut role");
        delete roles[_wallet];
    }

    // add user for pasien
    function addUserPasien(
        string memory _nama,
        string memory _email,
        string memory _telepon,
        string memory _gender,
        string memory _alamat,
        string memory _tanggalLahir,
        bool _status
    ) public {
        User memory newUser = User(
            _nama,
            _email,
            _telepon,
            _gender,
            _alamat,
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
            _alamat,
            _tanggalLahir,
            msg.sender,
            _status
        );
    }

    // add user for admin
    function addUser(
        address _wallet,
        string memory _nama,
        string memory _email,
        string memory _telepon,
        string memory _gender,
        string memory _alamat,
        string memory _tanggalLahir,
        bool _status
    ) public {
        User memory newUser = User(
            _nama,
            _email,
            _telepon,
            _gender,
            _alamat,
            _tanggalLahir,
            _wallet,
            _status
        );
        users.push(newUser);
        emit UserAdded(
            _nama,
            _email,
            _telepon,
            _gender,
            _alamat,
            _tanggalLahir,
            _wallet,
            _status
        );
    }

    // update for admin
    function updateUser(
        address _wallet,
        string memory _nama,
        string memory _email,
        string memory _telepon,
        string memory _gender,
        string memory _alamat,
        string memory _tanggalLahir,
        bool _status
    ) public {
        for (uint256 i = 0; i < users.length; i++) {
            if (users[i].wallet == _wallet) {
                users[i].nama = _nama;
                users[i].email = _email;
                users[i].telepon = _telepon;
                users[i].gender = _gender;
                users[i].alamat = _alamat;
                users[i].tanggalLahir = _tanggalLahir;
                users[i].status = _status;
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
        string memory _alamat,
        string memory _tanggalLahir,
        bool _status
    ) public {
        for (uint256 i = 0; i < users.length; i++) {
            if (users[i].wallet == msg.sender) {
                users[i].nama = _nama;
                users[i].email = _email;
                users[i].telepon = _telepon;
                users[i].gender = _gender;
                users[i].alamat = _alamat;
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
            string memory,
            bool
        )
    {
        for (uint256 i = 0; i < users.length; i++) {
            if (users[i].wallet == _wallet) {
                return (
                    users[i].nama,
                    users[i].email,
                    users[i].telepon,
                    users[i].gender,
                    users[i].alamat,
                    users[i].tanggalLahir,
                    users[i].status
                );
            }
        }
        return ("", "", "", "", "", "", true);
    }

    // get for admin
    function getAllUsers() public view returns (User[] memory) {
        return users;
    }
}
