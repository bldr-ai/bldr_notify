-- Example usage of the notification system from other resources
-- This file shows how to use the notification system in your own scripts

-- ============================================
-- BASIC NOTIFICATION EXAMPLES
-- ============================================

-- Show an error notification
function TestError()
    NotifyError('Error Title', 'Something went wrong!', 4000)
end

-- Show a success notification
function TestSuccess()
    NotifySuccess('Success', 'Operation completed successfully!', 3000)
end

-- Show an info notification
function TestInfo()
    NotifyInfo('Information', 'Here is some useful information', 3000)
end

-- Show a warning notification
function TestWarning()
    NotifyWarning('Caution', 'Be careful with this action', 4000)
end

-- ============================================
-- ALERT NOTIFICATIONS (URGENT)
-- ============================================

-- Police alert with location
function TestPoliceAlert()
    NotifyPoliceAlert(
        'Police Alert',
        'Robbery in progress at the bank',
        'Downtown Bank - Main Street',
        6000
    )
end

-- EMS alert with location
function TestEmsAlert()
    NotifyEmsAlert(
        'EMS Emergency',
        'Multiple injuries reported - vehicle collision',
        'Pillbox Medical Center - Integrity Way',
        6000
    )
end

-- News broadcast
function TestNewsAlert()
    NotifyNewsAlert(
        'Breaking News',
        'Special announcement from Diamond Casino Resort',
        5000
    )
end

-- City announcement
function TestCityAlert()
    NotifyCityAlert(
        'City Announcement',
        'Road maintenance scheduled on Del Perro Boulevard - expect delays',
        7000
    )
end

-- ============================================
-- CUSTOM NOTIFICATIONS
-- ============================================

-- Custom notification with custom colors and icon
function TestCustom1()
    NotifyCustom({
        type = 'custom',
        title = 'Custom Alert',
        message = 'This is a fully customizable notification',
        duration = 4000,
        color = '#FF00FF',           -- Magenta icon
        backgroundColor = '#1a1a2e', -- Dark blue background
        icon = '🎮',                 -- Gaming emoji
        sound = true
    })
end

-- Money notification example
function TestCustomMoney()
    NotifyCustom({
        type = 'custom',
        title = 'Payment Received',
        message = 'You received $500 from a job',
        duration = 3000,
        color = '#00FF00',
        backgroundColor = '#0a2e0a',
        icon = '💰',
        sound = true
    })
end

-- Premium notification example
function TestCustomPremium()
    NotifyCustom({
        type = 'custom',
        title = 'Premium Member',
        message = 'You are now a premium member! Enjoy exclusive benefits',
        duration = 5000,
        color = '#FFD700',
        backgroundColor = '#2a2a1a',
        icon = '⭐',
        sound = true
    })
end

-- Danger/Ban notification
function TestCustomDanger()
    NotifyCustom({
        type = 'custom',
        title = 'Warning',
        message = 'You have been warned by an administrator',
        duration = 6000,
        color = '#FF0000',
        backgroundColor = '#2a0a0a',
        icon = '⚡',
        sound = true
    })
end

-- ============================================
-- USING EXPORTS (FROM OTHER RESOURCES)
-- ============================================

-- Example: In another resource's script, you can use:
-- exports['resource-name']:notifyError('Title', 'Message')
-- exports['resource-name']:notifySuccess('Title', 'Message')
-- exports['resource-name']:notify({ type = 'custom', ... })

-- ============================================
-- SCENARIO EXAMPLES
-- ============================================

-- Job completion notification
function NotifyJobComplete(jobName, reward)
    NotifySuccess(
        'Job Complete',
        ('You completed %s and earned $%d'):format(jobName, reward),
        4000
    )
end

-- Insufficient funds scenario
function NotifyInsufficientFunds(required, current)
    NotifyError(
        'Insufficient Funds',
        ('Need $%d, but you only have $%d'):format(required, current),
        4000
    )
end

-- Login success
function NotifyLoginSuccess(username)
    NotifySuccess(
        'Login Successful',
        ('Welcome back, %s!'):format(username),
        3000
    )
end

-- Cooldown notification
function NotifyOnCooldown(action, seconds)
    NotifyWarning(
        'On Cooldown',
        ('You can use %s again in %d seconds'):format(action, seconds),
        3000
    )
end

-- Police dispatch (for dispatch systems)
function DispatchAlert(callType, location, details)
    if callType == 'robbery' then
        NotifyPoliceAlert(
            'Dispatch: Robbery',
            details,
            location,
            8000
        )
    elseif callType == 'assault' then
        NotifyPoliceAlert(
            'Dispatch: Assault',
            details,
            location,
            8000
        )
    elseif callType == 'accident' then
        NotifyEmsAlert(
            'Dispatch: Vehicle Accident',
            details,
            location,
            8000
        )
    end
end

-- Property notification
function NotifyPropertyAction(action, address)
    if action == 'purchased' then
        NotifySuccess(
            'Property Purchased',
            ('You bought the property at %s'):format(address),
            4000
        )
    elseif action == 'sold' then
        NotifySuccess(
            'Property Sold',
            ('You sold the property at %s'):format(address),
            4000
        )
    elseif action == 'locked_out' then
        NotifyWarning(
            'Property Locked',
            ('You are locked out of %s'):format(address),
            4000
        )
    end
end

-- System message (like server maintenance)
function NotifySystemMessage(message, severity)
    if severity == 'critical' then
        NotifyCityAlert(
            'System Alert',
            message,
            7000
        )
    elseif severity == 'warning' then
        NotifyWarning(
            'System Warning',
            message,
            5000
        )
    else
        NotifyInfo(
            'System Message',
            message,
            4000
        )
    end
end

-- ============================================
-- COMMANDS FOR TESTING
-- ============================================

RegisterCommand('testnotifications', function(source, args, rawCommand)
    print('^2[Notifications]^7 Starting notification tests...')
    
    Wait(500)
    TestInfo()
    Wait(1000)
    TestSuccess()
    Wait(1000)
    TestWarning()
    Wait(1000)
    TestError()
    Wait(1000)
    TestCustomMoney()
    Wait(1000)
    TestCustomPremium()
    Wait(1000)
    TestPoliceAlert()
    Wait(1000)
    TestEmsAlert()
    Wait(1000)
    TestNewsAlert()
    Wait(1000)
    TestCityAlert()
    
    print('^2[Notifications]^7 Test sequence complete!')
end, false)

RegisterCommand('testcustom', function(source, args, rawCommand)
    local color = args[1] or '#FF00FF'
    local icon = args[2] or '⭐'
    
    NotifyCustom({
        type = 'custom',
        title = 'Custom Test',
        message = ('Color: %s | Icon: %s'):format(color, icon),
        duration = 4000,
        color = color,
        backgroundColor = '#1a1a2e',
        icon = icon,
        sound = true
    })
end, false)

print('^2[Notifications]^7 Example usage loaded! Use /testnotifications for demo')
