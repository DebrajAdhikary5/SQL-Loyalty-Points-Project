
# 🎮 SQL Loyalty Points Analysis – ABC Gaming

This project analyzes user behavior in a real-money online gaming platform using SQL to calculate and rank loyalty points.

---

## 📌 Objective

- Clean raw transactional and gameplay data.
- Calculate daily and monthly loyalty points for each player.
- Rank players and design a bonus distribution plan.
- Analyze fairness of the loyalty formula and suggest improvements.

---

## 📁 Dataset Used

- `deposit_data.csv` – User deposits with timestamps
- `withdrawal_data.csv` – User withdrawals with timestamps
- `user_gameplay_data.csv` – Game sessions and gameplay count per user

All datasets were manually cleaned and slotted into time segments (S1: 12am–12pm, S2: 12pm–12am).

---

## ⚙️ Tasks Performed

- Cleaned datetime fields and split them into `Date`, `Time`, and `Slot`
- Created `loyalty_data` table using cleaned data
- Calculated loyalty points using:
  - 1% of deposit amount
  - 0.5% of withdrawal amount
  - 0.1 point per extra deposit over withdrawals
  - 0.2 points per game played
- Answered SQL-based business questions
- Ranked players for leaderboard and monthly loyalty rewards

---

## 🪙 Bonus Distribution Strategy

- 🎁 **Total Pool:** ₹50,000
- 💵 **Base Bonus:** ₹200 × 50 players = ₹10,000
- 🧮 **Performance Bonus (₹40,000 split):**
  - 70% based on Loyalty Points = ₹28,000
  - 30% based on Games Played = ₹12,000

> ✅ This approach keeps all players motivated and rewards both skill and participation.

---

## 📄 Project Files

| File Name                                         | Description                              |
|--------------------------------------------------|------------------------------------------|
| [`deposit_data.csv`](./deposit_data.csv)         | Raw deposit transactions                  |
| [`withdrawal_data.csv`](./withdrawal_data.csv)   | Raw withdrawal transactions               |
| [`user_gameplay_data.csv`](./user_gameplay_data.csv) | Raw gameplay logs                     |
| [`ABCFinal.sql`](./ABCFinal.sql)                 | Final SQL script with all queries         |
| [`Loyalty_Project_Report_By_Debraj_Adhikary.pdf`](./Loyalty_Project_Report_By_Debraj_Adhikary.pdf) | Final project report (PDF format)        |

---

## 🔧 Tools Used

- MySQL Workbench
- Manual Data Import Wizard
- Excel (for quick sanity checks)
- Word & PDF (for documentation)

---

## 📌 Summary

- Cleaned & transformed data into a structured format
- Built a loyalty point system with daily and monthly breakdowns
- Designed a fair bonus distribution plan
- Analyzed and suggested improvements for the point system

---

## 🙋‍♂️ Author

**Debraj Adhikary** – [GitHub](https://github.com/DebrajAdhikaey5)  
For any queries, feel free to connect!
