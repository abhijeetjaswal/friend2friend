Model:

* The pool creator specifies a `fee`, `feeInterval` and `waitPeriod`. So anybody
who joins might owe $50 once a month, or $20 every two weeks, or whatever. The
`waitPeriod` specifies how many `feeInterval`s a new member must make dues for
before they can make claims.

* If a user wants to leave the pool, they can do that at any time. Their total
ether input to-date is returned, minus any ether they took out. If a user lapses
on their fees, this happens automatically.

* To make a claim, a user submits a description of their tragedy and how much
ether they need to recover. The rest of the pool votes on whether to disburse
the funds (simple majority rules).

This doesn’t scale past a relatively small group of friends, maybe a
neighborhood at max, but I think it could actually be quite cool for either of
those demographics.
