# 🚫 REST APIs — Present in App Design but NOT in `app_documentation.md`

> **Base URL:** `https://saptahikgyan.space/admin/api/app/`

These endpoints are used by the app UI/screens but are **not documented** in `app_documentation.md`.  
They are referenced from the earlier API spec (`API_DOCUMENTATION.md` — now deleted) and from the actual implemented screens.

---

## 📋 Missing APIs Summary

| # | Category | Endpoint | Method | Status |
|---|----------|----------|--------|--------|
| 1 | **Auth** | `logout` | POST | ❌ Not implemented |
| 2 | **Auth** | `biometric-login` | POST | ❌ Not implemented |
| 3 | **Markets** | `market-details/{market_id}` | GET | ❌ Not implemented |
| 4 | **Markets** | `announcements` | GET | ❌ Not implemented |
| 5 | **Betting** | `current-bets` | GET | ❌ Not implemented |
| 6 | **Betting** | `cancel-bet` | POST | ❌ Not implemented |
| 7 | **Betting** | `pana-chart` | GET | ❌ Hardcoded data used |
| 8 | **Bank** | `saved-banks` | GET | ❌ Hardcoded data used |
| 9 | **Bank** | `add-bank-details` | POST | ❌ Not implemented |
| 10 | **Bank** | `saved-banks/{bank_id}` | DELETE | ❌ Not implemented |
| 11 | **Auth** | `forgot_mpin.php` | POST | ❌ Not implemented |

---

## 🔐 1. Authentication

### 1.1 Forgot MPIN

**Endpoint:** `forgot_mpin.php`  
**Method:** `POST`

Reset MPIN when user forgets it. Verifies identity via phone + OTP, then allows setting a new MPIN.

#### Request

```json
{
    "phone": "9876543210",
    "otp": "123456",
    "new_mpin": "5678"
}
```

#### Success Response (200)

```json
{
    "status": 200,
    "message": "MPIN reset successfully"
}
```

#### Error Responses

| Status | Message | Description |
|--------|---------|-------------|
| 400 | Phone, OTP, and new MPIN are required | Missing fields |
| 400 | MPIN must be 4-6 digits only | Bad MPIN format |
| 400 | Invalid or expired OTP | Wrong OTP |
| 404 | User not found | No account with this phone |
| 500 | Failed to reset MPIN | Server error |

---

### 1.2 Logout

**Endpoint:** `logout`  
**Method:** `POST`

Invalidate user session and clear stored data.

**Headers:** `Authorization: Bearer {token}`

**Success Response (200):**
```json
{
  "status": true,
  "message": "Logged out successfully"
}
```

---

### 1.2 Biometric Login

**Endpoint:** `biometric-login`  
**Method:** `POST`

Login using device biometric authentication.

**Headers:** `Authorization: Bearer {token}`

**Response:**
```json
{
  "status": true,
  "message": "Biometric login successful"
}
```

---

## 🎯 2. Markets

### 2.1 Get Market Details

**Endpoint:** `market-details/{market_id}`  
**Method:** `GET`

Fetch detailed information for a specific market.

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

### 2.2 Get Announcements

**Endpoint:** `announcements`  
**Method:** `GET`

Fetch latest announcements/banners.

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

## 🎲 3. Betting

### 3.1 Get Current Bets

**Endpoint:** `current-bets`  
**Method:** `GET`

Fetch all active (unsettled) bets for the logged-in user.

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
    }
  ]
}
```

---

### 3.2 Cancel Bet

**Endpoint:** `cancel-bet`  
**Method:** `POST`

Cancel a specific bet before market closing.

**Headers:** `Authorization: Bearer {token}`

**Request Body:**
```json
{
  "bet_id": 101
}
```

**Success Response:**
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

### 3.3 Pana Chart Data

**Endpoint:** `pana-chart`  
**Method:** `GET`

Fetch Pana chart reference data for Single Pana, Double Pana, and Triple Pana selection.

**Headers:** `Authorization: Bearer {token}`

**Query Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `type` | String | Yes | `single`, `double`, or `triple` |
| `family` | Int | No | Family digit (0-9) for filtering |

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

## 🏦 4. Bank Details

### 4.1 Get Saved Banks

**Endpoint:** `saved-banks`  
**Method:** `GET`

Fetch all saved bank accounts for the user.

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

### 4.2 Add Bank Details

**Endpoint:** `add-bank-details`  
**Method:** `POST`

Save a new bank account for withdrawals.

**Headers:** `Authorization: Bearer {token}`

**Request Body:**
```json
{
  "account_holder": "John Doe",
  "account_number": "123456789012345",
  "confirm_account": "123456789012345",
  "ifsc_code": "HDFC0001234",
  "bank_name": "HDFC Bank",
  "upi_id": "john@paytm"
}
```

**Success Response:**
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

### 4.3 Delete Bank Account

**Endpoint:** `saved-banks/{bank_id}`  
**Method:** `DELETE`

Remove a saved bank account.

**Headers:** `Authorization: Bearer {token}`

**Success Response:**
```json
{
  "status": true,
  "message": "Bank account removed successfully"
}
```

---

## 📊 Integration Priority

| Priority | Endpoint | Reason |
|----------|----------|--------|
| 🔴 High | `current-bets` | Show in Current Bets tab (hardcoded now) |
| 🔴 High | `cancel-bet` | Allow user to cancel bets |
| 🔴 High | `saved-banks` | Required for withdrawal flow |
| 🟡 Medium | `add-bank-details` | Allow user to add new bank accounts |
| 🟡 Medium | `announcements` | Show banners on home screen |
| 🟢 Low | `pana-chart` | Can use hardcoded data (static reference) |
| 🟢 Low | `logout` | Simple session clear (works without API) |
| 🟢 Low | `biometric-login` | Optional feature |
| 🟢 Low | `market-details/{market_id}` | Redundant with main markets endpoint |
| 🟢 Low | `saved-banks/{bank_id}` DELETE | Advanced feature |

---

> **Last Updated:** 26 July 2026
