# Betting App — Full API Documentation

> **Base URL:** `https://saptahikgyan.space/admin/api/app/`
> **Auth:** Bearer Token (stored as `USER_TOKEN` in `GetStorage`)
> **Content-Type:** `multipart/form-data` (via `Dio.FormData`)
> **Timeouts:** 30s send / 30s receive

---

## Table of Contents

1. [Authentication](#1-authentication)
2. [Home / Markets](#2-home--markets)
3. [Game & Betting](#3-game--betting)
4. [Current Bets](#4-current-bets)
5. [Bet History](#5-bet-history)
6. [Results](#6-results)
7. [Wallet](#7-wallet)
8. [Bank Details](#8-bank-details)
9. [Account Statement](#9-account-statement)
10. [Support](#10-support)
11. [Full User Flow](#11-full-user-flow)
12. [App Screens & Route Map](#12-app-screens--route-map)

---

## 1. Authentication

### 1.1 Login
```
POST {BASE_URL}login
```
**Description:** Authenticate user with phone/email and password.

**Request Body:**
| Field      | Type   | Required | Description          |
|------------|--------|----------|----------------------|
| `email`    | String | Yes      | Phone or Email       |
| `password` | String | Yes      | User password        |

**Response:**
```json
{
  "status": true,
  "message": "Login successful",
  "data": {
    "token": "Bearer xxx...",
    "user_id": "123",
    "user_name": "John",
    "user_email": "john@example.com",
    "wallet_balance": 5000.00
  }
}
```

**Stored to `GetStorage`:**
| Key                 | Source Field |
|---------------------|-------------|
| `USER_TOKEN`        | `data.token` |
| `USER_ID`           | `data.user_id` |
| `USER_NAME`         | `data.user_name` |
| `USER_EMAIL`        | `data.user_email` |
| `IS_USER_LOGGED_IN` | `true` |

---

### 1.2 Sign Up / Register
```
POST {BASE_URL}register
```
**Description:** Create a new user account.

**Request Body:**
| Field                 | Type   | Required | Description             |
|-----------------------|--------|----------|-------------------------|
| `name`                | String | Yes      | Full name               |
| `phone`               | String | Yes      | Phone number            |
| `email`               | String | Yes      | Email address           |
| `password`            | String | Yes      | Password                |
| `confirm_password`    | String | Yes      | Confirm password        |
| `referral_code`       | String | No       | Referral code (optional)|

**Response:**
```json
{
  "status": true,
  "message": "Account created successfully"
}
```

---

### 1.3 MPIN Login
```
POST {BASE_URL}mpin-login
```
**Description:** Login using 4-digit MPIN.

**Request Body:**
| Field  | Type   | Required | Description       |
|--------|--------|----------|-------------------|
| `mpin` | String | Yes      | 4-digit MPIN code |

**Response:**
```json
{
  "status": true,
  "message": "MPIN Login successful",
  "data": {
    "token": "Bearer xxx..."
  }
}
```

---

### 1.4 Set/Change MPIN
```
POST {BASE_URL}set-mpin
```
**Description:** Set or change the 4-digit MPIN.

**Request Body:**
| Field       | Type   | Required | Description          |
|-------------|--------|----------|----------------------|
| `mpin`      | String | Yes      | New 4-digit MPIN     |
| `old_mpin`  | String | No       | Required for change  |

---

### 1.5 Biometric Login
```
POST {BASE_URL}biometric-login
```
**Description:** Login using device biometric authentication.

**Headers:** `Authorization: Bearer {token}`

**Response:**
```json
{
  "status": true,
  "message": "Biometric login successful"
}
```

---

### 1.6 Logout
```
POST {BASE_URL}logout
```
**Description:** Invalidate user session and clear stored data.

**Headers:** `Authorization: Bearer {token}`

**Response:**
```json
{
  "status": true,
  "message": "Logged out successfully"
}
```

---

## 2. Home / Markets

### 2.1 Get Markets List
```
GET {BASE_URL}markets
```
**Description:** Fetch all active betting markets.

**Headers:** `Authorization: Bearer {token}`

**Response:**
```json
{
  "status": true,
  "data": [
    {
      "id": 1,
      "name": "SITA MORNING",
      "result": "579-12-228",
      "status": "Betting Is Closed For Today",
      "openTime": "9:40 AM",
      "closeTime": "10:40 AM",
      "is_active": true
    },
    {
      "id": 2,
      "name": "STAR TARA MORNING",
      "result": "590-47-359",
      "status": "Betting Is Closed For Today",
      "openTime": "10:05 AM",
      "closeTime": "11:05 AM",
      "is_active": true
    },
    {
      "id": 3,
      "name": "ANDHRA MORNING",
      "result": "290-18-116",
      "status": "Betting Is Closed For Today",
      "openTime": "10:35 AM",
      "closeTime": "11:35 AM",
      "is_active": true
    },
    {
      "id": 4,
      "name": "SRIDEVI",
      "result": "145-67-890",
      "status": "Betting Is Closed For Today",
      "openTime": "11:45 AM",
      "closeTime": "12:45 PM",
      "is_active": true
    }
  ]
}
```

---

### 2.2 Get Wallet Balance
```
GET {BASE_URL}wallet-balance
```
**Description:** Get the current user's wallet balance.

**Headers:** `Authorization: Bearer {token}`

**Response:**
```json
{
  "status": true,
  "data": {
    "balance": 5000.00
  }
}
```

---

### 2.3 Get Announcements
```
GET {BASE_URL}announcements
```
**Description:** Fetch latest announcements/banners.

**Headers:** `Authorization: Bearer {token}`

**Response:**
```json
{
  "status": true,
  "data": [
    {
      "id": 1,
      "title": "Minimum Deposit Starts From ₹100",
      "message": "Deposit now and start playing!",
      "type": "info"
    }
  ]
}
```

---

## 3. Game & Betting

### 3.1 Get Market Details
```
GET {BASE_URL}market-details/{market_id}
```
**Description:** Fetch detailed information for a specific market.

**Headers:** `Authorization: Bearer {token}`

**Response:**
```json
{
  "status": true,
  "data": {
    "id": 1,
    "name": "SITA MORNING",
    "openTime": "9:40 AM",
    "closeTime": "10:40 AM",
    "status": "open",
    "result": null
  }
}
```

---

### 3.2 Get Bet Types
```
GET {BASE_URL}bet-types
```
**Description:** Fetch available bet types for a market.

**Headers:** `Authorization: Bearer {token}`

**Response:**
```json
{
  "status": true,
  "data": [
    {"id": 1, "name": "Single Digit",      "key": "singleDigit"},
    {"id": 2, "name": "Single Digit Bulk", "key": "singleDigitBulk"},
    {"id": 3, "name": "Jodi Digits",       "key": "jodiDigits"},
    {"id": 4, "name": "Jodi Digits Bulk",  "key": "jodiDigitsBulk"},
    {"id": 5, "name": "Single Pana",       "key": "singlePana"},
    {"id": 6, "name": "Single Pana Bulk",  "key": "singlePanaBulk"},
    {"id": 7, "name": "Double Pana",       "key": "doublePana"},
    {"id": 8, "name": "Double Pana Bulk",  "key": "doublePanaBulk"},
    {"id": 9, "name": "Triple Pana",       "key": "triplePana"},
    {"id": 10, "name": "Sangram",          "key": "sangram"},
    {"id": 11, "name": "SP Motor",         "key": "spMotor"},
    {"id": 12, "name": "Jodi Pana",        "key": "jodiPana"},
    {"id": 13, "name": "Jodi Pana Bulk",   "key": "jodiPanaBulk"},
    {"id": 14, "name": "Odd / Even",       "key": "oddEven"},
    {"id": 15, "name": "Big / Small",      "key": "bigSmall"},
    {"id": 16, "name": "Half Sangam",      "key": "halfSangam"},
    {"id": 17, "name": "Full Sangam",      "key": "fullSangam"},
    {"id": 18, "name": "Motor",            "key": "motor"}
  ]
}
```

---

### 3.3 Place Bet
```
POST {BASE_URL}place-bet
```
**Description:** Place one or more bets on a market.

**Headers:** `Authorization: Bearer {token}`

**Request Body:**
| Field       | Type  | Required | Description                          |
|-------------|-------|----------|--------------------------------------|
| `market_id` | Int   | Yes      | Market ID                            |
| `bets`      | Array | Yes      | Array of bet objects (see below)     |

**Bet Object:**
| Field    | Type   | Required | Description                                      |
|----------|--------|----------|--------------------------------------------------|
| `type`   | String | Yes      | Bet type key (e.g. `singleDigit`, `jodiDigits`)  |
| `number` | String | Yes      | Selected number(s)                                |
| `amount` | Double | Yes      | Bet amount                                       |

**Example Request:**
```json
{
  "market_id": 1,
  "bets": [
    {"type": "singleDigit", "number": "7", "amount": 500},
    {"type": "jodiDigits",  "number": "47", "amount": 200}
  ]
}
```

**Response:**
```json
{
  "status": true,
  "message": "Bet(s) placed successfully",
  "data": {
    "total_bets": 2,
    "total_amount": 700.00,
    "wallet_balance": 4300.00
  }
}
```

---

### 3.4 Pana Chart Data
```
GET {BASE_URL}pana-chart
```
**Description:** Fetch Pana chart reference data for Single Pana, Double Pana, and Triple Pana selection.

**Headers:** `Authorization: Bearer {token}`

**Query Parameters:**
| Parameter | Type   | Required | Description                         |
|-----------|--------|----------|-------------------------------------|
| `type`    | String | Yes      | `single`, `double`, or `triple`     |
| `family`  | Int    | No       | Family digit (0-9) for filtering    |

**Response:**
```json
{
  "status": true,
  "data": {
    "type": "single",
    "family_digit": 0,
    "panas": ["019", "028", "037", "046", "055", "064", "073", "082", "091"]
  }
}
```

---

## 4. Current Bets

### 4.1 Get Current Bets
```
GET {BASE_URL}current-bets
```
**Description:** Fetch all active (unsettled) bets for the logged-in user.

**Headers:** `Authorization: Bearer {token}`

**Response:**
```json
{
  "status": true,
  "data": [
    {
      "id": 101,
      "game": "SITA MORNING",
      "type": "Single Digit",
      "number": "7",
      "amount": 500,
      "status": "Active",
      "time": "10:30 AM",
      "market_id": 1
    },
    {
      "id": 102,
      "game": "STAR TARA MORNING",
      "type": "Jodi Digit",
      "number": "47",
      "amount": 200,
      "status": "Active",
      "time": "11:00 AM",
      "market_id": 2
    }
  ]
}
```

---

### 4.2 Cancel Bet
```
POST {BASE_URL}cancel-bet
```
**Description:** Cancel a specific bet before market closing.

**Headers:** `Authorization: Bearer {token}`

**Request Body:**
| Field   | Type | Required | Description |
|---------|------|----------|-------------|
| `bet_id`| Int  | Yes      | Bet ID      |

**Response:**
```json
{
  "status": true,
  "message": "Bet cancelled successfully",
  "data": {
    "refund_amount": 500,
    "wallet_balance": 4800.00
  }
}
```

---

## 5. Bet History

### 5.1 Get Bet History
```
GET {BASE_URL}bet-history
```
**Description:** Fetch all settled/completed bets for the user, with win/loss status.

**Headers:** `Authorization: Bearer {token}`

**Query Parameters:**
| Parameter | Type   | Required | Description                          |
|-----------|--------|----------|--------------------------------------|
| `page`    | Int    | No       | Page number (default: 1)            |
| `limit`   | Int    | No       | Items per page (default: 20)        |
| `status`  | String | No       | Filter: `won`, `lost`, `all`        |

**Response:**
```json
{
  "status": true,
  "data": [
    {
      "id": 201,
      "game": "SITA MORNING",
      "type": "Single Digit",
      "value": "7",
      "amount": 500,
      "profit": 4500,
      "status": "Won",
      "date": "2024-12-15",
      "time": "10:30 AM"
    },
    {
      "id": 202,
      "game": "STAR TARA MORNING",
      "type": "Jodi Digit",
      "value": "47",
      "amount": 200,
      "profit": -200,
      "status": "Lost",
      "date": "2024-12-15",
      "time": "11:00 AM"
    }
  ],
  "meta": {
    "total": 50,
    "page": 1,
    "limit": 20,
    "total_pages": 3
  },
  "summary": {
    "total_invested": 2400.00,
    "total_profit": 18300.00,
    "total_won": 3,
    "total_lost": 3
  }
}
```

---

## 6. Results

### 6.1 Get Results
```
GET {BASE_URL}results
```
**Description:** Fetch declared results for all markets.

**Headers:** `Authorization: Bearer {token}`

**Query Parameters:**
| Parameter | Type   | Required | Description                          |
|-----------|--------|----------|--------------------------------------|
| `date`    | String | No       | Filter by date (YYYY-MM-DD)          |
| `market`  | String | No       | Filter by market name                |

**Response:**
```json
{
  "status": true,
  "data": [
    {
      "game": "SITA MORNING",
      "open": "7",
      "close": "4",
      "jodi": "74",
      "pana": "579",
      "date": "2024-12-15"
    },
    {
      "game": "STAR TARA MORNING",
      "open": "2",
      "close": "8",
      "jodi": "28",
      "pana": "590",
      "date": "2024-12-15"
    }
  ]
}
```

---

## 7. Wallet

### 7.1 Add Fund (UPI Auto)
```
POST {BASE_URL}add-fund
```
**Description:** Initiate a UPI deposit.

**Headers:** `Authorization: Bearer {token}`

**Request Body:**
| Field  | Type   | Required | Description                    |
|--------|--------|----------|--------------------------------|
| `amount` | Double | Yes    | Deposit amount (min ₹100)      |

**Response:**
```json
{
  "status": true,
  "data": {
    "upi_id": "matkaapp@upi",
    "upi_name": "MATKA GAMES",
    "amount": 1000,
    "qr_code_url": "https://...",
    "expires_at": "2024-12-15T12:00:00Z"
  }
}
```

---

### 7.2 Manual Deposit (Upload Screenshot)
```
POST {BASE_URL}manual-deposit
```
**Description:** Submit a manual deposit request with payment proof.

**Headers:** `Authorization: Bearer {token}`
**Content-Type:** `multipart/form-data`

**Request Body:**
| Field          | Type   | Required | Description                           |
|----------------|--------|----------|---------------------------------------|
| `amount`       | Double | Yes      | Deposit amount (min ₹100)             |
| `transaction_id` | String | Yes    | Transaction ID / UTR number           |
| `screenshot`   | File   | Yes      | Payment screenshot (PNG/JPG, max 5MB) |

**Response:**
```json
{
  "status": true,
  "message": "Deposit request submitted for verification",
  "data": {
    "deposit_id": 301,
    "amount": 1000,
    "status": "Pending"
  }
}
```

---

### 7.3 Withdraw Funds
```
POST {BASE_URL}withdraw
```
**Description:** Request a withdrawal to saved bank account.

**Headers:** `Authorization: Bearer {token}`

**Request Body:**
| Field              | Type   | Required | Description                      |
|--------------------|--------|----------|----------------------------------|
| `amount`           | Double | Yes      | Withdrawal amount (min ₹500)     |
| `bank_account_id`  | Int    | Yes      | Saved bank account ID            |

**Response:**
```json
{
  "status": true,
  "message": "Withdrawal request submitted. Amount will be credited within 24 hours.",
  "data": {
    "withdrawal_id": 401,
    "amount": 2000,
    "status": "Pending",
    "wallet_balance": 3000.00
  }
}
```

---

### 7.4 Deposit History
```
GET {BASE_URL}deposit-history
```
**Description:** Fetch deposit transaction history.

**Headers:** `Authorization: Bearer {token}`

**Query Parameters:**
| Parameter | Type   | Required | Description                      |
|-----------|--------|----------|----------------------------------|
| `page`    | Int    | No       | Page number                     |
| `limit`   | Int    | No       | Items per page                  |

**Response:**
```json
{
  "status": true,
  "data": [
    {
      "amount": 1000,
      "method": "UPI",
      "status": "Completed",
      "date": "2024-12-15",
      "time": "10:30 AM",
      "txnId": "TXN001"
    },
    {
      "amount": 500,
      "method": "Net Banking",
      "status": "Pending",
      "date": "2024-12-14",
      "time": "2:15 PM",
      "txnId": "TXN002"
    }
  ],
  "meta": {
    "total": 10,
    "page": 1,
    "limit": 20
  }
}
```

---

### 7.5 Withdrawal History
```
GET {BASE_URL}withdrawal-history
```
**Description:** Fetch withdrawal transaction history.

**Headers:** `Authorization: Bearer {token}`

**Query Parameters:**
| Parameter | Type   | Required | Description                      |
|-----------|--------|----------|----------------------------------|
| `page`    | Int    | No       | Page number                     |
| `limit`   | Int    | No       | Items per page                  |

**Response:**
```json
{
  "status": true,
  "data": [
    {
      "amount": 2000,
      "method": "Bank Transfer",
      "status": "Completed",
      "date": "2024-12-14",
      "time": "3:30 PM",
      "bank": "HDFC Bank • XXXX1234"
    },
    {
      "amount": 500,
      "method": "Bank Transfer",
      "status": "Pending",
      "date": "2024-12-13",
      "time": "11:20 AM",
      "bank": "HDFC Bank • XXXX1234"
    }
  ],
  "meta": {
    "total": 8,
    "page": 1,
    "limit": 20
  }
}
```

---

## 8. Bank Details

### 8.1 Add Bank Details
```
POST {BASE_URL}add-bank-details
```
**Description:** Save a new bank account for withdrawals.

**Headers:** `Authorization: Bearer {token}`

**Request Body:**
| Field             | Type   | Required | Description                       |
|-------------------|--------|----------|-----------------------------------|
| `account_holder`  | String | Yes      | Account holder name               |
| `account_number`  | String | Yes      | Bank account number (min 9 chars) |
| `confirm_account` | String | Yes      | Re-enter account number           |
| `ifsc_code`       | String | Yes      | IFSC code (min 11 chars)          |
| `bank_name`       | String | Yes      | Bank name                         |
| `upi_id`          | String | No       | UPI ID (optional)                 |

**Response:**
```json
{
  "status": true,
  "message": "Bank details saved successfully",
  "data": {
    "bank_id": 501,
    "bank_name": "HDFC Bank",
    "account_number": "XXXX1234"
  }
}
```

---

### 8.2 Get Saved Banks
```
GET {BASE_URL}saved-banks
```
**Description:** Fetch all saved bank accounts.

**Headers:** `Authorization: Bearer {token}`

**Response:**
```json
{
  "status": true,
  "data": [
    {
      "id": 501,
      "bank_name": "HDFC Bank",
      "account_number": "XXXX1234",
      "ifsc": "HDFC0001234",
      "account_holder": "John Doe",
      "is_default": true
    }
  ]
}
```

---

### 8.3 Delete Bank Account
```
DELETE {BASE_URL}saved-banks/{bank_id}
```
**Description:** Remove a saved bank account.

**Headers:** `Authorization: Bearer {token}`

**Response:**
```json
{
  "status": true,
  "message": "Bank account removed successfully"
}
```

---

## 9. Account Statement

### 9.1 Get Account Statement
```
GET {BASE_URL}account-statement
```
**Description:** Fetch complete account transaction statement (all deposits, withdrawals, bets).

**Headers:** `Authorization: Bearer {token}`

**Query Parameters:**
| Parameter | Type   | Required | Description                          |
|-----------|--------|----------|--------------------------------------|
| `page`    | Int    | No       | Page number                         |
| `limit`   | Int    | No       | Items per page                      |
| `from`    | String | No       | Start date (YYYY-MM-DD)             |
| `to`      | String | No       | End date (YYYY-MM-DD)               |
| `type`    | String | No       | Filter: `deposit`, `withdrawal`, `bet`, `all` |

**Response:**
```json
{
  "status": true,
  "data": [
    {
      "id": "TXN001",
      "type": "deposit",
      "amount": 1000,
      "balance_after": 5000,
      "description": "UPI Deposit",
      "status": "Completed",
      "date": "2024-12-15",
      "time": "10:30 AM"
    },
    {
      "id": "BET101",
      "type": "bet",
      "amount": -500,
      "balance_after": 4500,
      "description": "SITA MORNING • Single Digit #7",
      "status": "Active",
      "date": "2024-12-15",
      "time": "10:25 AM"
    }
  ],
  "meta": {
    "total": 100,
    "page": 1,
    "limit": 20
  },
  "summary": {
    "total_deposits": 5000,
    "total_withdrawals": 2000,
    "total_bets": 1200,
    "total_winnings": 4500
  }
}
```

---

## 10. Support

### 10.1 WhatsApp Support (External)
```
External: https://wa.me/{whatsapp_number}
```
**Description:** Opens WhatsApp chat with support agent.

| Parameter        | Value           |
|------------------|-----------------|
| WhatsApp Number  | `+918239784975` |

No API endpoint — uses the `url_launcher` package to open WhatsApp externally.

---

## 11. Full User Flow

```
                    ┌─────────────────────────────────────────────────────────┐
                    │                    USER FLOW                             │
                    └─────────────────────────────────────────────────────────┘

  ┌──────────┐     ┌──────────┐     ┌───────────┐     ┌───────────────┐
  │  LOGIN   │ ──> │  MPIN    │ ──> │  HOME     │ ──> │  SELECT       │
  │  Page    │     │  LOGIN   │     │  (Markets)│     │  MARKET       │
  └──────────┘     └──────────┘     └───────────┘     └───────┬───────┘
       │                                  ▲                    │
       │  ┌──────────┐                   │                    │
       └─>│ SIGN UP  │                   │                    │
          └──────────┘                   │                    ▼
                                    ┌────┴────┐        ┌──────────────┐
                                    │ WALLET  │        │  GAME PAGE   │
                                    │ BALANCE │        │  (Bet Types) │
                                    └────┬────┘        └──────┬───────┘
                                         │                    │
                                         ▼                    ▼
                                  ┌──────────────┐     ┌───────────────┐
                                  │  ADD FUND    │     │  BET INPUT    │
                                  │  │ Manual    │     │  PAGE         │
                                  │  │ UPI       │     │  (Num+Amount) │
                                  └──────┬───────┘     └───────┬───────┘
                                         │                    │
                                         ▼                    ▼
                                  ┌──────────────┐     ┌───────────────┐
                                  │ DEPOSIT      │     │  BET SLIP     │
                                  │ HISTORY      │     │  (Review)     │
                                  └──────────────┘     └───────┬───────┘
                                         │                    │
                                         │                    ▼
                                         │            ┌───────────────┐
                                         │            │  PLACE BET    │
                                         │            │  (API Call)   │
                                         │            └───────┬───────┘
                                         │                    │
                                         ▼                    ▼
                                  ┌────────────────────────────────────┐
                                  │         BET CONFIRMED!            │
                                  │  "Bet Placed" Dialog with count   │
                                  └────────────────────────────────────┘
                                         │
                                         ▼
                                  ┌──────────────┐
                                  │  CURRENT     │
                                  │  BETS (Tab)  │
                                  └──────┬───────┘
                                         │
                                    [Market Closes]
                                         │
                                         ▼
                                  ┌──────────────┐     ┌──────────────┐
                                  │  RESULT      │ ──> │  HISTORY     │
                                  │  DECLARED    │     │  (Win/Loss)  │
                                  └──────────────┘     └──────┬───────┘
                                         │                    │
                                         │                    ▼
                                         │            ┌──────────────┐
                                         │            │  WALLET      │
                                         │            │  UPDATE      │
                                         │            └──────────────┘
                                         │
                                    [Tab Navigation]
                                         ▼
  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐
  │   HOME       │  │   RESULTS    │  │   HISTORY    │  │   CURRENT    │
  │  (Markets)   │  │  (All Res.)  │  │  (Win/Loss)  │  │   BETS       │
  └──────────────┘  └──────────────┘  └──────────────┘  └──────────────┘
```

---

## 12. App Screens & Route Map

| # | Screen            | Route                  | API Endpoints Used               |
|---|-------------------|------------------------|----------------------------------|
| 1 | Login Page        | `/login-page`          | `login`                          |
| 2 | Sign Up           | `/sign-up-view`        | `register`                       |
| 3 | MPIN Login        | `/mpin-login`          | `mpin-login`                     |
| 4 | Bottom Navigation | `/bottom-navigation`   | — (Tab Container)                |
| 5 | Home              | `/home`                | `markets`, `wallet-balance`, `announcements` |
| 6 | Game Page         | `/game-page`           | `market-details`, `bet-types`    |
| 7 | Bet Input Page    | `/bet-input`           | `pana-chart`                     |
| 8 | Place Bet         | (From Bet Input)       | `place-bet`                      |
| 9 | All Bids          | `/all-bids`            | —                                |
| 10| Current Bets      | (Tab/Bottom Nav)       | `current-bets`, `cancel-bet`     |
| 11| Results           | (Tab/Bottom Nav)       | `results`                        |
| 12| History           | (Tab/Bottom Nav)       | `bet-history`                    |
| 13| Wallet            | `/wallet`              | `wallet-balance`                 |
| 14| Add Fund          | `/add-fund`            | `add-fund`                       |
| 15| Manual Deposit    | `/manual-deposit`      | `manual-deposit`                 |
| 16| Withdraw Funds    | `/withdraw-funds`      | `withdraw`                       |
| 17| Deposit History   | `/deposit-history`     | `deposit-history`                |
| 18| Withdrawal History| `/withdrawal-history`  | `withdrawal-history`             |
| 19| Add Bank Details  | `/add-bank-details`    | `add-bank-details`               |
| 20| Account Statement | `/account-statement`   | `account-statement`              |
| 21| Terms & Conditions| `/terms-conditions`    | — (Static Page)                  |
| 22| Rules             | `/rules`               | — (Static Page)                  |
| 23| Support           | (From Home)            | WhatsApp External                |
| 24| Bet Slip          | (Overlay)              | Managed via `BetSlipService`     |

---

## API Service Layer Reference

The app uses three core HTTP methods defined in `lib/app/data/my_dio.dart`:

### `dioGet(endUrl)`
- **Method:** GET
- **Headers:** `Authorization: Bearer {token}`
- **Returns:** `DIO.Response`

### `dioPost({data, endUrl, isFile})`
- **Method:** POST
- **Headers:** `Authorization: Bearer {token}`
- **Body:** `FormData` (multipart)
- **Returns:** `DIO.Response`

### `dioDelete(endUrl)`
- **Method:** DELETE
- **Headers:** `Authorization: Bearer {token}`
- **Returns:** `DIO.Response`

### Error Handling
All three methods have a `try/catch` fallback that returns:
```json
{
  "statusCode": 500,
  "statusMessage": "Something went wrong",
  "data": {"message": "Something went wrong"}
}
```

### Debug Logging
When `isDebugMode.value == true`, all API calls log:
- Full URL
- Headers (Authorization token)
- Status code
- Response body

---

## Environment Configuration

Defined in `lib/app/Config/app_config.dart`:

| Key               | Value                                        |
|-------------------|----------------------------------------------|
| `BASE_URL`        | `https://saptahikgyan.space/admin/api/app/`  |
| `USER_TOKEN`      | Key for storing auth token                   |
| `USER_ID`         | Key for storing user ID                      |
| `USER_NAME`       | Key for storing user name                    |
| `USER_EMAIL`      | Key for storing user email                   |
| `IS_USER_LOGGED_IN` | Key for login state flag                   |
| `isDebugMode`     | Toggle API logging (default: `true`)         |

---

*Document generated from complete app source code analysis.*
*Base URL: `https://saptahikgyan.space/admin/api/app/`*
