import React, { useEffect, useState } from 'react';
import {
  AlertCircle,
  CheckCircle,
  Info,
  AlertTriangle,
  Shield,
  Ambulance,
  Newspaper,
  Bell,
  X,
} from 'lucide-react';
import { Notification } from './NotificationContainer';

interface Props {
  notification: Notification;
  onRemove: () => void;
}

export default function NotificationItem({ notification, onRemove }: Props): JSX.Element {
  const [isExiting, setIsExiting] = useState(false);

  useEffect(() => {
    console.log(`[Notification] ${notification.title} - Duration: ${notification.duration}ms`);
    
    if (notification.duration <= 0) return;

    const timer = setTimeout(() => {
      console.log(`[Notification] ${notification.title} - Starting exit animation`);
      setIsExiting(true);
      setTimeout(onRemove, 600);
    }, notification.duration);

    return () => {
      clearTimeout(timer);
    };
  }, [notification.duration, onRemove, notification.title]);

  const handleClose = () => {
    setIsExiting(true);
    setTimeout(onRemove, 600);
  };

  const getStyles = () => {
    const baseStyles =
      'pointer-events-auto rounded-lg shadow-2xl overflow-hidden transform transition-all duration-500';

    const typeStyles: Record<string, string> = {
      error: 'bg-gradient-to-br from-red-950 to-red-900 border border-red-700/50',
      success: 'bg-gradient-to-br from-emerald-950 to-emerald-900 border border-emerald-700/50',
      info: 'bg-gradient-to-br from-blue-950 to-blue-900 border border-blue-700/50',
      warning: 'bg-gradient-to-br from-amber-950 to-amber-900 border border-amber-700/50',
      police: 'bg-gradient-to-br from-blue-950 via-blue-900 to-slate-900 border border-blue-600/50 shadow-blue-900/50',
      ems: 'bg-gradient-to-br from-red-950 via-red-900 to-slate-900 border border-red-600/50 shadow-red-900/50',
      news: 'bg-gradient-to-br from-purple-950 to-purple-900 border border-purple-700/50',
      cityalert: 'bg-gradient-to-br from-orange-950 to-orange-900 border border-orange-700/50',
      custom: notification.backgroundColor
        ? `border border-opacity-30`
        : 'bg-gradient-to-br from-slate-900 to-slate-800 border border-slate-700/50',
    };

    const style = {
      backgroundColor:
        notification.type === 'custom' && notification.backgroundColor
          ? notification.backgroundColor
          : undefined,
    };

    return {
      className: `${baseStyles} ${typeStyles[notification.type] || typeStyles.info} ${
        isExiting ? 'opacity-0 translate-x-[120%]' : 'opacity-100 translate-x-0'
      }`,
      style,
    };
  };

  const getIcon = () => {
    const iconProps = 'w-6 h-6 flex-shrink-0';
    const colorClasses: Record<string, string> = {
      error: 'text-red-400',
      success: 'text-emerald-400',
      info: 'text-blue-400',
      warning: 'text-amber-400',
      police: 'text-blue-300',
      ems: 'text-red-300',
      news: 'text-purple-400',
      cityalert: 'text-orange-400',
      custom: notification.color ? '' : 'text-slate-400',
    };

    const color =
      notification.type === 'custom' && notification.icon
        ? ''
        : colorClasses[notification.type] || colorClasses.info;

    switch (notification.type) {
      case 'error':
        return <AlertCircle className={`${iconProps} ${color}`} />;
      case 'success':
        return <CheckCircle className={`${iconProps} ${color}`} />;
      case 'info':
        return <Info className={`${iconProps} ${color}`} />;
      case 'warning':
        return <AlertTriangle className={`${iconProps} ${color}`} />;
      case 'police':
        return <Shield className={`${iconProps} ${color}`} />;
      case 'ems':
        return <Ambulance className={`${iconProps} ${color}`} />;
      case 'news':
        return <Newspaper className={`${iconProps} ${color}`} />;
      case 'cityalert':
        return <Bell className={`${iconProps} ${color}`} />;
      case 'custom':
        return notification.icon ? (
          <span className={`${iconProps} text-2xl flex items-center justify-center`}>{notification.icon}</span>
        ) : (
          <Bell className={`${iconProps} ${color}`} />
        );
      default:
        return <Bell className={`${iconProps} ${color}`} />;
    }
  };

  const getLocationDisplay = () => {
    if ((notification.type === 'police' || notification.type === 'ems') && notification.customData?.location) {
      return (
        <div className="text-xs text-gray-400 mt-2 flex items-center gap-1.5">
          <span className="text-lg">📍</span>
          <span>{notification.customData.location}</span>
        </div>
      );
    }
    return null;
  };

  const getTimestamp = () => {
    const now = new Date();
    return now.toLocaleTimeString('en-US', {
      hour: '2-digit',
      minute: '2-digit',
      hour12: true,
    });
  };

  const styles = getStyles();

  return (
    <div className={styles.className} style={styles.style}>
      {/* Pulse animation for urgent alerts */}
      {(notification.type === 'police' || notification.type === 'ems') && !isExiting && (
        <div className="absolute inset-0 animate-pulse pointer-events-none">
          <div
            className={`absolute inset-0 ${
              notification.type === 'police'
                ? 'bg-blue-500/20'
                : 'bg-red-500/20'
            }`}
          />
        </div>
      )}

      <div className="p-4 flex gap-4 relative z-10">
        {/* Icon */}
        <div className="flex-shrink-0 mt-0.5">{getIcon()}</div>

        {/* Content */}
        <div className="flex-1 min-w-0">
          <div className="flex items-start justify-between gap-3">
            <div className="flex-1">
              <h3 className="font-bold text-sm text-white">
                {notification.title || 'Notification'}
              </h3>
              <p className="text-xs text-gray-300 mt-1">
                {notification.message}
              </p>
              {getLocationDisplay()}
            </div>
            <div className="flex flex-col items-end gap-2 flex-shrink-0">
              <span className="text-xs text-gray-500">
                {getTimestamp()}
              </span>
              <button
                onClick={handleClose}
                className="p-1 hover:bg-white/10 rounded transition-colors duration-200"
                aria-label="Close notification"
              >
                <X className="w-4 h-4 text-gray-400 hover:text-white" />
              </button>
            </div>
          </div>
        </div>
      </div>

      {/* Progress bar */}
      {!isExiting && (
        <div className="absolute bottom-0 left-0 right-0 h-1 bg-white/10 overflow-hidden">
          <div
            className={`h-full ${
              notification.type === 'error'
                ? 'bg-red-500'
                : notification.type === 'success'
                  ? 'bg-emerald-500'
                  : notification.type === 'warning'
                    ? 'bg-amber-500'
                    : notification.type === 'police'
                      ? 'bg-blue-500'
                      : notification.type === 'ems'
                        ? 'bg-red-500'
                        : notification.type === 'news'
                          ? 'bg-purple-500'
                          : notification.type === 'cityalert'
                            ? 'bg-orange-500'
                            : 'bg-blue-500'
            }`}
            style={{
              width: '100%',
              animation: `shrinkWidth ${notification.duration}ms linear forwards`,
            }}
          />
        </div>
      )}
    </div>
  );
}
