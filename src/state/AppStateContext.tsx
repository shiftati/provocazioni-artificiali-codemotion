import React, { createContext, useContext } from 'react';
import { usePersistentState } from '../hooks/usePersistentState';

export type AppMode = 'presentation' | 'game';
export interface AppConfig { endTime: string; endTimestamp: number | null; }
export interface AppSession { currentSlideIndex: number; mode: AppMode; stopCallsShown: boolean; }

const DEFAULT_CONFIG: AppConfig = { endTime: '', endTimestamp: null };
const DEFAULT_SESSION: AppSession = { currentSlideIndex: 0, mode: 'presentation', stopCallsShown: false };

export interface AppStateContextValue {
  config: AppConfig;
  setConfig: React.Dispatch<React.SetStateAction<AppConfig>>;
  session: AppSession;
  setSession: React.Dispatch<React.SetStateAction<AppSession>>;
  updateSession: (update: Partial<AppSession>) => void;
  clearConfig: () => void;
  isConfigured: boolean;
}

const AppStateContext = createContext<AppStateContextValue | undefined>(undefined);

export const AppStateProvider: React.FC<{children: React.ReactNode}> = ({ children }) => {
  const [config, setConfig] = usePersistentState<AppConfig>('codemotion-app:config', DEFAULT_CONFIG);
  const [session, setSession] = usePersistentState<AppSession>('codemotion-app:session', DEFAULT_SESSION);
  const updateSession = (u: Partial<AppSession>) => setSession((p: AppSession) => ({ ...p, ...u }));
  const clearConfig = () => { setConfig(DEFAULT_CONFIG); setSession(DEFAULT_SESSION); localStorage.removeItem('codemotion-app:game'); };

  return (
    <AppStateContext.Provider value={{ config, setConfig, session, setSession, updateSession, clearConfig, isConfigured: !!config.endTimestamp }}>
      {children}
    </AppStateContext.Provider>
  );
};

export const useAppState = (): AppStateContextValue => {
  const context = useContext(AppStateContext);
  if (!context) {
    throw new Error('useAppState must be used within an AppStateProvider');
  }
  return context;
};
