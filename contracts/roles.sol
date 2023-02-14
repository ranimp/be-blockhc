// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract UserRoles {
    address public admin;
    mapping(address => bool) public dokter;
    mapping(address => bool) public pasien;

    constructor() {
        admin = 0x7c73d9eD23DDAd6353034F371aCa808b8a58744E;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Hanya admin yang diizinkan untuk mengkases.");
        _;
    }

    function setRole(address _wallet, string memory _role) public onlyAdmin {
        if (keccak256(bytes(_role)) == keccak256(bytes("dokter"))) {
            dokter[_wallet] = true;
        } else if (keccak256(bytes(_role)) == keccak256(bytes("pasien"))) {
            pasien[_wallet] = true;
        }
    }
    
    function setDefaultRole() public {
        pasien[msg.sender] = true;
    }

    function removeRole(address _wallet, string memory _role) public onlyAdmin {
        if (keccak256(bytes(_role)) == keccak256(bytes("dokter"))) {
            dokter[_wallet] = false;
        } else if (keccak256(bytes(_role)) == keccak256(bytes("pasien"))) {
            pasien[_wallet] = false;
        }
    }

    function isAdmin(address _wallet) public view returns (bool) {
        return admin == _wallet;
    }

    function isDokter(address _wallet) public view returns (bool) {
        return dokter[_wallet];
    }

    function isPasien(address _wallet) public view returns (bool) {
        return pasien[_wallet];
    }
}