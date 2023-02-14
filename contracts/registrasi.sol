// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "./roles.sol";

contract ConsultationRegist {
    UserRoles public roles;

    struct Data {
        string nama;
        string telepon;
        string namaDokter;
        string sesi;
        string tanggal;
        string keluhan;
        string gender;
        address wallet;
    }
    
    mapping(address => Data[]) public registrations;
    address[] public accountsWithRegistrations;
    uint public registrationCount;

    constructor(address _rolesContractAddress) {
        roles = UserRoles(_rolesContractAddress);
    }

    modifier onlyPasien() {
        require(roles.isPasien(msg.sender), "Hanya pasien yang diizinkan untuk mengakses");
        _;
    }

    modifier onlyAdminOrDokter() {
        require(roles.isAdmin(msg.sender) || roles.isDokter(msg.sender), "Hanya admin atau dokter yang diizinkan untuk mengakses.");
        _;
    }

    // tambah pendaftaran untuk pasien
    function addRegistration(
        address _wallet, 
        string memory _nama, 
        string memory _telepon, 
        string memory _namaDokter, 
        string memory _sesi, 
        string memory _tanggal, 
        string memory _keluhan, 
        string memory _gender) public {
        registrations[_wallet].push(Data(_nama, _telepon, _namaDokter, _sesi, _tanggal, _keluhan, _gender, _wallet));
        accountsWithRegistrations.push(_wallet);
        registrationCount++;
    }
    
    // get bukti pendaftaran pasien
    function getRegistrationEvidence() public view onlyPasien returns (Data[] memory) {
        return registrations[msg.sender];
    }

    // get data pendaftaran untuk admin & dokter
    function getAllRegistrations(uint offset) public view onlyAdminOrDokter returns (Data[] memory) {
        uint maxRegistrationsPerAccount = 10;
        Data[] memory allRegistrations = new Data[](10 * maxRegistrationsPerAccount);
        uint counter = 0;
        for (uint i = offset; i < accountsWithRegistrations.length; i++) {
            Data[] memory data = registrations[accountsWithRegistrations[i]];
            for (uint j = 0; j < data.length && counter < maxRegistrationsPerAccount * 10; j++) {
                allRegistrations[counter] = data[j];
                counter++;
            }
        }
        return allRegistrations;
    }
}
