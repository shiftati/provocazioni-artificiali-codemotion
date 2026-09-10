#!/bin/bash
# Icons
cat << 'ICON' > src/components/icons/IconProps.ts
export interface IconProps extends React.SVGProps<SVGSVGElement> { size?: number | string; title?: string; }
ICON

cat << 'ICON' > src/components/icons/index.ts
export * from './PlayIcon'; export * from './PauseIcon'; export * from './ArrowLeftIcon'; export * from './ArrowRightIcon'; export * from './SettingsIcon'; export * from './ClockIcon'; export * from './FullscreenIcon'; export * from './ExitFullscreenIcon'; export * from './CheckIcon'; export * from './ShuffleIcon'; export * from './CloseIcon'; export * from './PhoneOffIcon';
ICON

cat << 'ICON' > src/components/icons/PlayIcon.tsx
import React from 'react'; import { IconProps } from './IconProps';
export const PlayIcon: React.FC<IconProps> = ({ size = '1em', title, ...props }) => (<svg width={size} height={size} viewBox="0 0 24 24" fill="currentColor" aria-hidden={!title} {...props}>{title && <title>{title}</title>}<path d="M8 5v14l11-7z" /></svg>);
ICON

cat << 'ICON' > src/components/icons/PauseIcon.tsx
import React from 'react'; import { IconProps } from './IconProps';
export const PauseIcon: React.FC<IconProps> = ({ size = '1em', title, ...props }) => (<svg width={size} height={size} viewBox="0 0 24 24" fill="currentColor" aria-hidden={!title} {...props}>{title && <title>{title}</title>}<path d="M6 19h4V5H6v14zm8-14v14h4V5h-4z" /></svg>);
ICON

cat << 'ICON' > src/components/icons/ArrowLeftIcon.tsx
import React from 'react'; import { IconProps } from './IconProps';
export const ArrowLeftIcon: React.FC<IconProps> = ({ size = '1em', title, ...props }) => (<svg width={size} height={size} viewBox="0 0 24 24" fill="currentColor" aria-hidden={!title} {...props}>{title && <title>{title}</title>}<path d="M15.41 16.59L10.83 12l4.58-4.59L14 6l-6 6 6 6 1.41-1.41z" /></svg>);
ICON

cat << 'ICON' > src/components/icons/ArrowRightIcon.tsx
import React from 'react'; import { IconProps } from './IconProps';
export const ArrowRightIcon: React.FC<IconProps> = ({ size = '1em', title, ...props }) => (<svg width={size} height={size} viewBox="0 0 24 24" fill="currentColor" aria-hidden={!title} {...props}>{title && <title>{title}</title>}<path d="M8.59 16.59L13.17 12 8.59 7.41 10 6l6 6-6 6-1.41-1.41z" /></svg>);
ICON

cat << 'ICON' > src/components/icons/SettingsIcon.tsx
import React from 'react'; import { IconProps } from './IconProps';
export const SettingsIcon: React.FC<IconProps> = ({ size = '1em', title, ...props }) => (<svg width={size} height={size} viewBox="0 0 24 24" fill="currentColor" aria-hidden={!title} {...props}>{title && <title>{title}</title>}<path d="M19.14 12.94c.04-.3.06-.61.06-.94 0-.32-.02-.64-.06-.94l2.03-1.58c.18-.14.23-.41.12-.61l-1.92-3.32c-.12-.22-.37-.29-.59-.22l-2.39.96c-.5-.38-1.03-.7-1.62-.94l-.36-2.54c-.04-.24-.24-.41-.48-.41h-3.84c-.24 0-.43.17-.47.41l-.36 2.54c-.59.24-1.13.57-1.62.94l-2.39-.96c-.22-.08-.47 0-.59.22L2.73 8.87c-.12.21-.08.47.12.61l2.03 1.58c-.05.3-.09.63-.09.94s.02.64.06.94l-2.03 1.58c-.18.14-.23.41-.12.61l1.92 3.32c.12.22.37.29.59.22l2.39-.96c.5.38 1.03.7 1.62.94l.36 2.54c.05.24.24.41.48.41h3.84c.24 0 .43-.17.47-.41l.36-2.54c.59-.24 1.13-.56 1.62-.94l2.39.96c.22.08.47 0 .59-.22l1.92-3.32c.12-.22.07-.47-.12-.61l-2.01-1.58zM12 15.6c-1.98 0-3.6-1.62-3.6-3.6s1.62-3.6 3.6-3.6 3.6 1.62 3.6 3.6-1.62 3.6-3.6 3.6z" /></svg>);
ICON

