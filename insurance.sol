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
  function Insurance(uint fee, uint feeInterval, uint waitPeriod) {
    pool = 0;
    this.fee = fee;
    this.feeInterval = feeInterval;
    this.waitPeriod = waitPeriod;
  }

  /* Join this pool. */
  function joinPool() {

    /* Check if this address is already a member and if the fee is correct. */
    if(isMember(msg.sender) || msg.value != fee) return;

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
    if(isMember(msg.sender) == false) return;

    member m = getMember(msg.sender);

    if(validMember(m) && msg.value == fee) {
      m.totalInput += msg.value;
      pool += msg.value;
      m.nextFeeDue = m.nextFeeDue + feeInterval;
    } else {
      return;
    }

  }

  /* If totalInput is 0, the user isn't active yet. */
  function validPayIn(member m) {

    /* Check that the member is valid, the submitted value matches the required
       fee and that payIn is neither too soon, nor too late. */
    if(validMember(m) && msg.value == fee && block.timestamp < m.nextFeeDue) {
      return true;
    } else {
      return false;
    }
    
  }

  /* Pay out to a member following group consent to request. */
  function payOut(address claimant) {
    return;
  }

  function isMember(address addr) {
    if(members[addr] != 0) { return true; }
    else return false;
  }

  /* THIS IS INCOMPLETE */
  function validMember(member m) {
    if(m.nextFeeDue > block.timestamp) {
      return false; 
    } else {
      return true;
    }
  }

  function getMember(address addr) {
    return members[addr]; 
  }

}
