use cricket_analysis;
show tables;
select * from matches;
select count(id) from matches;

-- Using where command
-- This query calculates the total number of matches played by Sunrisers Hyderabad
-- by checking how many times they appear as either team1 or team2 in the matches table.
select count(*) as Total_matches_played
from matches
where team1 = "Sunrisers Hyderabad" or team2 = "Sunrisers Hyderabad";

-- Using ORDER BY command
-- This query returns the top 5 teams with the highest number of wins
SELECT winner, COUNT(*) AS total_wins
FROM matches
WHERE winner IS NOT NULL
GROUP BY winner
ORDER BY total_wins DESC
LIMIT 5;

-- Using GROUP BY command
-- Find how many matches were played in each city
SELECT city, COUNT(*) AS matches
FROM matches
GROUP BY city
ORDER BY matches DESC;

-- Using subquery command
-- Find the player who has won the most 'Player of the Match' awards
SELECT player_of_match, total_awards
FROM (
    SELECT player_of_match, COUNT(*) AS total_awards
    FROM matches
    GROUP BY player_of_match
) AS sub
ORDER BY total_awards DESC
LIMIT 1;

-- Using aggregate function(sum)
-- Shows teams with highest total run-margin wins
SELECT winner, SUM(win_by_runs) 
FROM matches 
WHERE win_by_runs > 0 
GROUP BY winner 
ORDER BY SUM(win_by_runs) DESC;

-- Using aggregate function(avg)
-- Shows average run-margin wins for each team
SELECT winner, AVG(win_by_runs) 
FROM matches 
WHERE win_by_runs > 0 
GROUP BY winner 
ORDER BY AVG(win_by_runs) DESC;

-- Create views for analysis
-- Create a view to show total wins by each team
CREATE VIEW team_total_wins AS
SELECT winner, COUNT(*) AS total_wins
FROM matches
WHERE winner IS NOT NULL
GROUP BY winner;
-- Use the view to get top 5 teams with most wins
SELECT * 
FROM team_total_wins 
ORDER BY total_wins DESC 
LIMIT 5;

-- Optimize queries with indexes
-- Create an index to speed up queries filtering or grouping by city
CREATE INDEX idx_city ON matches(city);
-- Find cities with the most IPL matches
SELECT city, COUNT(*) AS total_matches
FROM matches
WHERE city IS NOT NULL
GROUP BY city
ORDER BY total_matches DESC;

