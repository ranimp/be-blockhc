// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract ConsultationResult {
    enum Role {Pasien, Dokter, Admin}

    struct Data {
        string nama;
        string namaDokter;
        string tanggal;
        string keluhan;
        string diagnosa;
        string tensi;
        string gula;
        address wallet;
    }

    mapping(address => Data[]) public consultations;
    address[] public accountsWithConsultations;
    uint public consultationCount;
    mapping(address => Role) public roles;

    constructor() {
        roles[msg.sender] = Role.Admin;
    }

    modifier onlyAdmin {
        require(roles[msg.sender] == Role.Admin, "Hanya admin yang diizinkan untuk melakukan tindakan ini");
    _;
    }

    modifier onlyAdminOrDokter {
        require(roles[msg.sender] == Role.Admin || roles[msg.sender] == Role.Dokter, "Hanya admin dan dokter yang diizinkan untuk melakukan tindakan ini");
    _;
    }

    // tambah konsultasi untuk admin & dokter
    function addConsultation(
        address _wallet, 
        string memory _nama, 
        string memory _namaDokter, 
        string memory _tanggal, 
        string memory _keluhan, 
        string memory _diagnosa, 
        string memory _tensi, 
        string memory _gula) public onlyAdminOrDokter {
        consultations[_wallet].push(Data(_nama, _namaDokter, _tanggal, _keluhan, _diagnosa, _tensi, _gula, _wallet));
        accountsWithConsultations.push(_wallet);
        consultationCount++;
    }

    // update konsultasi untuk admin & dokter
    function updateConsultation(
        address _wallet, 
        uint _index, 
        string memory _nama, 
        string memory _namaDokter, 
        string memory _tanggal, 
        string memory _keluhan, 
        string memory _diagnosa, 
        string memory _tensi, 
        string memory _gula) public onlyAdminOrDokter {
        require(_index < consultationCount, "Consultation data not found");
        consultations[_wallet][_index] = Data(_nama, _namaDokter, _tanggal, _keluhan, _diagnosa, _tensi, _gula, _wallet);
    }

    // get konsultasi untuk pasien
    function getConsultationsPasien() public view returns (Data[] memory) {
        return consultations[msg.sender];
    }

    // get semua data konsultasi untuk admin
    function getAllConsultations(uint offset) public view onlyAdmin returns (Data[] memory) {
        uint maxConsultationsPerAccount = 10;
        Data[] memory allConsultations = new Data[](10 * maxConsultationsPerAccount);
        uint counter = 0;
        for (uint i = offset; i < accountsWithConsultations.length; i++) {
            Data[] memory data = consultations[accountsWithConsultations[i]];
            for (uint j = 0; j < data.length && counter < maxConsultationsPerAccount * 10; j++) {
                allConsultations[counter] = data[j];
                counter++;
            }
        }
        return allConsultations;
    }
}
