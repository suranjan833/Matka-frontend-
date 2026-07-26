# 📱 Matka App — API Documentation

> **Base URL (Production):** `https://saptahikgyan.space/admin/api/app/`
>
> **Base URL (Local):** `http://localhost/matka_admin/api/app/`

All endpoints accept **JSON** (`Content-Type: application/json`) or **form-data**.  
All responses are in **JSON format** with a `status` code and `message` field.

---

## 📋 Table of Contents

| # | Category | Endpoints |
|---|----------|-----------|
| 1 | **Authentication** | Login, Register, MPin Login, Set MPin |
| 2 | **Profile** | Get Profile, Update Profile, Change Password |
| 3 | **Wallet** | Get Wallet, Add Money, Withdraw Request, Wallet History |
| 4 | **Markets** | Get Game Markets, Get Bet Types |
| 5 | **Betting** | Place Bet, Get Bet History |
| 6 | **Results** | Get Published Results |

---

## 🔐 1. Authentication

---

### 1.1 User Login

**Endpoint:** `login.php`  
**Method:** `POST`

Authenticate user with phone number and password.

#### Request

```json
{
    "phone": "9876543210",
    "password": "user123"
}
```

#### Success Response (200)

```json
{
    "status": 200,
    "message": "Login successful",
    "data": {
        "id": 1,
        "name": "Rahim",
        "phone": "9876543210",
        "email": "rahim@test.com",
        "mpin_set": true,
        "token": "a1b2c3d4e5f6..."
    }
}
```

> **Note:** `mpin_set` indicates whether the user has set a 4-6 digit MPin for quick login.

#### Error Responses

| Status | Message | Description |
|--------|---------|-------------|
| 400 | Phone and password are required | Missing fields |
| 404 | User not found | No account with this phone |
| 403 | Account inactive | User account is disabled |
| 401 | Incorrect password | Wrong password |

---

### 1.2 User Registration

**Endpoint:** `register.php`  
**Method:** `POST`

Create a new user account.

#### Request

```json
{
    "name": "New User",
    "email": "newuser@example.com",
    "phone": "9876543200",
    "password": "securepass",
    "mpin": "1234"
}
```

> **Note:** `mpin` is **optional** (4-6 digits). Can be set later via `set_mpin.php`.

#### Success Response (200)

```json
{
    "status": 200,
    "message": "Registration successful",
    "data": {
        "id": 6,
        "name": "New User",
        "phone": "9876543200",
        "mpin_set": true
    }
}
```

#### Error Responses

| Status | Message | Description |
|--------|---------|-------------|
| 400 | All fields are required | Missing name/email/phone/password |
| 400 | Invalid email format | Email format is wrong |
| 400 | MPin must be 4-6 digits | Bad MPin format |
| 409 | Email already exists | Duplicate email |
| 409 | Phone already exists | Duplicate phone |

---

### 1.3 MPin Login (Quick Login)

**Endpoint:** `mpin_login.php`  
**Method:** `POST`

Login using phone number + 4-6 digit MPin (set after password login).

#### Request

```json
{
    "phone": "9876543210",
    "mpin": "1234"
}
```

#### Success Response (200)

```json
{
    "status": 200,
    "message": "Login successful",
    "data": {
        "id": 1,
        "name": "Rahim",
        "phone": "9876543210",
        "email": "rahim@test.com",
        "mpin_set": true,
        "token": "a1b2c3d4e5f6..."
    }
}
```

#### Error Responses

| Status | Message | Description |
|--------|---------|-------------|
| 400 | Phone and MPin are required | Missing fields |
| 400 | Invalid MPin format | MPin not 4-6 digits |
| 400 | MPin not set | User hasn't set an MPin yet — use password login first |
| 404 | User not found | No account with this phone |
| 403 | Account inactive | User is disabled |
| 401 | Incorrect MPin | Wrong MPin |

---

### 1.4 Set MPin

