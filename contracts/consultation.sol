// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;


//define the contract
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

    address[] akunKonsultasi;

    mapping(address => Data) dataKonsultasi;

    
    function tambahData(
        address _akun,
        string memory _name,
        string memory _phone,
        string memory _doctorName,
        string memory _session,
        string memory _date,
        string memory _gender,
        string memory _symptom,
        address _wallet) public {
        dataKonsultasi[_akun] = Data(
            _name, 
            _phone, 
            _doctorName, 
            _session, 
            _date, 
            _gender, 
            _symptom, 
            _wallet
            );
        akunKonsultasi.push(_akun);
    }

    function ambilDataPasien(address _akun) public view returns (string memory, string memory, string memory) {
        return (
            dataKonsultasi[_akun].name, 
            dataKonsultasi[_akun].phone, 
            dataKonsultasi[_akun].gender
        );
    }


    function ambilDataKonsultasi(address _akun) public view returns (string memory, string memory, string memory, string memory, address) {
        return (
            dataKonsultasi[_akun].doctorName, 
            dataKonsultasi[_akun].session, 
            dataKonsultasi[_akun].date, 
            dataKonsultasi[_akun].symptom, 
            dataKonsultasi[_akun].wallet
        );
    }

   function ambilSemuaDataKonsultasi(uint _offset, uint _jumlah) public view returns (Data[] memory) {
        require(_offset + _jumlah <= akunKonsultasi.length, "Jumlah data yang ingin diambil melebihi jumlah total data yang tersedia");
        Data[] memory data = new Data[](_jumlah);
        uint i = 0;
        for (uint j = _offset; j < _offset + _jumlah; j++) {
            address akun = akunKonsultasi[j];
            data[i] = dataKonsultasi[akun];
            i++;
        }
        return data;
    }
}
