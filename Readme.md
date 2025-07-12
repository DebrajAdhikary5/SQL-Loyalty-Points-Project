
# 🧠 Loyalty Analysis & Bonus Distribution Report

## 📥 Data Collection

- [`deposit_data.csv`](./Deposit_Data.csv)
- [`withdrawal_data.csv`](./Withdrawal_Data.csv)
- [`user_gameplay_data.csv`](./User_Gameplay_data.csv)

These were imported into **MySQL** using the **Table Data Import Wizard**.

---

## 🧹 Data Cleaning

Each dataset was cleaned and structured:

- Removed special characters (like `ï»¿`) from column names.
- Converted the `Datetime` column into three new columns:
  - `Date` – Extracted date.
  - `Time` – Extracted time.
  - `Slot` – Categorized time of day:
    - If `Time < 12:00:00` → `Slot = 'S1'`
    - Else → `Slot = 'S2'`

This allowed us to segment and analyze player activity based on the time of day.

---

## 🎯 Loyalty Point Calculation

Loyalty points were calculated using the following formula:

```
Loyalty Points = 
(1% of Total Deposits) +
(0.5% of Total Withdrawals) +
(0.1 point per extra deposit over withdrawal) +
(0.2 point per game played)
```

This formula was used to calculate player-wise loyalty points for the following slots:

- 🗓️ **2nd October — S1**
- 🗓️ **16th October — S2**
- 🗓️ **18th October — S1**
- 🗓️ **26th October — S2**

Players were then **ranked** based on:
- Total monthly **loyalty points**
- Number of **games played**

---

## 📊 Additional Insights

Along with loyalty, we explored key statistics:

- 📌 **Average Deposit Amount**
- 👤 **Average Deposit Per User Per Month**
- 🎮 **Average Games Played Per User**

These metrics provided a broader understanding of player engagement and platform usage.

---

## 💸 Bonus Distribution Strategy

We had a **Total Bonus Pool of ₹50,000**, distributed among the **Top 50 Players** (based on loyalty and gameplay).

### 🎯 Objectives:
Design a **fair** reward system that motivates both:
- High spenders
- Highly active players

### 🪙 Bonus Breakdown:

| Component              | Amount    | Details                                 |
|------------------------|-----------|------------------------------------------|
| 🏅 Base Bonus          | ₹10,000   | ₹200 × 50 players                        |
| 🎯 Loyalty-Based Bonus | ₹28,000   | 70% of remaining ₹40,000 pool            |
| 🎮 Games-Based Bonus   | ₹12,000   | 30% of remaining ₹40,000 pool            |

This system ensured a **balanced and inclusive** bonus model.

---

## 🤔 Is the Loyalty Formula Fair?

### The Formula Considers:
1. ✅ **Deposit Amount** – 1%
2. ✅ **Withdrawal Amount** – 0.5%
3. ✅ **Excess Deposits** – 0.1 point per extra deposit
4. ✅ **Games Played** – 0.2 point per game

### But... there's a **loophole**:

> A user could deposit ₹1000, withdraw ₹950, and repeat.  
> This inflates loyalty points without real gameplay.

---

## 🛠️ Suggestions for Improvement

### 1. Reward Wins, Not Just Games
- ✅ Give points for **winning games**, not just participating.
- 🎯 Example: Introduce an **XP-based system**.

### 2. Streak-Based Bonuses
- 🔥 Reward **daily deposits or logins**.
- 📈 Even 0.1–0.2 points daily can boost engagement.

### 3. Remove Withdrawal Rewards
- 🚫 Stop giving loyalty for withdrawals.
- ✅ Keep small withdrawals possible to support genuine users.

---

## ✅ Conclusion

This project combined **data cleaning**, **SQL/Python analytics**, and **business logic** to design a **data-driven reward system** that’s fair, motivating, and scalable.
