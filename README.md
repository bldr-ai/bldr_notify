# BLDR Notify

A beautiful, production-ready notification system for FiveM with smooth animations, multiple alert types, and clean API design.

## Features

✨ **9 Alert Types** - Error, Success, Info, Warning, Police, EMS, News, City Alert, Custom  
🎨 **Beautiful Design** - Gradient backgrounds, color-coded icons, responsive layout  
⏱️ **Auto-Dismiss** - Automatic fade-out with smooth transitions  
📍 **Location Support** - Police & EMS alerts display location information  
📊 **Progress Bar** - Visual countdown of remaining notification time  
⚡ **High Performance** - Efficient React rendering, no memory leaks  
📱 **Responsive** - Works perfectly on all screen resolutions  
🔌 **Clean API** - Standard FiveM exports pattern, easy integration  

## Installation

1. Clone or download this resource into your resources folder
2. Add to your server.cfg:
```
ensure bldr_notify
```
3. Start using it in your scripts!

## Quick Start

### Client-Side

```lua
-- Simple notification
exports["bldr_notify"]:showNotify("error", "Payment Failed", "Insufficient funds")

-- With custom duration (milliseconds)
exports["bldr_notify"]:showNotify("success", "Payment", "Transaction complete", 5000)

-- Police alert with location
exports["bldr_notify"]:showNotify("police", "Alert", "Bank robbery in progress", nil, "Downtown Bank")
```

### Server-Side

```lua
-- Send to specific player
exports["bldr_notify"]:showNotify(playerId, "error", "Title", "Message", 5000)

-- Broadcast to all players
exports["bldr_notify"]:broadcastNotify("warning", "Title", "Message", 5000)

-- Using TriggerClientEvent
TriggerClientEvent("bldr_notify:showNotify", playerId, "info", "Title", "Message", 5000)
```

## Notification Types

| Type | Default Title | Default Message | Duration | Best For |
|------|---|---|---|---|
| `error` | Error | An error has occurred | 35s | Failed operations, errors |
| `success` | Success | Operation completed successfully | 30s | Confirmations, completed tasks |
| `info` | Information | Here is some information | 30s | General information |
| `warning` | Warning | Please be careful | 35s | Cautions, warnings |
| `police` | Police Alert | Alert dispatched | 40s | Crime reports, dispatch |
| `ems` | EMS Alert | Emergency response dispatched | 40s | Medical emergencies |
| `news` | Breaking News | Special news broadcast | 37s | News announcements |
| `cityalert` | City Alert | Important city announcement | 38s | City-wide announcements |

## API Reference

### Client Exports

#### Main Function
```lua
exports["bldr_notify"]:showNotify(type, title, message, duration, location)
```

#### Convenience Functions
```lua
exports["bldr_notify"]:notifyError(title, message, duration)
exports["bldr_notify"]:notifySuccess(title, message, duration)
exports["bldr_notify"]:notifyInfo(title, message, duration)
exports["bldr_notify"]:notifyWarning(title, message, duration)
exports["bldr_notify"]:notifyPoliceAlert(title, message, location, duration)
exports["bldr_notify"]:notifyEmsAlert(title, message, location, duration)
exports["bldr_notify"]:notifyNewsAlert(title, message, duration)
exports["bldr_notify"]:notifyCityAlert(title, message, duration)
```

### Server Exports

#### Send to Player
```lua
exports["bldr_notify"]:showNotify(playerId, type, title, message, duration, location)

-- Convenience functions
exports["bldr_notify"]:notifyError(playerId, title, message, duration)
exports["bldr_notify"]:notifySuccess(playerId, title, message, duration)
exports["bldr_notify"]:notifyInfo(playerId, title, message, duration)
exports["bldr_notify"]:notifyWarning(playerId, title, message, duration)
exports["bldr_notify"]:notifyPoliceAlert(playerId, title, message, location, duration)
exports["bldr_notify"]:notifyEmsAlert(playerId, title, message, location, duration)
exports["bldr_notify"]:notifyNewsAlert(playerId, title, message, duration)
exports["bldr_notify"]:notifyCityAlert(playerId, title, message, duration)
```

#### Broadcast to All
```lua
exports["bldr_notify"]:broadcastNotify(type, title, message, duration, location)

-- Convenience broadcast functions
exports["bldr_notify"]:broadcastError(title, message, duration)
exports["bldr_notify"]:broadcastSuccess(title, message, duration)
exports["bldr_notify"]:broadcastInfo(title, message, duration)
exports["bldr_notify"]:broadcastWarning(title, message, duration)
exports["bldr_notify"]:broadcastPoliceAlert(title, message, location, duration)
exports["bldr_notify"]:broadcastEmsAlert(title, message, location, duration)
exports["bldr_notify"]:broadcastNewsAlert(title, message, duration)
exports["bldr_notify"]:broadcastCityAlert(title, message, duration)
```

