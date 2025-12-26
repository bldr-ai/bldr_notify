local notificationQueue = {}

-- Show notification via NUI
local function ShowNotification(notificationType, title, message, duration, data)
    duration = duration or 5000
    
    local notificationData = {
        type = notificationType,
        title = title,
        message = message,
        duration = duration,
        customData = data or {}
    }
    
    print(('[Notification] Sending: %s | Duration: %dms'):format(title, duration))
    table.insert(notificationQueue, notificationData)
    SendNUIMessage({
        action = 'addNotification',
        type = notificationType,
        title = title,
        message = message,
        duration = duration,
        customData = data or {}
    })
end

-- Export function with clean API
local function Notify(notificationType, title, message, duration, location)
    -- Set defaults based on type if not provided
    if notificationType == 'error' then
        title = title or 'Error'
        message = message or 'An error has occurred'
        duration = duration or 5000
    elseif notificationType == 'success' then
        title = title or 'Success'
        message = message or 'Operation completed successfully'
        duration = duration or 5000
    elseif notificationType == 'info' then
        title = title or 'Information'
        message = message or 'Here is some information'
        duration = duration or 5000
    elseif notificationType == 'warning' then
        title = title or 'Warning'
        message = message or 'Please be careful'
        duration = duration or 5000
    elseif notificationType == 'police' then
        title = title or 'Police Alert'
        message = message or 'Alert dispatched'
        location = location or 'Unknown Location'
        duration = duration or 5000
        ShowNotification('police', title, message, duration, { location = location })
        return
    elseif notificationType == 'ems' then
        title = title or 'EMS Alert'
        message = message or 'Emergency response dispatched'
        location = location or 'Unknown Location'
        duration = duration or 5000
        ShowNotification('ems', title, message, duration, { location = location })
        return
    elseif notificationType == 'news' then
        title = title or 'Breaking News'
        message = message or 'Special news broadcast'
        duration = duration or 5000
    elseif notificationType == 'cityalert' then
        title = title or 'City Alert'
        message = message or 'Important city announcement'
        duration = duration or 5000
    elseif notificationType == 'custom' then
        -- For custom, title is actually the config table
        if type(title) == 'table' then
            local config = title
            ShowNotification(config.type or 'custom', config.title or 'Notification', config.message or '', 
                config.duration or 30000, config.customData or {})
            return
        end
    end
    
    ShowNotification(notificationType, title, message, duration)
end

-- Main export function
exports('showNotify', function(notificationType, title, message, duration, location)
    Notify(notificationType, title, message, duration, location)
end)

-- Convenience exports for each type
exports('notifyError', function(title, message, duration)
    Notify('error', title, message, duration)
end)

exports('notifySuccess', function(title, message, duration)
    Notify('success', title, message, duration)
end)

exports('notifyInfo', function(title, message, duration)
    Notify('info', title, message, duration)
end)

exports('notifyWarning', function(title, message, duration)
    Notify('warning', title, message, duration)
end)

exports('notifyPoliceAlert', function(title, message, location, duration)
    Notify('police', title, message, duration, location)
end)

exports('notifyEmsAlert', function(title, message, location, duration)
    Notify('ems', title, message, duration, location)
end)

exports('notifyNewsAlert', function(title, message, duration)
    Notify('news', title, message, duration)
end)

exports('notifyCityAlert', function(title, message, duration)
    Notify('cityalert', title, message, duration)
end)

exports('notifyCustom', function(config)
    Notify('custom', config)
end)

-- Listen for server-triggered notifications
RegisterNetEvent('bldr_notify:showNotify', function(notificationType, title, message, duration, location)
    Notify(notificationType, title, message, duration, location)
end)

-- Test commands
RegisterCommand('notify', function(source, args, rawCommand)
    if #args < 2 then
        NotifyError('Error', 'Usage: /notify [type] [title] [message...]')
        return
    end
    
    local notiType = args[1]
    local title = args[2]
    local message = table.concat(args, ' ', 3)
    
    Notify(notiType, title, message)
end, false)

RegisterCommand('notifyall', function(source, args, rawCommand)
    print('^2[Notifications]^7 Starting test sequence...')
    
    Wait(100)
    Notify('info', 'Info', 'This is an info notification')
    Wait(500)
    Notify('success', 'Success', 'Operation completed successfully!')
    Wait(500)
    Notify('warning', 'Warning', 'This is a warning message')
    Wait(500)
    Notify('error', 'Error', 'An error has occurred')
    Wait(500)
    Notify('police', 'Police Alert', 'Robbery in progress at the bank', nil, 'Downtown')
    Wait(500)
    Notify('ems', 'EMS Alert', 'Multiple injuries reported', nil, 'Hospital')
    Wait(500)
    Notify('news', 'Breaking News', 'Special broadcast from Diamond Casino')
    Wait(500)
    Notify('cityalert', 'City Alert', 'Road closure on Main Street until 18:00')
    
    print('^2[Notifications]^7 Test sequence complete!')
end, false)