cat << 'ICON' > src/components/icons/ClockIcon.tsx
import React from 'react'; import { IconProps } from './IconProps';
export const ClockIcon: React.FC<IconProps> = ({ size = '1em', title, ...props }) => (<svg width={size} height={size} viewBox="0 0 24 24" fill="currentColor" aria-hidden={!title} {...props}>{title && <title>{title}</title>}<path d="M11.99 2C6.47 2 2 6.48 2 12s4.47 10 9.99 10C17.52 22 22 17.52 22 12S17.52 2 11.99 2zM12 20c-4.42 0-8-3.58-8-8s3.58-8 8-8 8 3.58 8 8-3.58 8-8 8z" /><path d="M12.5 7H11v6l5.25 3.15.75-1.23-4.5-2.67z" /></svg>);
ICON

cat << 'ICON' > src/components/icons/FullscreenIcon.tsx
import React from 'react'; import { IconProps } from './IconProps';
export const FullscreenIcon: React.FC<IconProps> = ({ size = '1em', title, ...props }) => (<svg width={size} height={size} viewBox="0 0 24 24" fill="currentColor" aria-hidden={!title} {...props}>{title && <title>{title}</title>}<path d="M7 14H5v5h5v-2H7v-3zm-2-4h2V7h3V5H5v5zm12 7h-3v2h5v-5h-2v3zM14 5v2h3v3h2V5h-5z" /></svg>);
ICON

cat << 'ICON' > src/components/icons/ExitFullscreenIcon.tsx
import React from 'react'; import { IconProps } from './IconProps';
export const ExitFullscreenIcon: React.FC<IconProps> = ({ size = '1em', title, ...props }) => (<svg width={size} height={size} viewBox="0 0 24 24" fill="currentColor" aria-hidden={!title} {...props}>{title && <title>{title}</title>}<path d="M5 16h3v3h2v-5H5v2zm3-8H5v2h5V5H8v3zm6 11h2v-3h3v-2h-5v5zm2-11V5h-2v5h5V8h-3z" /></svg>);
ICON

cat << 'ICON' > src/components/icons/CheckIcon.tsx
import React from 'react'; import { IconProps } from './IconProps';
export const CheckIcon: React.FC<IconProps> = ({ size = '1em', title, ...props }) => (<svg width={size} height={size} viewBox="0 0 24 24" fill="currentColor" aria-hidden={!title} {...props}>{title && <title>{title}</title>}<path d="M9 16.17L4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41z" /></svg>);
ICON

cat << 'ICON' > src/components/icons/ShuffleIcon.tsx
import React from 'react'; import { IconProps } from './IconProps';
export const ShuffleIcon: React.FC<IconProps> = ({ size = '1em', title, ...props }) => (<svg width={size} height={size} viewBox="0 0 24 24" fill="currentColor" aria-hidden={!title} {...props}>{title && <title>{title}</title>}<path d="M10.59 9.17L5.41 4 4 5.41l5.17 5.17 1.42-1.41zM14.5 4l2.04 2.04L4 18.59 5.41 20 17.96 7.46 20 9.5V4h-5.5zm.33 9.41l-1.41 1.41 3.13 3.13L14.5 20H20v-5.5l-2.04 2.04-3.13-3.13z" /></svg>);
ICON

