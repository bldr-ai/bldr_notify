import React, { useState, useCallback } from 'react';
import { useNuiEvent } from '../hooks/useNui';
import NotificationItem from './NotificationItem';

export interface Notification {
  id: string;
  type: 'error' | 'success' | 'info' | 'warning' | 'police' | 'ems' | 'news' | 'cityalert' | 'custom';
  title: string;
  message: string;
  duration: number;
  customData?: Record<string, any>;
  color?: string;
  backgroundColor?: string;
  icon?: string;
  sound?: boolean;
}

export default function NotificationContainer(): JSX.Element {
  const [notifications, setNotifications] = useState<Notification[]>([]);

  const addNotification = useCallback((notification: Omit<Notification, 'id'>) => {
    const id = `${Date.now()}-${Math.random()}`;
    const newNotification: Notification = {
      ...notification,
      id,
    };

    setNotifications((prev) => [...prev, newNotification]);

    // Play sound if enabled
    if (notification.sound !== false) {
      playNotificationSound(notification.type);
    }
  }, []);

  const removeNotification = useCallback((id: string) => {
    setNotifications((prev) => prev.filter((notif) => notif.id !== id));
  }, []);

  // Listen for notifications from Lua
  useNuiEvent<Omit<Notification, 'id'>>('addNotification', (data) => {
    console.log('[NotificationContainer] Received:', { title: data.title, duration: data.duration, type: data.type });
    addNotification(data);
  });

  const playNotificationSound = (type: string) => {
    // Map notification types to sounds
    const soundMap: Record<string, string> = {
      error: '❌',
      success: '✅',
      info: 'ℹ️',
      warning: '⚠️',
      police: '🚔',
      ems: '🚑',
      news: '📰',
      cityalert: '📢',
    };

    // You can add actual audio here if needed
    // For now, we'll just use visual feedback
  };

  return (
    <div className="fixed top-1/2 right-0 transform -translate-y-1/2 pointer-events-none p-6">
      <div className="flex flex-col gap-3 max-w-md">
        {notifications.map((notification) => (
          <NotificationItem
            key={notification.id}
            notification={notification}
            onRemove={() => removeNotification(notification.id)}
          />
        ))}
      </div>
    </div>
  );
}
