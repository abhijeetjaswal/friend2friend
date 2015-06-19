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

    uint nextFeeDue;
  }

  /* Pool setup */
  function Insurance(uint feeSet, uint feeIntervalSet, uint waitPeriodSet) {
    pool = 0;
    fee = feeSet;
    feeInterval = feeIntervalSet;
    waitPeriod = waitPeriodSet;
  }

  /* Join this pool. */
  function joinPool() {

    /* Check if this address is already a member and if the fee is correct. */
    if(memberExists() || msg.value != fee) return;

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

    if(memberExists() == false) return;

    member m = getMember();

    if(validMember(m) && msg.value == fee) {
      m.totalInput += msg.value;
      pool += msg.value;
      m.nextFeeDue = m.nextFeeDue + feeInterval;
    } else {
      return;
    }

  }

  function requestPayOut(uint amount) {

    if(memberExists() == false) return;

    member m = getMember(msg.sender);

    if(validMember(m)) {
      // Message all members for vote.
      // If vote is successful, payOut(msg.sender, amount)
    } else {
      return;
    }
  }

  /* Pay out to a member following group consent to request. */
  function payOut(address claimant, uint amount) {
    return;
  }

  /* ==== UTILS ==== */

  function validPayIn(member m) returns (bool) {

    if(validMember(m) && msg.value == fee) {
      return true;
    } else {
      return false;
    }
    
  }

  function validMember(member m) returns (bool) {

    if(m != 0 && m.nextFeeDue > block.timestamp) {
      return true; 
    } else {
      return false;
    }

  }

  function memberExists() returns (bool) {
    return members[msg.sender].addr == 0;
  }

  function getMember() returns (member) {
    return members[msg.sender]; 
  }

}
