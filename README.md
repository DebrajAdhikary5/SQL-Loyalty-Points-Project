# SQL Loyalty Points Analysis Project 🧮

This project analyzes user behavior in a real-money online gaming platform using SQL to calculate and rank loyalty points.

### 🧾 Objective:
- Calculate loyalty points based on deposits, withdrawals, and games played.
- Rank users for a bonus pool distribution.
- Provide analysis and suggestions for improving the loyalty formula.

---

### 📁 Data Used:
- `deposit_data.csv`
- `withdrawal_data.csv`
- `user_gameplay_data.csv`

---

### 🔍 Key Tasks:
- Cleaned datetime fields and created time-based slots (`S1`, `S2`)
- Created a `loyalty_data` table to store user activity per day/slot
- Ranked players by loyalty points for October
- Suggested a bonus distribution method for top 50 players

---

### 💰 Bonus Distribution Idea:
- ₹200 base bonus per top 50 player
- Remaining ₹40,000 distributed:
  - 70% based on Loyalty Points
  - 30% based on Games Played

---

### 📊 Tools Used:
- MySQL Workbench
- Manual import via Table Data Import Wizard

---

### 📄 Report:
See `Report.docx` for complete analysis and explanation.
