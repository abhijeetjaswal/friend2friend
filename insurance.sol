contract Insurance {
  
  mapping(address => member) members;
  uint pool;        // Pool inputs minus pool outputs (how much cash is available).
  uint fee;         // The fee to be paid every feeInterval to maintain membership.
  uint feeInterval; // The frequency, in days, in which fees must be paid.
  uint waitPeriod;  /* The period, in days, for which new members must maintain
                       their membership before being able to make claims. */

  struct member {
    address addr;
    uint timeIn;
    uint totalInput;
    uint totalBenefit;
  }

  function Insurance(uint fee, uint feeInterval, uint waitPeriod) {
    pool = 0;
    this.fee = fee;
    this.feeInterval = feeInterval;
    this.waitPeriod = waitPeriod;
  }

  function joinPool(uint amount, uint insureAgainst) {
    if(validMember(msg.sender) && insureAgainst <= 100) return;

    member m;
    m.addr = msg.sender;
    m.timeIn = 0;
    m.totalInput = amount;
    m.insureAgainst = insureAgainst;

    members[msg.sender] = m;
    pool += amount;
  }

  function payIn(uint amount) {

  }

  function payOut(address claimedBlock, address member) {

    //hashTail = 
     
    if(members[member.insureAgainst] == hashTail) {
      member.addr.send(pool);
    }
  }

  function validMember(address addr) {
    if(members[addr] != 0) { return true; }
    else return false;
  }

}
