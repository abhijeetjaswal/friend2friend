// TODO: Breakout util functions into seperate contract and inherit into main.

contract Insurance {
  
  address founder;
  uint ready;
  uint pool;        // Pool inputs minus pool outputs (how much cash is available).
  uint fee;         // The fee to be paid every feeInterval to maintain membership.
  uint feeInterval; // The frequency, in days, in which fees must be paid.
  uint waitPeriod;  /* The period, in days, for which new members must maintain
                       their membership before being able to make claims. */

  mapping(address => member) members;
  mapping(address => claim) pendingClaims;
  
  struct member {
    address addr;

    uint totalInput;
    uint totalBenefit;

    uint nextFeeDue;
  }

  struct claim {
    address addr;
    uint amount;
  }

  /* Pool setup */
  function Insurance() {
    founder = msg.sender;
    ready = 0;
  }

  function init(uint feeSet, uint feeIntervalSet, uint waitPeriodSet) {
    if(msg.sender != founder || ready == 1) return;

    pool = 0;
    fee = feeSet;
    feeInterval = feeIntervalSet;
    waitPeriod = waitPeriodSet;
    ready = 1;
  }

  /* Join this pool. */
  function joinPool() {

    /* Check if this address is already a member. */
    if(memberExists()) return;

    /* Initialize new member. */
    member m;
    m.addr = msg.sender;
    m.totalInput = 0;
    m.totalBenefit = 0;
    m.nextFeeDue = block.timestamp + feeInterval;

    /* Enroll new member. */
    members[msg.sender] = m;
  }

  /* Pay fees for this feeInterval. */
  function payIn() {

    member m = members[msg.sender];

    if(validMember() && msg.value == fee) {
      m.totalInput += msg.value;
      pool += msg.value;
      m.nextFeeDue = m.nextFeeDue + feeInterval;
    } else {
      return;
    }

  }

  function requestPayOut(uint amount) {

    member m = members[msg.sender];

    if(validMember()) {
      claim c;
      c.addr = members[msg.sender].addr;
      c.amount = amount;

      pendingClaims[msg.sender] = c;

    } else {
      return;
    }

  }

  function getClaim(address claimant) returns (uint) {
    return pendingClaims[claimant].amount;
  }

  /* Pay out to a member following group consent to request. */
  function payOut(uint amount) private {

    member m = members[msg.sender];

    pool -= amount;
    m.totalBenefit += amount;
    m.addr.send(amount);
    return;
  }

  /* ==== UTILS ==== */

  function validMember() private returns (bool) {
    member m = members[msg.sender];
    if(m.addr != 0 && m.nextFeeDue > block.timestamp) { return true; }
    else { return false; }
  }

  function memberExists() returns (bool) {
    return members[msg.sender].addr == 0;
  }

}