**Endpoint:** `set_mpin.php`  
**Method:** `POST`

Set or change the 4-6 digit MPin. Requires password verification.

#### Request

```json
{
    "phone": "9876543210",
    "password": "user123",
    "mpin": "5678"
}
```

#### Success Response (200)

```json
{
    "status": 200,
    "message": "MPin set successfully"
}
```

#### Error Responses

| Status | Message | Description |
|--------|---------|-------------|
| 400 | Phone, password, and new MPin are required | Missing fields |
| 400 | MPin must be 4-6 digits only | Bad MPin format |
| 404 | User not found | No account with this phone |
| 401 | Incorrect password | Wrong password |

---

## 👤 2. Profile

---

### 2.1 Get Profile

**Endpoint:** `get_profile.php`  
**Method:** `POST`

Fetch user profile details including wallet balance.

#### Request

```json
{
    "user_id": 1
}
```

#### Success Response (200)

```json
{
    "status": 200,
    "message": "Profile fetched successfully",
    "data": {
        "id": 1,
        "name": "Rahim",
        "email": "rahim@test.com",
        "phone": "9876543210",
        "wallet": 1500.00,
        "mpin_set": true,
        "status": 1
    }
}
```

#### Error Responses

| Status | Message | Description |
|--------|---------|-------------|
| 400 | User ID required | Missing user_id |
| 404 | User not found | Invalid user_id |

---

### 2.2 Update Profile

**Endpoint:** `update_profile.php`  
**Method:** `POST`

Update user name and/or email. Requires password verification.

#### Request

```json
{
    "user_id": 1,
    "password": "user123",
    "name": "Rahim Updated",
    "email": "rahim_new@test.com"
}
```

> **Note:** Only provide the fields you want to update (`name` and/or `email`). Both are optional but at least one must be provided.

#### Success Response (200)

```json
{
    "status": 200,
    "message": "Profile updated successfully"
}
```

#### Error Responses

| Status | Message | Description |
|--------|---------|-------------|
| 400 | User ID and password are required | Missing required fields |
| 400 | Nothing to update | Neither name nor email provided |
| 404 | User not found | Invalid user_id |
| 401 | Incorrect password | Wrong password |
| 409 | Email already in use by another account | Email taken |

---

### 2.3 Change Password

**Endpoint:** `change_password.php`  
**Method:** `POST`

Change user password. Requires old password verification.

#### Request

```json
{
    "user_id": 1,
    "old_password": "user123",
    "new_password": "newSecurePass"
}
```

#### Success Response (200)

```json
{
    "status": 200,
    "message": "Password changed successfully"
}
```

#### Error Responses

| Status | Message | Description |
|--------|---------|-------------|
| 400 | User ID, old password, and new password are required | Missing fields |
| 400 | New password must be at least 4 characters | Too short |
| 404 | User not found | Invalid user_id |
| 401 | Current password is incorrect | Wrong old password |

---

## 💰 3. Wallet

---

### 3.1 Get Wallet Balance

**Endpoint:** `get_wallet.php`  
**Method:** `POST`

Fetch current wallet balance. Auto-creates a wallet if one doesn't exist.

#### Request

```json
{
    "user_id": 1
}
```

#### Success Response (200)

```json
{
    "status": 200,
    "message": "Success",
    "data": {
        "balance": 1500.00
    }
}
```

#### Error Responses

| Status | Message | Description |
|--------|---------|-------------|
| 400 | User ID required | Missing user_id |

---

### 3.2 Add Money (Deposit)

**Endpoint:** `add_money.php`  
**Method:** `POST` (supports **multipart/form-data** for image upload)

Submit a deposit request.  

- **`type: "Manual"`** — Admin must approve before wallet is credited  
- **`type: "Automatic"`** — Wallet is credited instantly (auto-approved)

#### Request (JSON)

```json
{
    "user_id": 1,
    "amount": 500,
    "transaction_id": "GPay123456789",
    "type": "Manual"
}
```

