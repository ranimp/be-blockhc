// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Consultation {
    struct Data {
        string name;
        string phone;
        string doctorName;
        string session;
        string date;
        string symptom;
        string gender;
        address wallet;
    }

    mapping(address => Data[]) public consultations;
    address[] public accountsWithConsultations;
    uint public consultationCount;

    function addConsultation(string memory _name, string memory _phone, string memory _doctorName, string memory _session, string memory _date, string memory _symptom, string memory _gender) public {
        consultations[msg.sender].push(Data(_name, _phone, _doctorName, _session, _date, _symptom, _gender, msg.sender));
        accountsWithConsultations.push(msg.sender);
        consultationCount++;
    }

    function getConsultations() public view returns (Data[] memory) {
        return consultations[msg.sender];
    }

    function updateConsultation(uint _index, string memory _name, string memory _phone, string memory _doctorName, string memory _session, string memory _date, string memory _symptom, string memory _gender) public {
        require(_index < consultationCount, "Consultation data not found");
        require(msg.sender == consultations[msg.sender][_index].wallet, "You are not the owner of the consultation data");
        consultations[msg.sender][_index] = Data(_name, _phone, _doctorName, _session, _date, _symptom, _gender, msg.sender);
    }

    function updateConsultationAdmin(address _wallet, uint _index, string memory _name, string memory _phone, string memory _doctorName, string memory _session, string memory _date, string memory _symptom, string memory _gender) public {
        require(_index < consultationCount, "Consultation data not found");
        consultations[_wallet][_index] = Data(_name, _phone, _doctorName, _session, _date, _symptom, _gender, _wallet);
    }

    function getAllConsultationsAdmin(uint offset) public view returns (Data[] memory) {
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
