-- Server-side notification system
-- Usage:
-- exports["bldr_notify"]:showNotify(playerId, "error", "Title", "Message", 5000)
-- TriggerClientEvent("bldr_notify:showNotify", playerId, "info", "Title", "Message", 5000)

-- Internal helper to send notifications
local function SendToClient(playerId, notificationType, title, message, duration, location)
    if not title or title == '' then
        if notificationType == 'error' then
            title = 'Error'
        elseif notificationType == 'success' then
            title = 'Success'
        elseif notificationType == 'info' then
            title = 'Information'
        elseif notificationType == 'warning' then
            title = 'Warning'
        elseif notificationType == 'police' then
            title = 'Police Alert'
        elseif notificationType == 'ems' then
            title = 'EMS Alert'
        elseif notificationType == 'news' then
            title = 'Breaking News'
        elseif notificationType == 'cityalert' then
            title = 'City Alert'
        else
            title = 'Notification'
        end
    end
    
    if not message or message == '' then
        if notificationType == 'error' then
            message = 'An error has occurred'
        elseif notificationType == 'success' then
            message = 'Operation completed successfully'
        elseif notificationType == 'info' then
            message = 'Here is some information'
        elseif notificationType == 'warning' then
            message = 'Please be careful'
        elseif notificationType == 'police' then
            message = 'Alert dispatched'
        elseif notificationType == 'ems' then
            message = 'Emergency response dispatched'
        elseif notificationType == 'news' then
            message = 'Special news broadcast'
        elseif notificationType == 'cityalert' then
            message = 'Important city announcement'
        end
    end
    
    -- Set default durations if not provided
    if not duration or duration == 0 then
        duration = 5000
    end
    
    TriggerClientEvent('bldr_notify:showNotify', playerId, notificationType, title, message, duration, location)
end

-- Main export - send to specific player
-- Usage: exports["bldr_notify"]:showNotify(playerId, "error", "Title", "Message", duration, location)
exports('showNotify', function(playerId, notificationType, title, message, duration, location)
    SendToClient(playerId, notificationType, title, message, duration, location)
end)

-- Broadcast to all players
-- Usage: exports["bldr_notify"]:broadcastNotify("error", "Title", "Message", duration, location)
exports('broadcastNotify', function(notificationType, title, message, duration, location)
    TriggerClientEvent('bldr_notify:showNotify', -1, notificationType, title, message, duration, location)
end)

-- Convenience exports for specific types - to single player
exports('notifyError', function(playerId, title, message, duration)
    SendToClient(playerId, 'error', title, message, duration)
end)

exports('notifySuccess', function(playerId, title, message, duration)
    SendToClient(playerId, 'success', title, message, duration)
end)

exports('notifyInfo', function(playerId, title, message, duration)
    SendToClient(playerId, 'info', title, message, duration)
end)

exports('notifyWarning', function(playerId, title, message, duration)
    SendToClient(playerId, 'warning', title, message, duration)
end)

exports('notifyPoliceAlert', function(playerId, title, message, location, duration)
    SendToClient(playerId, 'police', title, message, duration, location)
end)

exports('notifyEmsAlert', function(playerId, title, message, location, duration)
    SendToClient(playerId, 'ems', title, message, duration, location)
end)

exports('notifyNewsAlert', function(playerId, title, message, duration)
    SendToClient(playerId, 'news', title, message, duration)
end)

exports('notifyCityAlert', function(playerId, title, message, duration)
    SendToClient(playerId, 'cityalert', title, message, duration)
end)

-- Broadcast versions
exports('broadcastError', function(title, message, duration)
    TriggerClientEvent('bldr_notify:showNotify', -1, 'error', title, message, duration)
end)

exports('broadcastSuccess', function(title, message, duration)
    TriggerClientEvent('bldr_notify:showNotify', -1, 'success', title, message, duration)
end)

exports('broadcastInfo', function(title, message, duration)
    TriggerClientEvent('bldr_notify:showNotify', -1, 'info', title, message, duration)
end)

exports('broadcastWarning', function(title, message, duration)
    TriggerClientEvent('bldr_notify:showNotify', -1, 'warning', title, message, duration)
end)

exports('broadcastPoliceAlert', function(title, message, location, duration)
    TriggerClientEvent('bldr_notify:showNotify', -1, 'police', title, message, duration, location)
end)

exports('broadcastEmsAlert', function(title, message, location, duration)
    TriggerClientEvent('bldr_notify:showNotify', -1, 'ems', title, message, duration, location)
end)

exports('broadcastNewsAlert', function(title, message, duration)
    TriggerClientEvent('bldr_notify:showNotify', -1, 'news', title, message, duration)
end)

exports('broadcastCityAlert', function(title, message, duration)
    TriggerClientEvent('bldr_notify:showNotify', -1, 'cityalert', title, message, duration)
end)

-- Test command
RegisterCommand('srvnotify', function(source, args, rawCommand)
    if not IsPlayerAdmin(source) then
        return
    end
    
    local playerId = tonumber(args[1])
    if not playerId or not GetPlayerName(playerId) then
        TriggerClientEvent('bldr_notify:showNotify', source, 'error', 'Invalid Player ID', 'Player not found')
        return
    end
    
    local notifyType = args[2] or 'info'
    local title = args[3] or 'Server Notification'
    local message = table.concat(args, ' ', 4) or 'Test message'
    
    SendToClient(playerId, notifyType, title, message)
end, true)

-- Helper function - replace with your own admin check
function IsPlayerAdmin(source)
    return true  -- Replace with actual admin check
end
