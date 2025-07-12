Create Database ABC_db;
/*Created a Data base named ABC_db*/
Use ABC_db;
/*Selected ABC_db as defult data basr as I have many more Data base so i used this*/
/* As iam using MySQL so Importing Tables using "Table Data Import Wizwrd" */

/* Data Cleaning */ 

SELECT 
    *
FROM
    deposit_data;

ALTER TABLE deposit_data
CHANGE COLUMN `ï»¿User ID` User_id INT;
/* removing ï»¿ from the UserID Colum */

ALTER TABLE deposit_data
CHANGE COLUMN NDatetime DATETIME;
/* Creating a new colum Name NDatetime */

set SQL_SAFE_UPDATES = 0;

UPDATE deposit_data 
SET 
    NDatetime = CASE
        WHEN Datetime LIKE '%/%/% %:%' THEN STR_TO_DATE(Datetime, '%e/%m/%Y %k:%i')
        WHEN Datetime LIKE '%-%-% %:%' THEN STR_TO_DATE(Datetime, '%d-%m-%Y %H:%i')
        ELSE NULL
    END; 


alter table deposit_data
drop column Datetime

ALTER TABLE deposit_data
ADD COLUMN Date DATE;

ALTER TABLE deposit_data
ADD COLUMN Time TIME;

UPDATE deposit_data 
SET 
    Date = DATE(NDatetime),
    Time = TIME(NDatetime);
    
    
ALTER TABLE deposit_data
ADD COLUMN Slot VARCHAR(2);

UPDATE deposit_data 
SET 
    Slot = CASE
        WHEN Time < '12:00:00' THEN 'S1'
        ELSE 'S2'
    END;

##################################################################################################################################

SELECT 
    *
FROM
    user_gameplay_data;

ALTER TABLE user_gameplay_data
CHANGE COLUMN `ï»¿User ID` User_id INT;

ALTER TABLE user_gameplay_data
add column UDatetime DATETIME;

UPDATE user_gameplay_data
SET UDatetime = STR_TO_DATE(Datetime, "%d-%m-%Y %H:%i")

ALTER TABLE user_gameplay_data
drop column Datetime


ALTER TABLE user_gameplay_data
ADD COLUMN Date DATE;

ALTER TABLE user_gameplay_data
ADD COLUMN Time TIME;

UPDATE user_gameplay_data
SET Date = DATE(UDatetime),
    Time = TIME(UDatetime);

ALTER TABLE user_gameplay_data
ADD COLUMN Slot VARCHAR(2);

UPDATE user_gameplay_data
SET Slot = 
    CASE 
        WHEN Time < '12:00:00' THEN 'S1'
        ELSE 'S2'
    END;

##################################################################################################################################

SELECT 
    *
FROM
    withdrawal_data;

ALTER TABLE withdrawal_data
CHANGE COLUMN `ï»¿User ID` User_id INT;

alter table withdrawal_data
add column WDatetime DATETIME;


UPDATE withdrawal_data
SET WDatetime = STR_TO_DATE(Datetime, "%d-%m-%Y %H:%i")

alter table withdrawal_data
drop column Datetime


ALTER TABLE withdrawal_data
ADD COLUMN Date DATE;

ALTER TABLE withdrawal_data
ADD COLUMN Time TIME;

UPDATE withdrawal_data
SET Date = DATE(WDatetime),
    Time = TIME(WDatetime);
    
ALTER TABLE withdrawal_data
ADD COLUMN Slot VARCHAR(2);

UPDATE withdrawal_data
SET Slot = 
    CASE 
        WHEN Time < '12:00:00' THEN 'S1'
        ELSE 'S2'
    END;
    
#############################################################################################################################################

/* Part A - Question 1: Find Playerwise Loyalty points earned by Players in the following slots:

/* a. 2nd October Slot S1 */