cat << 'ICON' > src/components/icons/CloseIcon.tsx
import React from 'react'; import { IconProps } from './IconProps';
export const CloseIcon: React.FC<IconProps> = ({ size = '1em', title, ...props }) => (<svg width={size} height={size} viewBox="0 0 24 24" fill="currentColor" aria-hidden={!title} {...props}>{title && <title>{title}</title>}<path d="M19 6.41L17.59 5 12 10.59 6.41 5 5 6.41 10.59 12 5 17.59 6.41 19 12 13.41 17.59 19 19 17.59 13.41 12z" /></svg>);
ICON

cat << 'ICON' > src/components/icons/PhoneOffIcon.tsx
import React from 'react'; import { IconProps } from './IconProps';
export const PhoneOffIcon: React.FC<IconProps> = ({ size = '1em', title, ...props }) => (<svg width={size} height={size} viewBox="0 0 24 24" fill="currentColor" aria-hidden={!title} {...props}>{title && <title>{title}</title>}<path d="M1.04 1.76l1.46-1.46 20.3 20.3-1.46 1.46-4.63-4.63C16.14 17.7 15.6 18 15 18c-.83 0-1.5-.67-1.5-1.5v-3c0-.83.67-1.5 1.5-1.5.3 0 .57.1.8.27l1.32-1.32c-.52-.6-1.12-1.13-1.77-1.57L1.04 1.76zM4.3 6.64c-.17-.23-.27-.5-.27-.8V2.85c0-.83.67-1.5 1.5-1.5C11.51 1.35 16.8 5.48 18.52 11.23L4.3 6.64zM22.04 12c0 2.22-.72 4.28-1.93 5.96L8.43 6.27C4.65 8 1.95 11.66 1.95 16c0 1.25.18 2.45.5 3.58l1.46-1.46c-.05-.18-.1-.36-.15-.55-.17-.7-.27-1.42-.27-2.17 0-3.66 2.06-6.85 5.09-8.48l1.6 1.6C9.17 9 8.1 10.42 8.1 12c0 2.21 1.79 4 4 4 1.58 0 3-1.07 3.63-2.52l1.6 1.6c-1.63 2.1-4.14 3.42-6.94 3.42-3.1 0-5.83-1.56-7.46-3.95l1.46-1.46z" /></svg>);
ICON

# State & Hooks
cat << 'STATE' > src/state/storage.ts
type StorageKey = 'codemotion-app:config' | 'codemotion-app:session' | 'codemotion-app:game' | 'codemotion-app:stats';
export const getItem = <T>(key: StorageKey, defaultValue: T): T => {
  try { const item = localStorage.getItem(key); return item ? JSON.parse(item).data : defaultValue; }
  catch (e) { return defaultValue; }
};
export const setItem = <T>(key: StorageKey, value: T, version = 1): void => {
  try { localStorage.setItem(key, JSON.stringify({ version, data: value })); } catch (e) {}
};
STATE

cat << 'STATE' > src/hooks/usePersistentState.ts
import { useState, useEffect } from 'react';
import { getItem, setItem } from '../state/storage';
export function usePersistentState<T>(key: any, defaultValue: T) {
  const [state, setState] = useState<T>(() => getItem(key, defaultValue));
  useEffect(() => { setItem(key, state); }, [key, state]);
  return [state, setState] as const;
}
STATE

cat << 'STATE' > src/hooks/useCountdown.ts
import { useState, useEffect, useCallback } from 'react';
export function useCountdown(endTimestamp: number | null) {
  const calculate = useCallback(() => endTimestamp ? Math.max(0, Math.floor((endTimestamp - Date.now()) / 1000)) : 0, [endTimestamp]);
  const [timeLeft, setTimeLeft] = useState(calculate);
  useEffect(() => {
    setTimeLeft(calculate());
    if (endTimestamp) { const id = setInterval(() => setTimeLeft(calculate()), 250); return () => clearInterval(id); }
  }, [endTimestamp, calculate]);
  return timeLeft;
}
STATE

