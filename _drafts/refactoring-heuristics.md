# Refactoring heuristics

## Write first, categorize later ;-)

- Listen to the code
(https://ronjeffries.com/articles/020-dung/-w021ff/d-217/) 
- Make similar code more similar, then remove duplication
  (https://ronjeffries.com/articles/020-dung/-w021ff/d-217/) Ron heeft het geleerd van Kent, ik heb het geleerd van Rob.
- Spot patterns in names
(https://ronjeffries.com/articles/020-dung/-w021ff/d-217/)
  "Those tables happened to be named according to a pattern, by the name of the callback that needed them, which was, in turn, the name of a from or to of some transition."

- re-review / re-read the code a month after shipping Code looks different out
 of the rush of making it, and after having forgotten some of the details. (see
 glanceable tests post for an example). (for the 25th anniversary of
 cyberchair - fixing a bug after a year, it could have been someone else).

-- misc posts:
- Singletons have their place, very rarely
