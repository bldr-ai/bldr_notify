import { useEffect, useRef } from 'react';

const isDebug = typeof (window as any).GetParentResourceName !== 'function';

export const debugData: Record<string, unknown> = {};

export function debugNuiEvent(action: string, data: unknown) {
  window.dispatchEvent(new MessageEvent('message', { data: { action, ...data } }));
}

export function useNuiEvent<T = unknown>(action: string, handler: (data: T) => void) {
  const savedHandler = useRef(handler);
  useEffect(() => { savedHandler.current = handler; }, [handler]);
  useEffect(() => {
    function eventListener(event: MessageEvent) {
      const { action: eventAction, ...rest } = event.data || {};
      if (eventAction === action) savedHandler.current(rest as T);
    }
    window.addEventListener('message', eventListener);
    return () => window.removeEventListener('message', eventListener);
  }, [action]);
}

export async function fetchNui<T = unknown>(eventName: string, data: Record<string, unknown> = {}): Promise<T> {
  if (isDebug) {
    const mock = debugData[eventName];
    if (mock !== undefined) return mock as T;
    console.warn(`[Debug] No mock for '${eventName}'. Add to debugData.`);
    return {} as T;
  }
  const resourceName = (window as any).GetParentResourceName();
  const response = await fetch(`https://${resourceName}/${eventName}`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(data),
  });
  return response.json();
}

if (isDebug) {
  setTimeout(() => debugNuiEvent('setVisible', { visible: true }), 100);
}