SELECT 
    COALESCE(d.User_id, w.User_id, g.User_id) AS User_id,
    COALESCE(d.Date, w.Date, g.Date) AS Date,
    COALESCE(d.Slot, w.Slot, g.Slot) AS Slot,
    COALESCE(Total_Deposit, 0) AS Deposit_Amount,
    COALESCE(No_of_Deposit, 0) AS Deposit_Count,
    COALESCE(Total_Withdrawal, 0) AS Withdrawal_Amount,
    COALESCE(No_of_Withdrawal, 0) AS Withdrawal_Count,
    COALESCE(Total_Games, 0) AS Games_Played,
    (0.01 * COALESCE(Total_Deposit, 0)) + (0.005 * COALESCE(Total_Withdrawal, 0)) + (0.001 * GREATEST(COALESCE(No_of_Deposit, 0) - COALESCE(No_of_Withdrawal, 0),
            0)) + (0.2 * COALESCE(Total_Games, 0)) AS Loyalty_Points
FROM
    (SELECT 
        User_id,
            Date,
            Slot,
            SUM(Amount) AS Total_Deposit,
            COUNT(*) AS No_of_Deposit
    FROM
        deposit_data
    WHERE
        Date = '2022-10-02' AND Slot = 'S1'
    GROUP BY User_id , Date , Slot) d
        LEFT JOIN
    (SELECT 
        User_id,
            Date,
            Slot,
            SUM(Amount) AS Total_Withdrawal,
            COUNT(*) AS No_of_Withdrawal
    FROM
        withdrawal_data
    WHERE
        Date = '2022-10-02' AND Slot = 'S1'
    GROUP BY User_id , Date , Slot) w ON d.User_id = w.User_id
        AND d.Date = w.Date
        AND d.Slot = w.Slot
        LEFT JOIN
    (SELECT 
        User_id, Date, Slot, SUM(`Games Played`) AS Total_Games
    FROM
        user_gameplay_data
    WHERE
        Date = '2022-10-02' AND Slot = 'S1'
    GROUP BY User_id , Date , Slot) g ON d.User_id = g.User_id
        AND d.Date = g.Date
        AND d.Slot = g.Slot;

################################################################################################
/* b. 16th October Slot S2 */

SELECT 
    COALESCE(d.User_id, w.User_id, g.User_id) AS User_id,
    COALESCE(d.Date, w.Date, g.Date) AS Date,
    COALESCE(d.Slot, w.Slot, g.Slot) AS Slot,
    COALESCE(Total_Deposit, 0) AS Deposit_Amount,
    COALESCE(No_of_Deposit, 0) AS Deposit_Count,
    COALESCE(Total_Withdrawal, 0) AS Withdrawal_Amount,
    COALESCE(No_of_Withdrawal, 0) AS Withdrawal_Count,
    COALESCE(Total_Games, 0) AS Games_Played,
    (0.01 * COALESCE(Total_Deposit, 0)) + (0.005 * COALESCE(Total_Withdrawal, 0)) + (0.001 * GREATEST(COALESCE(No_of_Deposit, 0) - COALESCE(No_of_Withdrawal, 0),
            0)) + (0.2 * COALESCE(Total_Games, 0)) AS Loyalty_Points
FROM
    (SELECT 
        User_id,
            Date,
            Slot,
            SUM(Amount) AS Total_Deposit,
            COUNT(*) AS No_of_Deposit
    FROM
        deposit_data
    WHERE
        Date = '2022-10-16' AND Slot = 'S2'
    GROUP BY User_id , Date , Slot) d
        LEFT JOIN
    (SELECT 
        User_id,
            Date,
            Slot,
            SUM(Amount) AS Total_Withdrawal,
            COUNT(*) AS No_of_Withdrawal
    FROM
        withdrawal_data
    WHERE
        Date = '2022-10-16' AND Slot = 'S2'
    GROUP BY User_id , Date , Slot) w ON d.User_id = w.User_id
        AND d.Date = w.Date
        AND d.Slot = w.Slot
        LEFT JOIN
    (SELECT 
        User_id, Date, Slot, SUM(`Games Played`) AS Total_Games
    FROM
        user_gameplay_data
    WHERE
        Date = '2022-10-16' AND Slot = 'S2'
    GROUP BY User_id , Date , Slot) g ON d.User_id = g.User_id
        AND d.Date = g.Date
        AND d.Slot = g.Slot;

###########################################################################################################################################

/* c. 18th October Slot S1 */

