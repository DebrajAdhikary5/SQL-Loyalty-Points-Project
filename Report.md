Data Collection
I downloaded the data from Google Sheets and saved the files as CSVs.
Data Cleaning
The first step was to import all three datasets into MySQL using the Table Data Import Wizard:
- deposit_data
- withdrawal_data
- user_gameplay_data
Then, I cleaned and structured each dataset as follows:
- Removed special characters (like ï»¿) from column names
- Converted the Datetime column into separate Date, Time, and a new Slot column:
  - If Time < 12:00:00 → Slot = 'S1'
  - Else → Slot = 'S2'
This helped segment and analyze player activity more accurately based on the time of day.
Loyalty Point Calculation (Part A)
Loyalty points were calculated using the given formula:

Loyalty Points =
(1% of Total Deposits) +
(0.5% of Total Withdrawals) +
(0.1 point for each extra deposit over withdrawal) +
(0.2 point per game played)
This calculation helped answer the first question:
“Find player-wise loyalty points earned by players in the following slots:”
- 2nd October — S1
- 16th October — S2
- 18th October — S1
- 26th October — S2

I also ranked players based on their total monthly loyalty points and number of games played.
Additional Insights
I explored the following questions as well:
- What is the average deposit amount?
- What is the average deposit per user per month?
- What is the average number of games played per user?
Bonus Distribution Strategy (Part B)
Total Bonus Pool = ₹50,000
Only the Top 50 Players (based on loyalty points and gameplay) were eligible.

I aimed to design a fair system that rewarded both big spenders and active players.
Bonus Split Plan:
- Base Bonus: ₹200 per player for all Top 50 players
  → ₹200 × 50 = ₹10,000
  This keeps even lower-ranked players in the top 50 motivated.

- Remaining ₹40,000 was distributed as:
  - 70% based on Loyalty Points → ₹28,000
  - 30% based on Games Played → ₹12,000

This ensured that both strategic depositors and highly engaged players were rewarded — making the system balanced and inclusive.
Is the Loyalty Formula Fair? (Part C)
The loyalty system considers four main factors:
1. Deposit Amount – 1% of total deposits
2. Withdrawal Amount – 0.5% of total withdrawals
3. More Deposits than Withdrawals – 0.1 point per extra deposit
4. Games Played – 0.2 point per game

I believe the formula is mostly fair, as it rewards users for both spending money and engaging with the platform.
However, there’s a loophole:
A player could inflate their points by repeatedly depositing and withdrawing small amounts.
For example, depositing ₹1000 and withdrawing ₹950 immediately earns points without real gameplay. Repeating this can unfairly boost loyalty scores.
Suggestions to Improve the Formula
1. Reward Wins, Not Just Games Played
   - Instead of rewarding just participation, assign points for wins.
   - Example: Each win earns XP, and loyalty points are given based on XP milestones.

2. Introduce Daily Login or Deposit Streak Bonuses
   - Reward consistent users — not just big depositors.
   - Even 0.1–0.2 loyalty points for daily activity can increase retention.

3. Remove Rewards for Withdrawals
   - Eliminate the withdrawal reward.
   - Instead, set a low minimum withdrawal amount (e.g., ₹100) to support small winners without encouraging misuse.