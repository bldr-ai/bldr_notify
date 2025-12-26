-- Example usage of the server-side notification system
-- This file demonstrates how to use notifications from server-side code

-- ============================================
-- BASIC SERVER NOTIFICATIONS
-- ============================================

-- Send error to specific player
function SendPlayerError(playerId, title, message)
    SendError(playerId, title, message, 4000)
end

-- Broadcast error to all players
function NotifyAllError(title, message)
    BroadcastError(title, message, 4000)
end

-- ============================================
-- SCENARIO EXAMPLES
-- ============================================

-- Player joined notification
function NotifyPlayerJoined(playerId, playerName)
    BroadcastInfo(
        'Player Joined',
        ('^7%s ^0has joined the server'):format(playerName),
        3000
    )
end

-- Player left notification
function NotifyPlayerLeft(playerId, playerName, reason)
    BroadcastInfo(
        'Player Left',
        ('^7%s ^0has left the server (%s)'):format(playerName, reason),
        3000
    )
end

-- Ban notification
function NotifyPlayerBanned(playerName, reason, duration)
    local durationText = duration == 0 and 'permanently' or ('for %d hours'):format(duration)
    BroadcastWarning(
        'Player Banned',
        ('^7%s ^0was banned %s | Reason: %s'):format(playerName, durationText, reason),
        5000
    )
end

-- Payment confirmation
function NotifyPayment(playerId, amount, description)
    SendSuccess(
        playerId,
        'Payment Processed',
        ('$%d deducted: %s'):format(amount, description),
        3000
    )
end

-- Income notification
function NotifyIncome(playerId, amount, source)
    SendSuccess(
        playerId,
        'Income Received',
        ('$%d from %s'):format(amount, source),
        3000
    )
end

-- Transaction error
function NotifyTransactionError(playerId, reason)
    SendError(
        playerId,
        'Transaction Failed',
        reason,
        4000
    )
end

-- Job assignment
function NotifyJobAssignment(playerId, jobName, location, reward)
    SendInfo(
        playerId,
        'Job Assigned',
        ('Location: %s | Reward: $%d'):format(location, reward),
        4000
    )
end

-- Dispatch alert (police/fire/ems)
function NotifyDispatch(dispatchType, title, message, location)
    if dispatchType == 'police' then
        BroadcastPoliceAlert(title, message, location, 8000)
    elseif dispatchType == 'ems' then
        BroadcastEmsAlert(title, message, location, 8000)
    else
        BroadcastCityAlert(title, message, 7000)
    end
end

-- Server maintenance warning
function NotifyMaintenance(message, minutesUntil)
    BroadcastWarning(
        'Maintenance Alert',
        ('Server maintenance in %d minutes: %s'):format(minutesUntil, message),
        5000
    )
end

-- Server restart warning
function NotifyRestart(minutesUntil)
    BroadcastCityAlert(
        'Server Restart',
        ('Server restarting in %d minutes. Save your progress!'):format(minutesUntil),
        7000
    )
end

-- Whitelist update
function NotifyWhitelistChange(playerName, action)
    local message = action == 'added' and 'added to whitelist' or 'removed from whitelist'
    BroadcastInfo(
        'Whitelist Update',
        ('^7%s ^0was %s'):format(playerName, message),
        4000
    )
end

-- ============================================
-- CUSTOM NOTIFICATIONS
-- ============================================

-- VIP notification
function NotifyVIPAction(playerId, message, icon)
    exports['notifications']:notifyPlayer(playerId, {
        type = 'custom',
        title = 'VIP Notification',
        message = message,
        duration = 4000,
        color = '#FFD700',
        backgroundColor = '#2a2a1a',
        icon = icon or '👑',
        sound = true
    })
end

-- Broadcast VIP action
function BroadcastVIPAction(message)
    exports['notifications']:notify({
        type = 'custom',
        title = 'VIP Event',
        message = message,
        duration = 5000,
        color = '#FFD700',
        backgroundColor = '#2a2a1a',
        icon = '👑',
        sound = true
    })
end

-- Admin action notification
function NotifyAdminAction(actionType, adminName, targetName, reason)
    local title = 'Admin Action: ' .. actionType
    local message = ('Admin ^7%s ^0%s on %s'):format(adminName, actionType, targetName)
    if reason then
        message = message .. ' | Reason: ' .. reason
    end
    
    BroadcastWarning(title, message, 5000)
