// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

contract Consultation {
    // Data structure
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

    // Mapping to store data
    mapping(address => Data[]) public consultations;
    // Array to store address of all accounts with consultations
    address[] public accountsWithConsultations;
    // Variable to keep count of total consultations
    uint public consultationCount;

    // Function to add consultation data
    function addConsultation(string memory _name, string memory _phone, string memory _doctorName, string memory _session, string memory _date, string memory _symptom, string memory _gender) public {
        // Add data to mapping
        consultations[msg.sender].push(Data(_name, _phone, _doctorName, _session, _date, _symptom, _gender, msg.sender));
        // Add address to array
        accountsWithConsultations.push(msg.sender);
        // Increase consultation count
        consultationCount++;
    }

    // Function to get consultation data
    function getConsultations() public view returns (Data[] memory) {
        // Return data from mapping
        return consultations[msg.sender];
    }

    // Function to update consultation data
    function updateConsultation(uint _index, string memory _name, string memory _phone, string memory _doctorName, string memory _session, string memory _date, string memory _symptom, string memory _gender) public {
        // Check if consultation data exists
        require(_index < consultationCount, "Consultation data not found");
         // Check if the sender is the owner of the consultation data
        require(msg.sender == consultations[msg.sender][_index].wallet, "You are not the owner of the consultation data");
        // Update consultation data
        consultations[msg.sender][_index] = Data(_name, _phone, _doctorName, _session, _date, _symptom, _gender, msg.sender);
    }

    // Function to get consultation data for all accounts
    function getAllConsultations(uint offset) public view returns (Data[] memory) {
        uint maxConsultationsPerAccount = 10;
        // Array to store all consultation data
        Data[] memory allConsultations = new Data[](10 * maxConsultationsPerAccount);
        // Counter to keep track of data stored in allConsultations array
        uint counter = 0;
        // Iterate through accountsWithConsultations array
        for (uint i = offset; i < accountsWithConsultations.length; i++) {
            // Get data for current account
            Data[] memory data = consultations[accountsWithConsultations[i]];
            // Copy all data from current account to allConsultations array
            for (uint j = 0; j < data.length && counter < maxConsultationsPerAccount * 10; j++) {
                allConsultations[counter] = data[j];
                counter++;
            }
        }
        // Return all consultation data from 10 accounts
        return allConsultations;
    }
 
}
