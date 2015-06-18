contract Insurance {
  
  mapping(address => member) members;
  uint pool;        // Pool inputs minus pool outputs (how much cash is available).
  uint fee;         // The fee to be paid every feeInterval to maintain membership.
  uint feeInterval; // The frequency, in days, in which fees must be paid.
  uint waitPeriod;  /* The period, in days, for which new members must maintain
                       their membership before being able to make claims. */

  struct member {
    address addr;

    uint totalInput;
    uint totalBenefit;

    uint joinDate;
    uint lastPayIn;
  }

  function Insurance(uint fee, uint feeInterval, uint waitPeriod) {
    pool = 0;
    this.fee = fee;
    this.feeInterval = feeInterval;
    this.waitPeriod = waitPeriod;
  }

  function joinPool() {
    if(isMember(msg.sender)) return; // This address is already a member.

    member m;
    m.addr = msg.sender;
    m.totalInput = 0;
    m.totalBenefit = 0;
    m.joinDate = block.timestamp;
    m.lastPayIn = 0;

    members[msg.sender] = m;
  }

  function payIn(uint amount) {
    if(isMember(msg.sender) == false) return;

    member m = getMember(msg.sender);

    if 

  }

  function payOut(address claimedBlock, address member) {

    //hashTail = 
     
    if(members[member.insureAgainst] == hashTail) {
      member.addr.send(pool);
    }
  }

  function isMember(address addr) {
    if(members[addr] != 0) { return true; }
    else return false;
  }

  function validMember(member m) {
    uint daysSinceLastPayIn = block.timestamp - m.lastPayIn;
    if(daysSinceLastPayIn > feeInterval); 
  }

  function getMember(address addr) {
    return members[addr]; 
  }

}
