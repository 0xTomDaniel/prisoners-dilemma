# Prisoner's Dilemma contest winner
*My 1st place Prisoner's Dilemma strategy (Apr 18, 2008).*

---

I wrote this Perl app as part of a graded class project. It competed against the entire collection of Prisoner's Dilemma strategies submitted by students of CIT145 from the previous 10 years. This included several different strategies written by the instructor.

The final scores were calculated as a running total that accumulated by running all strategies against one another for several hundred rounds each. My strategy completed as the first-place winner with the lowest final score (or years in prison).

*Note: I was very new to programming, so this code is not very elegant.*

---

## My Strategy

 - Copy Cat and Near Copy Cat detection
 - Hold if pure Copy Cat is detected. Mostly Hold if Near Copy Cat is detected
 - Crude machine learning
 - When in doubt, Testify
 - Add some randomness

I played around by running different simple strategies against one another and determined that it was usually best to always Testify unless there was a Copy Cat. If there was a Copy Cat then the best move was to always Hold.

### Copy Cat detection

In order to detect a Copy Cat, a series of my moves could not be based upon the other player's choice. I decided to embed a short preamble that I could use to detect if it was being played back to me by a Copy Cat.

If my formula learned that the other player was a Copy Cat then it would begin to play Hold for the next moves. It would continue to monitor for any deviations from a pure Copy Cat.

### Machine learning

When I created this program, I had zero knowledge of machine learning nor evolution for that matter. It was only recently that I realized what I had implemented here was very rudimentary machine learning.

Copy Cat probability was the single feature used based on the the opponents play history. This was calculated from the percentage of moves played by the opponent that were a copy of my previous move. If a particular threshold was crossed that indicated that the other strategy was mostly a Copy Cat, then I would choose to Hold. Otherwise I would Testify. The major problem now was choosing the correct threshold.

In order to choose the correct threshold, I needed to get some feedback on different threshold options. So I created another program that would run my strategy against a variety of other common strategies for thousands of iterations, changing the threshold randomly after an 'epoch' and comparing the results to the new 'epoch'. I left this running over night and discovered the 'goldilocks zone' for threshold options.

At this point I further tuned the threshold starting from the lower end of the 'goldilocks zone' and slowly increasing it until my strategy wouldn't produce a better result. I found the best threshold to be 88% probability of a Copy Cat when I chose to always Hold above the threshold.

### Randomness

The main reason that I decided to invoke randomness was to throw off any other strategies that were trying to predict my moves. Thinking back, I believe I manually tested different values until I was comfortable with the results. Unfortunately, it has been too long to remember the exact details.