#### Request (Form-Data — with image)

| Key | Value |
|-----|-------|
| `user_id` | `1` |
| `amount` | `500` |
| `transaction_id` | `GPay123456789` |
| `type` | `Manual` |
| `image` | (file upload — payment screenshot) |

#### Success Response (200)

```json
{
    "status": 200,
    "message": "Deposit request submitted. Awaiting admin approval.",
    "data": {
        "system_transaction_id": "TXN17123456789999",
        "image": "1712345678_1234.jpg",
        "type": "Manual"
    }
}
```

#### Auto-Approved Response (type = "Automatic")

```json
{
    "status": 200,
    "message": "Deposit auto-approved! Wallet credited.",
    "data": {
        "system_transaction_id": "TXN17123456789999",
        "image": "",
        "type": "Automatic"
    }
}
```

#### Error Responses

| Status | Message | Description |
|--------|---------|-------------|
| 400 | User ID and amount required | Missing fields |
| 500 | Image upload failed | Screenshot couldn't be saved |

---

### 3.3 Withdraw Request

**Endpoint:** `withdraw_request.php`  
**Method:** `POST`

Submit a withdrawal request. Supports **Bank Transfer** and **UPI** methods.

#### Request (Bank Transfer)

```json
{
    "user_id": 1,
    "amount": 500,
    "method": "Bank Transfer",
    "account_holder": "Rahim",
    "bank_name": "Axis Bank",
    "account_number": "912345678901234",
    "ifsc_code": "UTIB0001234"
}
```

#### Request (UPI)

```json
{
    "user_id": 1,
    "amount": 500,
    "method": "UPI",
    "account_holder": "Rahim",
    "upi_id": "rahim@paytm"
}
```

> **Note:** For UPI, only `upi_id` is required. For Bank Transfer, `bank_name`, `account_number`, and optionally `ifsc_code` + `account_holder` are required.

#### Success Response (200)

```json
{
    "status": 200,
    "message": "Withdrawal request submitted successfully"
}
```

#### Error Responses

| Status | Message | Description |
|--------|---------|-------------|
| 400 | User ID and amount required | Missing fields |
| 400 | Provide bank details or UPI ID | No payment method |
| 400 | Insufficient balance | Amount exceeds wallet balance |
| 404 | Wallet not found | User has no wallet |

---

### 3.4 Wallet History

**Endpoint:** `wallet_history.php`  
**Method:** `POST`

Fetch combined transaction history (deposits, withdrawals, and bets sorted by date).

#### Request

```json
{
    "user_id": 1
}
```

#### Success Response (200)

```json
{
    "status": 200,
    "message": "Success",
    "data": [
        {
            "type": "deposit",
            "amount": 500.00,
            "status": 1,
            "status_text": "Approved",
            "note": "",
            "method": "Manual",
            "date": "15 Jan 2026, 10:30 AM"
        },
        {
            "type": "withdrawal",
            "amount": 500.00,
            "status": 0,
            "status_text": "Pending",
            "note": "",
            "method": "UPI",
            "date": "14 Jan 2026, 03:15 PM"
        },
        {
            "type": "bet",
            "amount": 100.00,
            "status": 0,
            "status_text": "Pending",
            "note": "Morning Bazar - Type 1 (5)",
            "method": "Game Bet",
            "date": "13 Jan 2026, 09:15 AM"
        }
    ]
}
```

> **Status mapping:** `0` = Pending, `1` = Approved/Won, `2` = Rejected/Lost

#### Error Responses

| Status | Message | Description |
|--------|---------|-------------|
| 400 | User ID required | Missing user_id |

---

## 🎯 4. Markets

---

### 4.1 Get Game Markets (Bazars)

**Endpoint:** `get_game_market.php`  
**Method:** `GET`

Fetch all active game markets with their open/close times and current status.

#### Success Response (200)

