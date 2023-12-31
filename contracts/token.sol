// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Token{
    string public name;
    string public symbol;
    uint8 public decimals=18;
    uint256 public totalSupply;

    mapping(address=>uint256) public balanceOf;
    // mapping(address=>mapping(address=>uint256)) public allowance;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner,address indexed spender,uint256 value);

    constructor(string memory _name,string memory _symbol,uint256 _totalSupply,address addr){
        name=_name;
        symbol=_symbol;
        totalSupply=_totalSupply*(10**decimals);
        balanceOf[addr]=totalSupply;
    }

    function _deposit(address sender, uint256 amount) public returns(bool){
        balanceOf[sender]+=amount;
        return true;
    }
    function _getBalance(address sender) public view returns(uint256){
        return balanceOf[sender];
    }
    function _withdraw(address sender, uint256 amount) public returns(bool){
        balanceOf[sender]-=amount;
        return true;
    }
    function _transfer(address _from, address _to, uint256 _value) public returns(bool){
        require(_to!=address(0),"Invalid address");
        require(balanceOf[_from]>=_value,"Insufficient balance");
        balanceOf[_from]-=_value;
        balanceOf[_to]+=_value;
        emit Transfer(_from,_to,_value);
        return true;
    }

    function transfer(address _to, uint256 _value) public returns(bool success){
        require(balanceOf[msg.sender]>=_value,"Insufficient balance");
       _transfer(msg.sender,_to,_value);
        return true;
    }

    function approve(address _spender, uint256 _value) public returns(bool success){
         require(_spender!=address(0),"Invalid address");
        //  allowance[msg.sender][_spender]=_value;
         emit Approval(msg.sender,_spender,_value);
         return true;
    }

  function transferFrom(address _from, address _to, uint _value) public returns (bool success){
     require(_value<=balanceOf[_from],"Insufficient balance");
    //  require(_value<=allowance[_from][msg.sender],"Insufficient allowance");
    //  allowance[_from][msg.sender]-=_value;
     _transfer(_from, _to, _value);
     return true;
  }

}