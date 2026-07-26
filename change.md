# Change — 2-Minute Betting Window

## What Changed

When a market's closing time is less than 2 minutes away, users **cannot place bets**.

### Files Changed

**1. `api/app/place_bet.php`** — New check added after market-open validation
```php
if ($mins_until_close < 2) {
    echo json_encode(["status" => 0, "message" => "Betting closed - market closes in less than 2 minutes"]);
    exit;
}
```

**2. `api/app/get_game_market.php`** — New `can_bet` field in response
```php
"can_bet": true   // false if < 2 min to end_time
```

### App Implementation

**Market List** — Use the new `can_bet` field:
```json
// get_game_market.php now returns:
{
  "id": 1,
  "name": "Morning Bazar",
  "start_time": "09:00:00",
  "end_time": "12:00:00",
  "time": "09:00 AM - 12:00 PM",
  "status": "Open",
  "can_bet": true   // ← NEW — disable bet button when false
}
```

**Place Bet** — Handle new error:
```json
// place_bet.php may now return:
{ "status": 0, "message": "Betting closed - market closes in less than 2 minutes" }
```

### Logic Summary

| Time | `status` | `can_bet` |
|------|----------|-----------|
| Before `start_time` | `"Closed"` | `false` |
| During window (≥ 2 min to end) | `"Open"` | `true` |
| Last **2 minutes** before `end_time` | `"Open"` | `false` |
| After `end_time` | `"Closed"` | `false` |

### Flutter: What To Do

1. Parse `can_bet` from `get_game_market.php` → disable Place Bet button when `false`
2. Handle `"less than 2 minutes"` error from `place_bet.php`
3. Show appropriate UI:
   - `can_bet: true` → button enabled, text: "Place Bet"
   - `can_bet: false` + `status: "Open"` → button disabled, text: "Closing Soon"
   - `status: "Closed"` → button disabled, text: "Betting Closed"
