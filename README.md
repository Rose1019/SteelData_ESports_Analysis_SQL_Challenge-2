# SteelData_ESports_Analysis_SQL_Challenge-2

### Introduction
The top eSports competitors from across the globe have gathered to battle it out
Can you analyse the following data to find out all about the tournament?

Sharing the link to [SteelData-SQL Challenge 2](https://www.steeldata.org.uk/sql2.html)

---------------------------------------------------------------------------------------------------------

# Table Details

| Table Name | Column Name |
| ---------- | ----------- |
| Teams | Team_id,team_name,country,captain_id |
| matches | Match_id,team1_id,team2_id,match_date,winner_id,score_team1,score_team2 |
| players | Player_id,player_name,team_id,role,salary |

-------------------------------------------------------------------------------------------------------------

## Code

*1. What are the names of the players whose salary is greater than 100,000?*

``` js
select player_name,salary
from players
where salary >100000;
``` 

```
                                 Output
Retrieve analytical data presenting the names of players alongside their corresponding salaries for the year 2022.

                              Concepts learned
1.COMPARISON OPERATOR
```
-----------------------------------------------------------------------------------------------------

*2. What is the team name of the player with player_id = 3?*

``` js
select t.team_name,p.player_name
from teams t 
join players p 
using(t_id)
where p.player_id=3;
``` 

```
                                 Output

In the analytical dataset, the player with player_id = 3 is affiliated with the team named SK Telecom T1.

                              Concepts learned
1.JOIN
2.USING()
```
-----------------------------------------------------------------------------------------------------

*3. What is the total number of players in each team?*

``` js
select t.t_id,t.team_name as Team_Name,count(p.player_name) as Player_name
from players p 
join teams t 
using(t_id)
group by t.t_id,t.team_name;
``` 

```
                                 Output


Analytically, each team is comprised of a total of 3 players.

                              Concepts learned
1.JOIN
2.USING()
3.GROUP BY
```
-----------------------------------------------------------------------------------------------------

*4. What is the team name and captain name of the team with team_id = 2?*

``` js
select team_name,captain_id
from teams
where t_id=2;

/*STORED PROCEDURE, to get report team names and correpsonding captain ID for any team ID
input is TEAM ID*/
/*CREATE DEFINER=`root`@`localhost` PROCEDURE `report_team name_captainid_any_teamid`(
				IN in_teamID int
)
BEGIN
select team_name,captain_id
from teams
where t_id=in_teamID;
END*/
``` 

```
                                 Output

Analytically, for the team with team_id = 2, the team name is Fnatic, and the captain's id is 2.

                              Concepts learned
1.STORED PROCEDURE, to get a report on team names and correpsonding captain ID for any given team ID
```
-----------------------------------------------------------------------------------------------------

*5. What are the player names and their roles in the team with team_id = 1?*

``` js
select player_name,role
from players
where t_id=1;

/*STORED PROCEDURE to get the report on the player names and respective roles for a given TEAM ID*/
/*
CREATE DEFINER=`root`@`localhost` PROCEDURE `report_on_playernames_roles_for_any_teamid`(
			IN in_teamID int
)
BEGIN
select player_name,role
from players
where t_id=in_teamID;
END
*/
``` 

```
                                 Output


Analytically, each team is comprised of a total of 3 players.

                              Concepts learned
1.STORED PROCEDURE to get a report on the player names and respective roles for a given TEAM ID
```
-----------------------------------------------------------------------------------------------------

*6. What are the team names and the number of matches they have won?*

``` js
select t.t_id,t.team_name,t.country,count(m.winner_id) as Number_of_matches_won
from teams t 
join matches m 
on t.t_id=m.winner_id
group by m.winner_id;

/*STORED PROCEDURE to get a report on number of matches WON by giving team id as input*/
/*
CREATE DEFINER=`root`@`localhost` PROCEDURE `report_on_number_matches_won_any_team id`(
			IN in_teamID int
)
BEGIN
select t.t_id,t.team_name,t.country,count(m.winner_id) as Number_of_matches_won
from teams t 
join matches m 
on t.t_id=m.winner_id
where t.t_id=in_teamID
group by m.winner_id;
END
*/
``` 

```
                                 Output


Analytically, each team is comprised of a total of 3 players.

                              Concepts learned
1.STORED PROCEDURE to get a report on number of matches WON by giving team id as input
```
-----------------------------------------------------------------------------------------------------

*7. What is the average salary of players in the teams with country 'USA'?*

``` js
select round(avg(p.salary),1) as Average_Salary_Players,t.country
from players p 
join teams t 
using(t_id)
where t.country='USA';

/*STORED PROCEDURE to get a report on AVERAGE salary with any country and team ID*/
/*
CREATE DEFINER=`root`@`localhost` PROCEDURE `report_avg_salary_any_country`(
			
            IN in_country varchar(50)
)
BEGIN
select round(avg(p.salary),1) as Average_Salary_Players,t.country
from players p 
join teams t 
using(t_id)
where t.country=in_country
group by t.country;
END
*/
``` 

```
                                 Output

In the analytical context, the average salary of players within teams associated with the country 'USA' is $97,166.7.

                              Concepts learned
1.STORED PROCEDURE to get a report on AVERAGE salary with any country and team ID
```
-----------------------------------------------------------------------------------------------------

*8. Which team won the most matches?*

``` js
select t.t_id,t.team_name,count(m.winner_id) as Number_of_matches_Won
from matches m
join teams t 
on t.t_id=m.winner_id
group by m.winner_id
order by Number_of_matches_Won DESC
limit 1;

/*STORED PROCEDURE to get a report to get the number of matches won by entering any TEAM ID*/
/*
CREATE DEFINER=`root`@`localhost` PROCEDURE `report_to_get_number_matches_won_by_teamid`(
			IN in_teamID int
)
BEGIN
select t.t_id,t.team_name,count(m.winner_id) as Number_of_matches_Won_by_the_team
from matches m
join teams t 
on t.t_id=m.winner_id
where t.t_id=in_teamID
group by m.winner_id;
END
*/
``` 

```
                                 Output

In the analytical data, SK Telecom T1, identified by team ID 3, has secured the highest number of victories, prevailing in 4 matches.

                              Concepts learned
1.STORED PROCEDURE to get a report to get the number of matches won by entering any TEAM ID
```
-----------------------------------------------------------------------------------------------------

*9. What are the team names and the number of players in each team whose salary is greater than 100,000?*

``` js
select t.t_id,t.team_name,count(p.player_id) as number_of_player
from players p 
join teams t 
using(t_id)
where p.salary >100000
group by t.t_id,t.team_name;
``` 

```
                                 Output

In the analytical dataset, there exist four teams where the salary of players exceeds $100,000.
The corresponding query retrieves the number of players for each of these teams.

                              Concepts learned
1.JOIN
2.USING()
3.COMPARISON OPERTAOR
4.GROUP BY
```
-----------------------------------------------------------------------------------------------------

*10. What is the date and the score of the match with match_id = 3?*

``` js
select match_date,score_team1,score_team2
from matches
where m_id=3;

/*STORED PROCEDURE to get a report on the WINNERS of each match by matchID */
/* 
CREATE DEFINER=`root`@`localhost` PROCEDURE `report_on_winners_of_each_match_by_matchid`(
				IN in_matchID int
)
BEGIN
SELECT 
    team1_id,team2_id,
    score_team1,
    score_team2,
    CASE 
        WHEN score_team1 > score_team2 THEN team1_id
        ELSE team2_id
    END AS Team_WON
FROM matches
WHERE m_id = in_matchID AND winner_id = CASE 
                                WHEN score_team1 > score_team2 THEN team1_id
                                ELSE team2_id
                              END;
END
*/
``` 

```
                                 Output

In the analytical context, retrieve the date and scores associated with Match ID 3.

                              Concepts learned
1.STORED PROCEDURE to get a report on the WINNERS of each match by matchID
2.CASE WHEN THEN
3.COMPARISON OPERATOR
```
-----------------------------------------------------------------------------------------------------