cat << 'STATE' > src/state/AppStateContext.tsx
import React, { createContext, useContext } from 'react';
import { usePersistentState } from '../hooks/usePersistentState';
export type AppMode = 'presentation' | 'game';
export interface AppConfig { endTime: string; endTimestamp: number | null; }
export interface AppSession { currentSlideIndex: number; mode: AppMode; stopCallsShown: boolean; }
const DEFAULT_CONFIG: AppConfig = { endTime: '', endTimestamp: null };
const DEFAULT_SESSION: AppSession = { currentSlideIndex: 0, mode: 'presentation', stopCallsShown: false };
const AppStateContext = createContext<any>(undefined);
export const AppStateProvider: React.FC<{children: React.ReactNode}> = ({ children }) => {
  const [config, setConfig] = usePersistentState<AppConfig>('codemotion-app:config', DEFAULT_CONFIG);
  const [session, setSession] = usePersistentState<AppSession>('codemotion-app:session', DEFAULT_SESSION);
  const updateSession = (u: any) => setSession((p:any) => ({ ...p, ...u }));
  const clearConfig = () => { setConfig(DEFAULT_CONFIG); setSession(DEFAULT_SESSION); localStorage.removeItem('codemotion-app:game'); };
  return <AppStateContext.Provider value={{ config, setConfig, session, setSession, updateSession, clearConfig, isConfigured: !!config.endTimestamp }}>{children}</AppStateContext.Provider>;
};
export const useAppState = () => useContext(AppStateContext);
STATE

cat << 'HOOK' > src/hooks/useStageScale.ts
import { useState, useEffect, RefObject } from 'react';
import { APP_CONFIG } from '../config/app.config';
export function useStageScale(containerRef: RefObject<HTMLElement | null>) {
  const [scale, setScale] = useState(1);
  useEffect(() => {
    const calc = () => {
      if (!containerRef.current) return;
      const { width, height } = containerRef.current.getBoundingClientRect();
      setScale(Math.min(width / APP_CONFIG.STAGE_WIDTH, height / APP_CONFIG.STAGE_HEIGHT));
    };
    calc();
    const obs = new ResizeObserver(calc);
    if (containerRef.current) obs.observe(containerRef.current);
    return () => obs.disconnect();
  }, [containerRef]);
  return scale;
}
HOOK

cat << 'HOOK' > src/hooks/useKeyboardNavigation.ts
import { useEffect } from 'react';
export function useKeyboardNavigation(handlers: {key: string | string[], handler: (e: KeyboardEvent)=>void}[], isActive = true) {
  useEffect(() => {
    if (!isActive) return;
    const handle = (e: KeyboardEvent) => {
      if (['INPUT','TEXTAREA','SELECT'].includes((e.target as HTMLElement).tagName)) return;
      for (const h of handlers) {
        const keys = Array.isArray(h.key) ? h.key : [h.key];
        if (keys.includes(e.key)) { e.preventDefault(); h.handler(e); return; }
      }
    };
    window.addEventListener('keydown', handle); return () => window.removeEventListener('keydown', handle);
  }, [handlers, isActive]);
}
HOOK

cat << 'HOOK' > src/hooks/useFullscreen.ts
import { useCallback } from 'react';
export function useFullscreen() {
  const requestFullscreen = useCallback(async (el: HTMLElement) => { try { if (!document.fullscreenElement) await el.requestFullscreen(); } catch (e) {} }, []);
  return { requestFullscreen };
}
HOOK

cat << 'HOOK' > src/hooks/useWakeLock.ts
import { useEffect, useRef } from 'react';
export function useWakeLock(isActive = true) {
  const wakeLockRef = useRef<any>(null);
  useEffect(() => {
    if (!isActive) { if (wakeLockRef.current) wakeLockRef.current.release(); return; }
    const req = async () => { try { if ('wakeLock' in navigator) wakeLockRef.current = await (navigator as any).wakeLock.request('screen'); } catch (e) {} };
    req();
    const handler = () => { if (wakeLockRef.current !== null && document.visibilityState === 'visible') req(); };
    document.addEventListener('visibilitychange', handler);
    return () => { document.removeEventListener('visibilitychange', handler); if (wakeLockRef.current) wakeLockRef.current.release(); };
  }, [isActive]);
}
HOOK