SELECT 
    COALESCE(d.User_id, w.User_id, g.User_id) AS User_id,
    COALESCE(d.Date, w.Date, g.Date) AS Date,
    COALESCE(d.Slot, w.Slot, g.Slot) AS Slot,
    COALESCE(Total_Deposit, 0) AS Deposit_Amount,
    COALESCE(No_of_Deposit, 0) AS Deposit_Count,
    COALESCE(Total_Withdrawal, 0) AS Withdrawal_Amount,
    COALESCE(No_of_Withdrawal, 0) AS Withdrawal_Count,
    COALESCE(Total_Games, 0) AS Games_Played,
    (0.01 * COALESCE(Total_Deposit, 0)) + (0.005 * COALESCE(Total_Withdrawal, 0)) + (0.001 * GREATEST(COALESCE(No_of_Deposit, 0) - COALESCE(No_of_Withdrawal, 0),
            0)) + (0.2 * COALESCE(Total_Games, 0)) AS Loyalty_Points
FROM
    (SELECT 
        User_id,
            Date,
            Slot,
            SUM(Amount) AS Total_Deposit,
            COUNT(*) AS No_of_Deposit
    FROM
        deposit_data
    WHERE
        Date = '2022-10-18' AND Slot = 'S1'
    GROUP BY User_id , Date , Slot) d
        LEFT JOIN
    (SELECT 
        User_id,
            Date,
            Slot,
            SUM(Amount) AS Total_Withdrawal,
            COUNT(*) AS No_of_Withdrawal
    FROM
        withdrawal_data
    WHERE
        Date = '2022-10-18' AND Slot = 'S1'
    GROUP BY User_id , Date , Slot) w ON d.User_id = w.User_id
        AND d.Date = w.Date
        AND d.Slot = w.Slot
        LEFT JOIN
    (SELECT 
        User_id, Date, Slot, SUM(`Games Played`) AS Total_Games
    FROM
        user_gameplay_data
    WHERE
        Date = '2022-10-18' AND Slot = 'S1'
    GROUP BY User_id , Date , Slot) g ON d.User_id = g.User_id
        AND d.Date = g.Date
        AND d.Slot = g.Slot;

######################################################################################################################

/* d. 26th October Slot S2 */

SELECT 
    COALESCE(d.User_id, w.User_id, g.User_id) AS User_id,
    COALESCE(d.Date, w.Date, g.Date) AS Date,
    COALESCE(d.Slot, w.Slot, g.Slot) AS Slot,
    COALESCE(Total_Deposit, 0) AS Deposit_Amount,
    COALESCE(No_of_Deposit, 0) AS Deposit_Count,
    COALESCE(Total_Withdrawal, 0) AS Withdrawal_Amount,
    COALESCE(No_of_Withdrawal, 0) AS Withdrawal_Count,
    COALESCE(Total_Games, 0) AS Games_Played,
    (0.01 * COALESCE(Total_Deposit, 0)) + (0.005 * COALESCE(Total_Withdrawal, 0)) + (0.001 * GREATEST(COALESCE(No_of_Deposit, 0) - COALESCE(No_of_Withdrawal, 0),
            0)) + (0.2 * COALESCE(Total_Games, 0)) AS Loyalty_Points
FROM
    (SELECT 
        User_id,
            Date,
            Slot,
            SUM(Amount) AS Total_Deposit,
            COUNT(*) AS No_of_Deposit
    FROM
        deposit_data
    WHERE
        Date = '2022-10-26' AND Slot = 'S2'
    GROUP BY User_id , Date , Slot) d
        LEFT JOIN
    (SELECT 
        User_id,
            Date,
            Slot,
            SUM(Amount) AS Total_Withdrawal,
            COUNT(*) AS No_of_Withdrawal
    FROM
        withdrawal_data
    WHERE
        Date = '2022-10-26' AND Slot = 'S2'
    GROUP BY User_id , Date , Slot) w ON d.User_id = w.User_id
        AND d.Date = w.Date
        AND d.Slot = w.Slot
        LEFT JOIN
    (SELECT 
        User_id, Date, Slot, SUM(`Games Played`) AS Total_Games
    FROM
        user_gameplay_data
    WHERE
        Date = '2022-10-26' AND Slot = 'S2'
    GROUP BY User_id , Date , Slot) g ON d.User_id = g.User_id
        AND d.Date = g.Date
        AND d.Slot = g.Slot;