### Events

```lua
-- Trigger notification via event
TriggerClientEvent("bldr_notify:showNotify", playerId, type, title, message, duration, location)

-- Broadcast to all
TriggerClientEvent("bldr_notify:showNotify", -1, type, title, message, duration, location)
```

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

## Duration Guide

Customize how long notifications stay visible:

| Duration | Best For |
|----------|----------|
| 2000ms | Quick dismissals, errors to acknowledge |
| 3000ms | Short messages, settings saved |
| 4000ms | Standard info and errors |
| 5000ms | Important messages |
| 6000ms | Warnings and cautions |
| 7000ms | Server announcements |
| 8000ms | Critical alerts, dispatch |
| 40000ms | Emergency alerts (default for police/ems) |

Override defaults:
```lua
-- Show error but only for 2 seconds
exports["bldr_notify"]:showNotify("error", "Quick Error", "Message", 2000)
```

## Integration

### Add as Dependency

Add to your resource's fxmanifest.lua:
```lua
depends { 'bldr_notify' }
```

Then use in your scripts:
```lua
exports["bldr_notify"]:showNotify("success", "Done", "Your message")
```

### Without Dependency

You can also use without adding it as a dependency by using events:
```lua
TriggerEvent("bldr_notify:showNotify", "info", "Title", "Message", 5000)
```

## Test Commands

Test the notification system with these commands:

```lua
/notifyall          -- Show all notification types
/notify [type] [title] [message...]  -- Test specific type
```

## Project Structure

```
bldr_notify/
├── client/
│   ├── main.lua              -- Client initialization
│   ├── nui.lua               -- NUI communication
│   └── notifications.lua      -- Notification exports and handlers
├── server/
│   ├── main.lua              -- Server initialization
│   └── notifications.lua      -- Server-side exports
├── web/
│   ├── App.tsx               -- React main component
│   ├── index.tsx             -- React entry point
│   ├── components/
│   │   ├── NotificationContainer.tsx  -- Notification manager
│   │   └── NotificationItem.tsx       -- Individual notification
│   ├── hooks/
│   │   └── useNui.ts         -- NUI communication hooks
│   └── public/
│       └── index.html        -- HTML template
├── fxmanifest.lua            -- FiveM manifest
└── README.md                 -- This file
```

## Architecture

```
┌─────────────┐
│   Server    │
│  (Lua)      │
└──────┬──────┘
       │ TriggerClientEvent
       ↓
┌──────────────────┐
│   Client (Lua)   │
│ RegisterNetEvent │
└──────┬───────────┘
       │ SendNUIMessage
       ↓
┌────────────────────┐
│  React Frontend    │
│  (UI Component)    │
└────────┬───────────┘
         │
         ↓
   Display Notification
```

## Performance

- ✅ Lightweight CSS animations
- ✅ Efficient React component updates
- ✅ Auto-cleanup after display
- ✅ No memory leaks or timer buildup
- ✅ Recommended max: 10 simultaneous notifications

## Customization

### Change Default Durations
Edit `/client/notifications.lua` and `/server/notifications.lua` to modify default durations for each notification type.

### Modify Colors/Styling
Edit `/web/components/NotificationItem.tsx` to change colors, fonts, and styling.

### Add Custom Animations
Edit `/web/public/index.html` to add or modify CSS animations.

## Browser Console Logs

When testing, check your browser console (F8) for debug logs:
```
[Notification] Sending: Error | Duration: 35000ms
[NotificationContainer] Received: { title: 'Error', duration: 35000, type: 'error' }
[Notification] Error - Duration: 35000ms
```

## Troubleshooting

### Notifications disappearing too quickly
- Check duration values in console logs
- Ensure you're not overriding with a very small duration
- Verify the resource is properly started

### Notifications not showing
- Check F8 console for errors
- Verify `ensure bldr_notify` is in your server.cfg
- Make sure you're using the correct export name: `bldr_notify`

### NUI not loading
- Check if your FiveM client can load NUI
- Verify the web folder is in the correct location
- Check browser console (F8) for JavaScript errors

## Credits

Built with:
- **FiveM** - GTA V multiplayer framework
- **React** - UI framework
- **TypeScript** - Type safety
- **Tailwind CSS** - Styling
- **Lucide React** - Icons

## License

Free to use in your FiveM scripts. Feel free to modify and distribute!

## Support

For issues, suggestions, or contributions, please open an issue on GitHub.

---

**Happy notifying! 🎉**
