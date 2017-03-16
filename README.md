#Prisoner's Dilemma contest winner
*My 1st place Prisoner's Dilemma strategy (Apr 18, 2008).*

----------

I wrote this Perl app as part of a graded class project. It competed against the entire collection of Prisoner's Dilemma strategies submitted by students of CIT145 from the previous 10 years. This included several different strategies written by the instructor.

The final scores were calculated as a running total that accumulated by running all strategies against one another for several hundred rounds each. My strategy completed as the first place winner with the lowest final score (or years in prison).

----------

**My Strategy**
--------------------

----------

 - Copy Cat and Near Copy Cat detection
 - Hold if pure Copy Cat is detected. Mostly Hold if Near Copy Cat is detected
 - When in doubt, Testify
 - Add some randomness

----------

I played around by running different simple strategies against one another and determined that its usually best to always Testify unless there is a Copy Cat. If there was a Copy Cat then the best move was to always Hold.

Another thing that I noticed is that certain strategies could become locked into a repeating pattern with each other. In order to break these cycles, I introduced just a little bit of randomness.

----------

**Copy Cat detection**

In order to detect a Copy Cat, a series of my moves could not be based upon the other player's choice. I decided to embed a short preamble that I could use to detect if it was being played back to me by a Copy Cat.

If my formula learned that the other player was a Copy Cat then it would begin to play Hold for the next moves. It would continue to monitor for any deviations from a pure Copy Cat.