```json
{
    "status": 1,
    "data": [
        {
            "id": 1,
            "name": "Morning Bazar",
            "start_time": "09:00:00",
            "end_time": "12:00:00",
            "time": "09:00 AM - 12:00 PM",
            "status": "Open"
        },
        {
            "id": 2,
            "name": "Mumbai Bazar",
            "start_time": "12:00:00",
            "end_time": "15:00:00",
            "time": "12:00 PM - 03:00 PM",
            "status": "Closed"
        }
    ]
}
```

> **`status` field** is dynamic: `"Open"` if current time is between `start_time` and `end_time`, otherwise `"Closed"`.
>
> Timezone: **Asia/Kolkata** (IST)

---

### 4.2 Get Bet Types

**Endpoint:** `get_bet_types.php`  
**Method:** `GET`

Fetch all 18 available bet types with their input format details.

#### Success Response (200)

```json
{
    "status": 200,
    "message": "Success",
    "data": [
        {
            "id": 1,
            "name": "Single Digit",
            "format": "1 digit (0-9)",
            "type": "digit",
            "digits": 1
        },
        {
            "id": 2,
            "name": "Single Digit Bulk",
            "format": "Comma-separated single digits",
            "type": "bulk",
            "digits": 0
        },
        {
            "id": 3,
            "name": "Jodi Digits",
            "format": "2 digits (00-99)",
            "type": "digit",
            "digits": 2
        }
    ]
}
```

#### Complete Bet Types Reference

| ID | Name | Format | Input Type | Digits |
|----|------|--------|------------|--------|
| 1 | Single Digit | 1 digit (0-9) | `digit` | 1 |
| 2 | Single Digit Bulk | Comma-separated single digits | `bulk` | 0 |
| 3 | Jodi Digits | 2 digits (00-99) | `digit` | 2 |
| 4 | Jodi Digits Bulk | Comma-separated 2-digit pairs | `bulk` | 0 |
| 5 | Single Pana | 3 digits (000-999) | `digit` | 3 |
| 6 | Single Pana Bulk | Comma-separated 3-digit numbers | `bulk` | 0 |
| 7 | Double Pana | 2 digits (00-99) | `digit` | 2 |
| 8 | Double Pana Bulk | Comma-separated 2-digit numbers | `bulk` | 0 |
| 9 | Triple Pana | 3 digits (000-999) | `digit` | 3 |
| 10 | Sangram | 4-digit number | `digit` | 4 |
| 11 | SP Motor | 2-digit number | `digit` | 2 |
| 12 | Jodi Pana | 2 digits (00-99) | `digit` | 2 |
| 13 | Jodi Pana Bulk | Comma-separated 2-digit numbers | `bulk` | 0 |
| 14 | Odd / Even | Select Odd or Even | `text` | 0 |
| 15 | Big / Small | Select Big or Small | `text` | 0 |
| 16 | Half Sangram | 2-digit number | `digit` | 2 |
| 17 | Full Sangram | 4-digit number | `digit` | 4 |
| 18 | Motor | Comma-separated numbers (1-4 digit each) | `bulk` | 0 |

**Input Type Guide:**
- `digit` — Enter a fixed-digit number (digits field tells you how many)
- `bulk` — Enter comma-separated values (e.g., `1,5,7,3`)
- `text` — Pick from predefined options (Odd/Even or Big/Small)

---

## 🎲 5. Betting

---

### 5.1 Place Bet

**Endpoint:** `place_bet.php`  
**Method:** `POST`

Place a bet on a market. Amount is deducted from wallet immediately.

#### Request

```json
{
    "user_id": 1,
    "market_id": 1,
    "session": "open",
    "game_type": 1,
    "number": "5",
    "amount": 100
}
```

> **Note on `session`:** Use `"open"` or `"close"` (lowercase). Match with what the market offers.

#### Success Response (200)

```json
{
    "status": 1,
    "message": "Bet placed successfully",
    "data": {
        "bet_id": 7,
        "amount": 100,
        "game_type": 1,
        "number": "5"
    }
}
```

