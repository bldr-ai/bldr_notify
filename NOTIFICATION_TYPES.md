# Notification Types Reference

Quick reference for all notification types and their characteristics.

## Type Definitions

### 1. Error ❌
**Use for:** Failed operations, invalid inputs, connection errors
- **Color Scheme:** Red gradient (#ef4444 → #7f1d1d)
- **Icon:** AlertCircle
- **Duration:** 4000ms (default)
- **Sound:** Yes
- **Auto-dismiss:** Yes

```lua
NotifyError('Error Title', 'Error message here')
SendError(playerId, 'Error Title', 'Error message here')
BroadcastError('Error Title', 'Error message here')
```

---

### 2. Success ✅
**Use for:** Successful operations, confirmations, completed tasks
- **Color Scheme:** Emerald/Green gradient (#10b981 → #065f46)
- **Icon:** CheckCircle
- **Duration:** 3000ms (default)
- **Sound:** Yes
- **Auto-dismiss:** Yes

```lua
NotifySuccess('Success Title', 'Success message')
SendSuccess(playerId, 'Success Title', 'Success message')
BroadcastSuccess('Success Title', 'Success message')
```

---

### 3. Info ℹ️
**Use for:** General information, tips, non-critical updates
- **Color Scheme:** Blue gradient (#3b82f6 → #1e3a8a)
- **Icon:** Info
- **Duration:** 3000ms (default)
- **Sound:** Yes
- **Auto-dismiss:** Yes

```lua
NotifyInfo('Information Title', 'Info message')
SendInfo(playerId, 'Information Title', 'Info message')
BroadcastInfo('Information Title', 'Info message')
```

---

### 4. Warning ⚠️
**Use for:** Cautions, important reminders, risky operations
- **Color Scheme:** Amber/Yellow gradient (#f59e0b → #78350f)
- **Icon:** AlertTriangle
- **Duration:** 4000ms (default)
- **Sound:** Yes
- **Auto-dismiss:** Yes

```lua
NotifyWarning('Warning Title', 'Warning message')
SendWarning(playerId, 'Warning Title', 'Warning message')
BroadcastWarning('Warning Title', 'Warning message')
```

---

### 5. Police Alert 🚔
**Use for:** Crime reports, police dispatch, criminal activity
- **Color Scheme:** Blue with pulse effect (#1e40af → #0c4a6e)
- **Icon:** Shield
- **Duration:** 6000ms (default)
- **Sound:** Yes (high priority)
- **Auto-dismiss:** Yes
- **Features:** Location display, pulse animation

```lua
NotifyPoliceAlert('Police Alert', 'Robbery in progress', 'Downtown Bank')
SendPoliceAlert(playerId, 'Police Alert', 'Robbery in progress', 'Downtown Bank')
BroadcastPoliceAlert('Police Alert', 'Robbery in progress', 'Downtown Bank')
```

---

### 6. EMS Alert 🚑
**Use for:** Medical emergencies, injuries, accidents
- **Color Scheme:** Red with pulse effect (#dc2626 → #7f1d1d)
- **Icon:** Ambulance
- **Duration:** 6000ms (default)
- **Sound:** Yes (high priority)
- **Auto-dismiss:** Yes
- **Features:** Location display, pulse animation

```lua
NotifyEmsAlert('EMS Alert', 'Multiple injuries', 'Pillbox Medical')
SendEmsAlert(playerId, 'EMS Alert', 'Multiple injuries', 'Pillbox Medical')
BroadcastEmsAlert('EMS Alert', 'Multiple injuries', 'Pillbox Medical')
```

---

### 7. News Alert 📰
**Use for:** News broadcasts, announcements, media broadcasts
- **Color Scheme:** Purple gradient (#7c3aed → #4c1d95)
- **Icon:** Newspaper
- **Duration:** 5000ms (default)
- **Sound:** Yes
- **Auto-dismiss:** Yes

```lua
NotifyNewsAlert('Breaking News', 'Special announcement from Diamond Casino')
SendNewsAlert(playerId, 'Breaking News', 'Special announcement from Diamond Casino')
BroadcastNewsAlert('Breaking News', 'Special announcement from Diamond Casino')
```

---

### 8. City Alert 📢
**Use for:** City-wide announcements, road closures, public information
- **Color Scheme:** Orange gradient (#f97316 → #7c2d12)
- **Icon:** Bell
- **Duration:** 7000ms (default)
- **Sound:** Yes
- **Auto-dismiss:** Yes

```lua
NotifyCityAlert('City Alert', 'Road closure on Main Street')
SendCityAlert(playerId, 'City Alert', 'Road closure on Main Street')
BroadcastCityAlert('City Alert', 'Road closure on Main Street')
```

---

### 9. Custom 🎨
**Use for:** Fully customizable notifications with complete control
- **Color Scheme:** User-defined
- **Icon:** User-defined (emoji or default)
- **Duration:** User-defined
- **Sound:** User-configurable (true/false)
- **Auto-dismiss:** Yes
- **Features:** Full customization

```lua
NotifyCustom({
    type = 'custom',
    title = 'Custom Title',
    message = 'Custom message',
    duration = 4000,
    color = '#FF00FF',
    backgroundColor = '#1a1a2e',
    icon = '⭐',
    sound = true
})

-- Via exports
exports['notifications']:notify({
    type = 'custom',
    title = 'Custom Title',
    message = 'Custom message',
    duration = 4000,
    color = '#FF00FF',
    backgroundColor = '#1a1a2e',
    icon = '⭐',
    sound = true
})
```

---

## Comparison Table

| Type | Icon | Color | Duration | Priority | Animation | Location |
|------|------|-------|----------|----------|-----------|----------|
| Error | ❌ | Red | 4s | Medium | Slide | - |
| Success | ✅ | Green | 3s | Low | Slide | - |
| Info | ℹ️ | Blue | 3s | Low | Slide | - |
| Warning | ⚠️ | Yellow | 4s | Medium | Slide | - |
| Police | 🚔 | Blue | 6s | **High** | Slide + Pulse | ✓ |
| EMS | 🚑 | Red | 6s | **High** | Slide + Pulse | ✓ |
| News | 📰 | Purple | 5s | Low | Slide | - |
| City | 📢 | Orange | 7s | Medium | Slide | - |
| Custom | 🎨 | Custom | Custom | Custom | Slide | - |

---

## Common Use Cases

### E-Commerce / Store
```lua
-- Player tries to buy something
NotifyError('Purchase Failed', 'Insufficient funds')
NotifySuccess('Purchase Complete', 'Item added to inventory')
NotifyWarning('Sale', 'Limited time offer ending soon')
```

### Jobs / Work
```lua
NotifySuccess('Job Complete', 'You earned $500')
NotifyError('Job Failed', 'You were spotted by security')
NotifyInfo('Job Available', 'New job in delivery available')
NotifyPoliceAlert('Police Alert', 'Suspicious activity detected', 'Main Street')
```

### Real Estate
```lua
NotifySuccess('Property Purchased', 'Welcome to your new home')
NotifyInfo('Property Available', 'New apartment listing at Beach')
NotifyWarning('Rent Due', 'Your rent is due in 3 days')
```

### Dispatch System
```lua
BroadcastPoliceAlert('Robbery', 'In progress at Downtown Bank', 'Downtown Bank')
BroadcastEmsAlert('Accident', '3 vehicle collision', 'Highway 1')
BroadcastNewsAlert('Breaking', 'Grand opening of new club tonight')
```

### Server Management
```lua
BroadcastCityAlert('Maintenance', 'Server maintenance in 10 minutes')
BroadcastWarning('Ban Notice', 'Player was banned for cheating')
BroadcastInfo('Update', 'New features added to the server')
```

### VIP / Premium Features
```lua
exports['notifications']:notify({
    type = 'custom',
    title = 'VIP Bonus',
    message = 'You earned 500 VIP points',
    icon = '👑',
    color = '#FFD700'
})
```

---

## Best Practices

1. **Use appropriate types** - Don't use Error for warnings or Vice versa
2. **Keep messages concise** - Max 1-2 sentences for readability
3. **Use locations** - Always provide location for Police/EMS alerts
4. **Duration selection** - Longer for important alerts (Police, City)
5. **Avoid spam** - Don't send multiple notifications rapidly
6. **Sound control** - Disable sound for high-frequency notifications
7. **Color accessibility** - Ensure custom colors have good contrast
8. **Icon clarity** - Use recognizable emojis for custom alerts

---

## Hex Color Suggestions

**Alert Colors:**
- Red: `#FF0000` `#DC2626` `#EF4444`
- Green: `#00FF00` `#10B981` `#34D399`
- Blue: `#0000FF` `#3B82F6` `#60A5FA`
- Yellow: `#FFFF00` `#FBBF24` `#FCD34D`
- Orange: `#FFA500` `#F97316` `#FB923C`
- Purple: `#A020F0` `#A855F7` `#D8B4FE`

**Background Colors:**
- Dark: `#000000` `#0F172A` `#1A1A2E`
- Darker: `#0a0a0a` `#111111` `#1f1f1f`

---

## Version History

- **v1.0.0** - Initial release with 9 notification types
  - Complete animation system
  - Full customization support
  - Server/Client integration
  - Location support for alerts
