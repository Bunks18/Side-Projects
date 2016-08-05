# As usual, hflights is pre-loaded as a tbl, together with the necessary libraries.

# Print out a tbl containing just ArrDelay and DepDelay
select(hflights, ends_with("Delay"))

# Print out a tbl as described in the second instruction, using both helper functions and variable names
select(hflights, UniqueCarrier, ends_with("Num"), starts_with("Cancel"))

# Print out tbl as described in the third instruction, using only helper functions.
select(hflights, contains("Tim"), contains("Del"))

select(hflights, starts_with('A'), starts_with('D'))