#############################################################################################################

/* rank players on the basis of loyalty points */

WITH MonthlyDeposits AS (
    SELECT
        User_id,
        SUM(Amount) AS Total_Deposit,
        COUNT(*) AS No_of_Deposit
    FROM deposit_data
    WHERE MONTH(Date) = 10 AND YEAR(Date) = 2022
    GROUP BY User_id
),
MonthlyWithdrawals AS (
    SELECT
        User_id,
        SUM(Amount) AS Total_Withdrawal,
        COUNT(*) AS No_of_Withdrawal
    FROM withdrawal_data
    WHERE MONTH(Date) = 10 AND YEAR(Date) = 2022
    GROUP BY User_id
),
MonthlyGameplay AS (
    SELECT
        User_id,
        SUM(`Games Played`) AS Total_Games
    FROM user_gameplay_data
    WHERE MONTH(Date) = 10 AND YEAR(Date) = 2022
    GROUP BY User_id
),

AllActiveUsersInOctober AS (
    SELECT User_id FROM MonthlyDeposits
    UNION
    SELECT User_id FROM MonthlyWithdrawals
    UNION
    SELECT User_id FROM MonthlyGameplay
)
SELECT
    au.User_id,
   
    COALESCE(md.Total_Deposit, 0) AS Total_Deposit_Amount,
    COALESCE(md.No_of_Deposit, 0) AS Deposit_Count,
    COALESCE(mw.Total_Withdrawal, 0) AS Total_Withdrawal_Amount,
    COALESCE(mw.No_of_Withdrawal, 0) AS Withdrawal_Count,
    COALESCE(mg.Total_Games, 0) AS Games_Played_Count, 

    (0.01 * COALESCE(md.Total_Deposit, 0)) +
    (0.005 * COALESCE(mw.Total_Withdrawal, 0)) +
    (0.001 * GREATEST(COALESCE(md.No_of_Deposit, 0) - COALESCE(mw.No_of_Withdrawal, 0), 0)) +
    (0.2 * COALESCE(mg.Total_Games, 0)) AS Loyalty_Points,

   
    RANK() OVER (
        ORDER BY
            (0.01 * COALESCE(md.Total_Deposit, 0)) +
            (0.005 * COALESCE(mw.Total_Withdrawal, 0)) +
            (0.001 * GREATEST(COALESCE(md.No_of_Deposit, 0) - COALESCE(mw.No_of_Withdrawal, 0), 0)) +
            (0.2 * COALESCE(mg.Total_Games, 0)) DESC,
            COALESCE(mg.Total_Games, 0) DESC
    ) AS Loyalty_Rank

FROM
    AllActiveUsersInOctober au
LEFT JOIN MonthlyDeposits md ON au.User_id = md.User_id
LEFT JOIN MonthlyWithdrawals mw ON au.User_id = mw.User_id
LEFT JOIN MonthlyGameplay mg ON au.User_id = mg.User_id
ORDER BY
    Loyalty_Rank ASC;


###############################################################################################

/* What is the average deposit amount? */

SELECT 
    AVG(Amount) AS Average_Deposit_Amount
FROM
    deposit_data;

#####################################################################

/* What is the average deposit amount per user in a month? */

SELECT 
    AVG(User_Total) AS Avg_Deposit_Per_User_October
FROM
    (SELECT 
        User_id, SUM(Amount) AS User_Total
    FROM
        deposit_data
    WHERE
        MONTH(Date) = 10 AND YEAR(Date) = 2022
    GROUP BY User_id) AS user_totals;

###################################################################################

/* What is the average number of games played per user? */

SELECT 
    AVG(Total_Games) AS Avg_Games_Per_User
FROM
    (SELECT 
        User_id, SUM(`Games Played`) AS Total_Games
    FROM
        user_gameplay_data
    GROUP BY User_id) AS user_games;

