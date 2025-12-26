# Beautiful Notification System - Usage Guide

A feature-rich FiveM notification system with multiple alert types, smooth animations, and clean API design.

## Quick Start

### Client-Side (Using Exports)

```lua
-- Simple notification
exports["bldr_notify"]:showNotify("error", "Payment Failed", "Insufficient funds")

-- With custom duration (milliseconds)
exports["bldr_notify"]:showNotify("success", "Payment", "Transaction complete", 5000)

-- With location (for police/ems)
exports["bldr_notify"]:showNotify("police", "Alert", "Bank robbery", nil, "Downtown Bank")
```

### Server-Side (Using TriggerClientEvent)

```lua
-- Send to specific player
TriggerClientEvent("bldr_notify:showNotify", playerId, "info", "Title", "Message", 5000)

-- Broadcast to all players
TriggerClientEvent("bldr_notify:showNotify", -1, "success", "Server", "Maintenance complete")

-- Using exports
exports["bldr_notify"]:showNotify(playerId, "error", "Title", "Message", 5000)
exports["bldr_notify"]:broadcastNotify("warning", "Title", "Message", 5000)
```

---

## Notification Types

| Type | Default Title | Default Message | Duration | Usage |
|------|---|---|---|---|
| `error` | Error | An error has occurred | 35s | Failed operations |
| `success` | Success | Operation completed successfully | 30s | Confirmations |
| `info` | Information | Here is some information | 30s | General info |
| `warning` | Warning | Please be careful | 35s | Cautions |
| `police` | Police Alert | Alert dispatched | 40s | Crime/dispatch |
| `ems` | EMS Alert | Emergency response dispatched | 40s | Medical emergencies |
| `news` | Breaking News | Special news broadcast | 37s | Announcements |
| `cityalert` | City Alert | Important city announcement | 38s | City-wide alerts |

---

## Client-Side API

### Main Export: `showNotify`

```lua
exports["bldr_notify"]:showNotify(type, title, message, duration, location)
```

**Parameters:**
- `type` (string): Notification type (error, success, info, warning, police, ems, news, cityalert)
- `title` (string): Notification title (optional, uses default if empty)
- `message` (string): Notification message (optional, uses default if empty)
- `duration` (number): Display duration in milliseconds (optional, uses type default)
- `location` (string): Location string for police/ems alerts (optional)

**Examples:**

```lua
-- Simple error
exports["bldr_notify"]:showNotify("error", "Error", "Payment failed")

-- Success with custom duration (3 seconds)
exports["bldr_notify"]:showNotify("success", "Payment", "Transaction complete", 3000)

-- Police alert with location
exports["bldr_notify"]:showNotify("police", "Robbery", "In progress", nil, "Downtown Bank")

-- Info with defaults
exports["bldr_notify"]:showNotify("info")
```

### Convenience Exports

```lua
-- Error
exports["bldr_notify"]:notifyError(title, message, duration)

-- Success
exports["bldr_notify"]:notifySuccess(title, message, duration)

-- Info
exports["bldr_notify"]:notifyInfo(title, message, duration)

-- Warning
exports["bldr_notify"]:notifyWarning(title, message, duration)

-- Police Alert
exports["bldr_notify"]:notifyPoliceAlert(title, message, location, duration)

-- EMS Alert
exports["bldr_notify"]:notifyEmsAlert(title, message, location, duration)

-- News Alert
exports["bldr_notify"]:notifyNewsAlert(title, message, duration)

-- City Alert
exports["bldr_notify"]:notifyCityAlert(title, message, duration)

-- Custom
exports["bldr_notify"]:notifyCustom(config)
```

---

## Server-Side API

### Send to Specific Player

```lua
exports["bldr_notify"]:showNotify(playerId, type, title, message, duration, location)
```

**Examples:**

```lua
-- Send error to player
exports["bldr_notify"]:showNotify(source, "error", "Invalid Action", "You cannot do that")

-- Send success with duration
exports["bldr_notify"]:showNotify(playerId, "success", "Job Complete", "You earned $500", 5000)

-- Send police alert with location
exports["bldr_notify"]:showNotify(playerId, "police", "Dispatch", "Robbery alert", nil, "Bank")
```

### Broadcast to All Players

```lua
exports["bldr_notify"]:broadcastNotify(type, title, message, duration, location)
```

**Examples:**

```lua
-- Broadcast server announcement
exports["bldr_notify"]:broadcastNotify("info", "Server", "Maintenance in 5 minutes")

-- Broadcast warning
exports["bldr_notify"]:broadcastNotify("warning", "Alert", "Stop all criminal activity")

-- Broadcast city alert
exports["bldr_notify"]:broadcastNotify("cityalert", "City", "Road closure on Main St", 8000)
```

### Convenience Broadcast Exports

```lua
-- Single type broadcasts
exports["bldr_notify"]:broadcastError(title, message, duration)
exports["bldr_notify"]:broadcastSuccess(title, message, duration)
exports["bldr_notify"]:broadcastInfo(title, message, duration)
exports["bldr_notify"]:broadcastWarning(title, message, duration)
exports["bldr_notify"]:broadcastPoliceAlert(title, message, location, duration)
exports["bldr_notify"]:broadcastEmsAlert(title, message, location, duration)
exports["bldr_notify"]:broadcastNewsAlert(title, message, duration)
exports["bldr_notify"]:broadcastCityAlert(title, message, duration)
```

---

## Using TriggerClientEvent