end

-- ============================================
-- GANG/FACTION NOTIFICATIONS
-- ============================================

function NotifyGangEvent(gangName, event, details)
    local icon = '🏘️'
    if gangName == 'Vagos' then
        icon = '💚'
    elseif gangName == 'Ballas' then
        icon = '💜'
    elseif gangName == 'Families' then
        icon = '💛'
    elseif gangName == 'Lost' then
        icon = '🏍️'
    end
    
    exports['notifications']:notify({
        type = 'custom',
        title = gangName,
        message = event .. ' - ' .. details,
        duration = 5000,
        color = '#FF6B00',
        backgroundColor = '#1a1a1a',
        icon = icon,
        sound = true
    })
end

-- ============================================
-- PROPERTY & HOUSING
-- ============================================

function NotifyPropertyEvent(playerId, propertyName, eventType, price)
    local title = 'Property'
    local message = ''
    
    if eventType == 'purchased' then
        title = 'Purchase Successful'
        message = ('You purchased %s for $%d'):format(propertyName, price)
    elseif eventType == 'sold' then
        title = 'Sale Successful'
        message = ('You sold %s for $%d'):format(propertyName, price)
    elseif eventType == 'entry_denied' then
        title = 'Access Denied'
        message = ('You cannot enter %s'):format(propertyName)
    elseif eventType == 'rent_due' then
        title = 'Rent Due'
        message = ('Rent is due for %s - $%d'):format(propertyName, price)
    end
    
    SendInfo(playerId, title, message, 4000)
end

-- ============================================
-- AUCTION & TRADING
-- ============================================

function NotifyAuctionEvent(playerId, itemName, action, amount)
    if action == 'outbid' then
        SendWarning(playerId, 'Auction', 'You were outbid on ' .. itemName, 3000)
    elseif action == 'won' then
        SendSuccess(playerId, 'Auction Won', 'You won ' .. itemName .. ' for $' .. amount, 4000)
    elseif action == 'sold' then
        SendSuccess(playerId, 'Item Sold', itemName .. ' sold for $' .. amount, 4000)
    end
end

-- ============================================
-- COMMANDS (ADMIN/DEV)
-- ============================================

RegisterCommand('notifytest', function(source, args, rawCommand)
    if source == 0 then
        print('Use /notifytestplayer [id] instead')
        return
    end
    
    SendSuccess(source, 'Test', 'Success notification', 3000)
    Wait(500)
    SendError(source, 'Test', 'Error notification', 3000)
    Wait(500)
    SendWarning(source, 'Test', 'Warning notification', 3000)
    Wait(500)
    SendInfo(source, 'Test', 'Info notification', 3000)
end, false)

RegisterCommand('broadcasttest', function(source, args, rawCommand)
    if not IsPlayerAdmin(source) then
        print('Admin only')
        return
    end
    
    BroadcastSuccess('Server', 'This is a broadcast notification', 4000)
end, true)

RegisterCommand('notifytestplayer', function(source, args, rawCommand)
    if not IsPlayerAdmin(source) then
        print('Admin only')
        return
    end
    
    local playerId = tonumber(args[1])
    if not playerId or not GetPlayerName(playerId) then
        print('Invalid player ID')
        return
    end
    
    SendInfo(playerId, 'Test', 'You received a test notification!', 4000)
end, true)

RegisterCommand('broadcasterror', function(source, args, rawCommand)
    if not IsPlayerAdmin(source) then
        return
    end
    
    local title = args[1] or 'Error'
    local message = table.concat(args, ' ', 2) or 'An error occurred'
    
    BroadcastError(title, message, 4000)
end, true)

RegisterCommand('broadcastwarning', function(source, args, rawCommand)
    if not IsPlayerAdmin(source) then
        return
    end
    
    local title = args[1] or 'Warning'
    local message = table.concat(args, ' ', 2) or 'A warning message'
    
    BroadcastWarning(title, message, 4000)
end, true)

-- ============================================
-- UTILITY FUNCTION
-- ============================================

function IsPlayerAdmin(source)
    -- Implement your own admin check here
    -- This is a placeholder
    return true
end

print('^2[Server Notifications]^7 Example usage loaded!')