#################################################################################################################
#######################################################################################################################
/* Part B 

My Idea fro bonus distribution 

Total Bonus Pool = ₹50,000

Base Bonus: ₹200 for each top 50 player
₹200 × 50 = ₹10,000

(This ensures everyone gets something.) so the plays stay motivated 

Remaining Bonus Pool = ₹50,000 − ₹10,000 = ₹40,000

70% based on Loyalty Points = ₹28,000

30% based on Games Played = ₹12,000

*/

WITH deposit AS (
    SELECT
        User_id,
        SUM(Amount) AS Deposit_Amount,
        COUNT(*) AS Deposit_Count
    FROM deposit_data
    WHERE MONTH(Date) = 10 AND YEAR(Date) = 2022
    GROUP BY User_id
),
withdrawal AS (
    SELECT
        User_id,
        SUM(Amount) AS Withdrawal_Amount,
        COUNT(*) AS Withdrawal_Count
    FROM withdrawal_data
    WHERE MONTH(Date) = 10 AND YEAR(Date) = 2022
    GROUP BY User_id
),
gameplay AS (
    SELECT
        User_id,
        SUM(`Games Played`) AS Games_Played
    FROM user_gameplay_data
    WHERE MONTH(Date) = 10 AND YEAR(Date) = 2022
    GROUP BY User_id
),
all_users AS (
    SELECT User_id FROM deposit
    UNION
    SELECT User_id FROM withdrawal
    UNION
    SELECT User_id FROM gameplay
),
ranked_players AS (
    SELECT
        u.User_id,
        COALESCE(d.Deposit_Amount, 0) AS Deposit_Amount,
        COALESCE(d.Deposit_Count, 0) AS Deposit_Count,
        COALESCE(w.Withdrawal_Amount, 0) AS Withdrawal_Amount,
        COALESCE(w.Withdrawal_Count, 0) AS Withdrawal_Count,
        COALESCE(g.Games_Played, 0) AS `Games Played`,


        (0.01 * COALESCE(d.Deposit_Amount, 0)) +
        (0.005 * COALESCE(w.Withdrawal_Amount, 0)) +
        (0.001 * GREATEST(COALESCE(d.Deposit_Count, 0) - COALESCE(w.Withdrawal_Count, 0), 0)) +
        (0.2 * COALESCE(g.Games_Played, 0)) AS Loyalty_Points,

    
        RANK() OVER (
            ORDER BY
                (0.01 * COALESCE(d.Deposit_Amount, 0)) +
                (0.005 * COALESCE(w.Withdrawal_Amount, 0)) +
                (0.001 * GREATEST(COALESCE(d.Deposit_Count, 0) - COALESCE(w.Withdrawal_Count, 0), 0)) +
                (0.2 * COALESCE(g.Games_Played, 0)) DESC
        ) AS Loyalty_Rank
    FROM all_users u
    LEFT JOIN deposit d ON u.User_id = d.User_id
    LEFT JOIN withdrawal w ON u.User_id = w.User_id
    LEFT JOIN gameplay g ON u.User_id = g.User_id
),
top_50_players AS (
    SELECT *
    FROM ranked_players
    WHERE Loyalty_Rank <= 50
),
total_loyalty_games AS (
    SELECT 
        SUM(Loyalty_Points) AS Total_Loyalty,
        SUM(`Games Played`) AS Total_Games
    FROM top_50_players
),
bonus_distribution AS (
    SELECT 
        p.User_id,
        200 AS Base_Bonus, 
        ROUND((28000 * p.Loyalty_Points / t.Total_Loyalty), 2) AS Loyalty_Bonus,
        ROUND((12000 * p.`Games Played` / t.Total_Games), 2) AS Games_Bonus
    FROM top_50_players p
    CROSS JOIN total_loyalty_games t
)
SELECT 
    User_id,
    Base_Bonus,
    Loyalty_Bonus,
    Games_Bonus,
    ROUND(Base_Bonus + Loyalty_Bonus + Games_Bonus, 2) AS Final_Bonus
FROM bonus_distribution
ORDER BY Final_Bonus DESC;
############################################################################################################################

/* Part C is in the Report */
 