You can also use standard FiveM event triggering:

```lua
-- Send to specific player
TriggerClientEvent("bldr_notify:showNotify", playerId, "error", "Title", "Message", 5000, nil)

-- Broadcast to all
TriggerClientEvent("bldr_notify:showNotify", -1, "success", "Title", "Message", 5000, nil)
```

---

## Real-World Examples

### Job System
```lua
-- When job starts
exports["bldr_notify"]:showNotify(playerId, "info", "Job Started", "Delivery job started", 4000)

-- When job completes
exports["bldr_notify"]:showNotify(playerId, "success", "Job Complete", "You earned $500", 5000)

-- If job fails
exports["bldr_notify"]:showNotify(playerId, "error", "Job Failed", "You got caught", 5000)
```

### Banking/Economy
```lua
-- Player deposits money
exports["bldr_notify"]:showNotify(playerId, "success", "Deposit", "$5000 deposited", 3000)

-- Insufficient funds
exports["bldr_notify"]:showNotify(playerId, "error", "Insufficient Funds", "You need $1000", 4000)

-- Interest earned
exports["bldr_notify"]:showNotify(playerId, "info", "Interest", "You earned $50 interest", 3000)
```

### Dispatch System
```lua
-- Send dispatch to all cops
exports["bldr_notify"]:broadcastNotify("police", "DISPATCH", "Bank robbery in progress", 8000, "Downtown Bank")

-- Send EMS alert
exports["bldr_notify"]:broadcastNotify("ems", "DISPATCH", "Vehicle accident with injuries", 8000, "Highway 1")
```

### Admin Actions
```lua
-- Warn player
exports["bldr_notify"]:showNotify(playerId, "warning", "Admin Warning", "Stop breaking rules or you'll be banned", 6000)

-- Ban notification
exports["bldr_notify"]:broadcastNotify("error", "Ban Notice", "Player was permanently banned", 7000)

-- Announce maintenance
exports["bldr_notify"]:broadcastNotify("warning", "Maintenance", "Server restarting in 5 minutes", 6000)
```

### Property System
```lua
-- Property purchased
exports["bldr_notify"]:showNotify(playerId, "success", "Property Purchased", "Welcome to your new home", 5000)

-- Property locked out
exports["bldr_notify"]:showNotify(playerId, "warning", "Locked Out", "You don't own this property", 4000)

-- Rent payment
exports["bldr_notify"]:showNotify(playerId, "info", "Rent Payment", "Monthly rent charged: $500", 4000)
```

---

## Duration Guide

- **3000ms (3s)**: Quick confirmations like "Settings saved"
- **4000ms (4s)**: Standard info and error messages
- **5000ms (5s)**: Important messages that need reading
- **6000ms (6s)**: Warnings and cautions
- **7000ms (7s)**: Server announcements
- **8000ms (8s)**: Critical alerts like dispatch
- **40000ms (40s)**: Emergency alerts (police/ems) - default

---

## Default Durations by Type

```lua
error    = 35000 ms  (35 seconds)
success  = 30000 ms  (30 seconds)
info     = 30000 ms  (30 seconds)
warning  = 35000 ms  (35 seconds)
police   = 40000 ms  (40 seconds)
ems      = 40000 ms  (40 seconds)
news     = 37000 ms  (37 seconds)
cityalert= 38000 ms  (38 seconds)
```

Override with 4th parameter:
```lua
-- Show error but only for 2 seconds
exports["bldr_notify"]:showNotify("error", "Quick Error", "Message", 2000)
```

---

## Features

✅ **9 Alert Types** - Error, Success, Info, Warning, Police, EMS, News, City Alert, Custom
✨ **Smooth Animations** - Slide-in and fade-out transitions
📍 **Location Support** - Police & EMS alerts show location
⏱️ **Auto-dismiss** - Automatic fade out after duration
🎨 **Beautiful Design** - Gradient backgrounds, color-coded icons
📊 **Progress Bar** - Visual countdown of remaining time
🔊 **Sound Ready** - Framework for notification sounds
📱 **Responsive** - Works on all screen resolutions
⚡ **High Performance** - Efficient React rendering, no memory leaks

---

## Testing

### Test All Notifications
```lua
/notifyall
```

### Test Specific Type
```lua
/notify error "Title" "Message here"
/notify police "Robbery Alert" "In progress"
/notify ems "Medical Emergency" "Multiple injuries"
```

### Test Server Command
```lua
/srvnotify 1 info "Test" "From server"
```

---

## Architecture

```
Lua (Client)
    ↓ TriggerEvent
Lua (Server) --- TriggerClientEvent --- Lua (Client)
                                            ↓ SendNUIMessage
                                        React (Frontend)
                                            ↓ Display
                                        User sees notification
```

---

## Integration with Other Resources

Simply add to your resource manifest dependency:
```lua
depends { 'bldr_notify' }
```

Then use exports in your scripts:
```lua
exports["bldr_notify"]:showNotify("success", "Done", "Your message")
```

---

## Performance Notes

- Lightweight CSS animations
- Efficient React component updates
- Auto-cleanup after display
- Max recommended: 10 simultaneous notifications
- No memory leaks or timer buildup

---

## Customization

Want to change colors or defaults? Edit:
- `/client/notifications.lua` - Default durations and messages
- `/web/components/NotificationItem.tsx` - Styling and colors
- `/web/public/index.html` - CSS animations

---

## License

Free to use in your FiveM scripts!
