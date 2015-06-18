// TODO: Breakout util functions into seperate contract and inherit into main.

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

  /* Pool setup */
  function Insurance(uint fee, uint feeInterval, uint waitPeriod) {
    pool = 0;
    this.fee = fee;
    this.feeInterval = feeInterval;
    this.waitPeriod = waitPeriod;
  }

  /* Join this pool. First payIn happens seperately/later. */
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

  /* Pay fees for this feeInterval. */
  function payIn() {
    if(isMember(msg.sender) == false) return;

    member m = getMember(msg.sender);

    /* Check if msg.value == fee */
    if(validMember(m)) {
      m.totalInput += msg.value;
      pool += msg.value;
    } else {
      return;
    }

  }

  /* Pay out to a member following group consent to request. */
  function payOut(address claimedBlock, address member) {

    if(members[member.insureAgainst] == hashTail) {
      member.addr.send(pool);
    }
  }

  function isMember(address addr) {
    if(members[addr] != 0) { return true; }
    else return false;
  }

  /* THIS IS INCOMPLETE */
  function validMember(member m) {
    uint daysSinceLastPayIn = block.timestamp - m.lastPayIn;
    if(daysSinceLastPayIn > feeInterval); 
  }

  function getMember(address addr) {
    return members[addr]; 
  }

}