#### Error Responses

| Status | Message | Description |
|--------|---------|-------------|
| 0 | All fields required | Missing required fields |
| 0 | Market not found or inactive | Invalid market_id |
| 0 | Market is currently closed | Outside market hours |
| 0 | Insufficient balance | Not enough wallet funds |
| 0 | Failed to deduct balance | Wallet deduction failed |
| 0 | Failed to place bet | Database error (amount refunded) |

> **Important:** If the bet insert fails after deducting the wallet, the amount is **automatically refunded**.

---

### 5.2 Get Bet History

**Endpoint:** `get_bet_history.php`  
**Method:** `POST`

Fetch the user's bet history (last 50 bets).

#### Request

```json
{
    "user_id": 1
}
```

#### Success Response (200)

```json
{
    "status": 200,
    "message": "Success",
    "data": [
        {
            "id": 1,
            "market": "Morning Bazar",
            "session": "OPEN",
            "game_type": 1,
            "number": "5",
            "amount": 100.00,
            "status": 0,
            "status_text": "Pending",
            "date": "13 Jan 2026, 09:15 AM"
        }
    ]
}
```

> **Status mapping:** `0` = Pending, `1` = Won, `2` = Lost

#### Error Responses

| Status | Message | Description |
|--------|---------|-------------|
| 400 | User ID required | Missing user_id |

---

## 📊 6. Results

---

### 6.1 Get Published Results

**Endpoint:** `get_published_results.php`  
**Method:** `POST`

Fetch published results. Optionally filter by market.

#### Request (All Markets)

```json
{
    "market_id": 0
}
```

#### Request (Specific Market)

```json
{
    "market_id": 1
}
```

> Set `market_id: 0` to get results for all markets. Use a specific ID to filter by market.

#### Success Response (200)

```json
{
    "status": 1,
    "message": "Success",
    "data": [
        {
            "id": 1,
            "market": "Morning Bazar",
            "session": "OPEN",
            "game_type": 1,
            "result": "5",
            "date": "13 Jan 2026, 09:30 AM"
        }
    ]
}
```

#### Error Responses

None — always returns `status: 1` with `data` array (may be empty if no results).

---

## 🏗️ Error Response Format

All endpoints return errors in this standard format:

```json
{
    "status": 400,
    "message": "Description of what went wrong"
}
```

### Common HTTP Status Codes

| Code | Meaning |
|------|---------|
| 200 | Success |
| 400 | Bad request (missing/invalid parameters) |
| 401 | Unauthorized (wrong password/MPin) |
| 403 | Forbidden (account inactive) |
| 404 | Not found (user/market doesn't exist) |
| 409 | Conflict (duplicate email/phone) |
| 500 | Server error (database issue) |

---

## 🔄 Quick Integration Guide

### Step 1: User Registration
```
POST register.php  →  Get user_id
```

### Step 2: Login
```
POST login.php     →  Get token, mpin_set status
  ├─ Optional: POST set_mpin.php  →  Set 4-6 digit MPin
  └─ Later: POST mpin_login.php   →  Quick login with MPin
```

### Step 3: Load Home Screen
```
POST get_profile.php         →  Name, wallet balance, mpin status
GET  get_game_market.php     →  List markets with Open/Closed status
GET  get_bet_types.php       →  List all 18 bet types
```

### Step 4: Place a Bet
```
POST place_bet.php           →  Deducts wallet, creates bet
```

### Step 5: Check History
```
POST get_bet_history.php     →  User's bet history
POST wallet_history.php      →  Combined deposits + withdrawals + bets
```

### Step 6: Deposit / Withdraw
```
POST add_money.php           →  Submit deposit (Manual or Automatic)
POST withdraw_request.php    →  Submit withdrawal request
POST get_wallet.php          →  Check updated balance
```

---

> **Last Updated:** 26 July 2026
