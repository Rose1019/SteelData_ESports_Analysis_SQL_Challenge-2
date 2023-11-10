/*Creating Tables and Rows*/

create table teams(
t_id int primary key,
team_name varchar(45),
country varchar(50),
captain_id int);

insert into teams
values
(1, 'Cloud9', 'USA', 1),
(2, 'Fnatic', 'Sweden', 2),
(3, 'SK Telecom T1', 'South Korea', 3),
(4, 'Team Liquid', 'USA', 4),
(5, 'G2 Esports', 'Spain', 5);

create table players(
player_id int primary key,
player_name varchar(50),
t_id int,
role varchar(45),
salary int,
foreign key (t_id) references teams(t_id));

insert into players
values 
(1, 'Shroud', 1, 'Rifler', 100000),
(2, 'JW', 2, 'AWP', 90000),
(3, 'Faker', 3, 'Mid laner', 120000),
(4, 'Stewie2k', 4, 'Rifler', 95000),
(5, 'Perkz', 5, 'Mid laner', 110000),
(6, 'Castle09', 1, 'AWP', 120000),
(7, 'Pike', 2, 'Mid Laner', 70000),
(8, 'Daron', 3, 'Rifler', 125000),
(9, 'Felix', 4, 'Mid Laner', 95000),
(10, 'Stadz', 5, 'Rifler', 98000),
(11, 'KL34', 1, 'Mid Laner', 83000),
(12, 'ForceZ', 2, 'Rifler', 130000),
(13, 'Joker', 3, 'AWP', 128000),
(14, 'Hari', 4, 'AWP', 90000),
(15, 'Wringer', 5, 'Mid laner', 105000);

create table matches(
m_id int primary key,
team1_id int,
team2_id int,
match_date date,
winner_id int,
score_team1 int,
score_team2 int,
foreign key (team1_id) references teams(t_id),
foreign key (team2_id) references teams(t_id),
foreign key (winner_id) references teams(t_id));

insert into matches
values
(1, 1, 2, '2022-01-01', 1, 16, 14),
(2, 3, 5, '2022-02-01', 3, 14, 9),
(3, 4, 1, '2022-03-01', 1, 17, 13),
(4, 2, 5, '2022-04-01', 5, 13, 12),
(5, 3, 4, '2022-05-01', 3, 16, 10),
(6, 1, 3, '2022-02-01', 3, 13, 17),
(7, 2, 4, '2022-03-01', 2, 12, 9),
(8, 5, 1, '2022-04-01', 1, 11, 15),
(9, 2, 3, '2022-05-01', 3, 9, 10),
(10, 4, 5, '2022-01-01', 4, 13, 10);


/*Questions*/

/*1. What are the names of the players whose salary is greater than 100,000?*/
select player_name,salary
from players
where salary >100000;

/*2. What is the team name of the player with player_id = 3?*/
select t.team_name,p.player_name
from teams t 
join players p 
using(t_id)
where p.player_id=3;

/*3. What is the total number of players in each team?*/

select t.t_id,t.team_name as Team_Name,count(p.player_name) as Player_name
from players p 
join teams t 
using(t_id)
group by t.t_id,t.team_name;

/*4. What is the team name and captain name of the team with team_id = 2?*/

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


/*5. What are the player names and their roles in the team with team_id = 1?*/

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

/*6. What are the team names and the number of matches they have won?*/

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

/*7. What is the average salary of players in the teams with country 'USA'?*/

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

/*8. Which team won the most matches?*/

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


/*9. What are the team names and the number of players in each team whose salary is greater than 100,000?*/

select t.t_id,t.team_name,count(p.player_id) as number_of_player
from players p 
join teams t 
using(t_id)
where p.salary >100000
group by t.t_id,t.team_name;


/*10. What is the date and the score of the match with match_id = 3?*/

select match_date,score_team1,score_team2
from matches
where m_id=3;

SELECT 
    team1_id,team2_id,
    score_team1,
    score_team2,
    CASE 
        WHEN score_team1 > score_team2 THEN team1_id
        ELSE team2_id
    END AS Team_WON
FROM matches
WHERE m_id = 7 AND winner_id = CASE 
                                WHEN score_team1 > score_team2 THEN team1_id
                                ELSE team2_id
                              END;


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



