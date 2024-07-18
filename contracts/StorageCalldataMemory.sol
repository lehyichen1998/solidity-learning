// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract StorageCalldataMemory {
    string public name;
    string public name2;
    uint8 public age;

    struct Employee {
        string name;
        uint8 age;
    }

    Employee[] public employees;

    mapping (address=>Employee[]) public  employeeMapping;

    function setAge(uint8 _age) public {
        age = _age;
    }

    function setNameWithMemory(string memory _name) public {
        // _name ="World";
        name = _name;
    }

    function setNameWithCalldata(string calldata _name) public {
        name = _name;
    }

    function getName() public view returns (string memory) {
        return name;
    }

    function setNameWithStorage() public {
        string storage name3 = name;
        name2 = name3;
    }

    function setEmployee(Employee calldata _employee) public {
        employees.push(_employee);
    }

    function updateEmployeeName(string calldata _name, uint256 _index) public {
        Employee storage updateEmployee = employees[_index];
        updateEmployee.name = _name;
    }

    function getEmployeeName(uint8 _index) public view returns (Employee memory) {
        return employees[_index];
    }

    function setEmployeeMapping(address _address,Employee calldata _employee) public {
        employeeMapping[_address].push(_employee);
    }

    function updateEmployeeMappingName(address _address,string calldata _name, uint8 _index) public {
        Employee storage updateEmployee = employeeMapping[_address][_index];
        updateEmployee.name = _name;
    }

    function getEmployeeMapping(address _address,uint8 _index) public view returns (Employee memory) {
        return employeeMapping[_address][_index];
    }

     function getAllEmployeeMapping(address _address) public view returns (Employee[] memory) {
        return employeeMapping[_address];
    }
}
