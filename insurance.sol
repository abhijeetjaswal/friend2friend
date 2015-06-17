contract Insurance {
  
  struct member {
    address addr;
    uint timeIn;
    uint totalInput;
    uint insureAgainst;
  }

  mapping(address => member) members;
  uint pool;

  function Insurance() {
    pool = 0;
  }

  function joinPool(uint amount, uint insureAgainst) {
    if(members[msg.sender] != 0 || insureAgainst > 100) return;

    member m;
    m.addr = msg.sender;
    m.timeIn = 0;
    m.totalInput = amount;
    m.insureAgainst = insureAgainst;

    members[msg.sender] = m;
    pool += amount;
  }

  function payOut(address claimedBlock, address member) {
    if(members[member.insureAgainst] == hashTail) {
      member.send(pool);
    }
  }

}
