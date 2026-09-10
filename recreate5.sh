#!/bin/bash
cat << 'APP' > src/features/presentation/slides/SlideLayouts.module.scss
.slide { width: 100%; height: 100%; padding: var(--space-16); display: flex; flex-direction: column; }
.center { align-items: center; justify-content: center; text-align: center; }
.title { margin-bottom: var(--space-8); color: var(--color-accent); }
.subtitle { font-size: 2rem; color: var(--color-text-muted); }
.content { flex: 1; font-size: 1.5rem; line-height: 1.6; }
APP

cat << 'APP' > src/features/presentation/slides/Slide01.tsx
import React from 'react'; import styles from './SlideLayouts.module.scss';
export const Slide01: React.FC = () => <div className={`${styles.slide} ${styles.center}`}><h1 className={styles.title}>Title 1</h1></div>;
APP
cat << 'APP' > src/features/presentation/slides/Slide02.tsx
import React from 'react'; import styles from './SlideLayouts.module.scss';
export const Slide02: React.FC = () => <div className={`${styles.slide} ${styles.center}`}><h1 className={styles.title}>Title 2</h1></div>;
APP
cat << 'APP' > src/features/presentation/slides/Slide03.tsx
import React from 'react'; import styles from './SlideLayouts.module.scss';
export const Slide03: React.FC = () => <div className={`${styles.slide} ${styles.center}`}><h1 className={styles.title}>Title 3</h1></div>;
APP
cat << 'APP' > src/features/presentation/slides/Slide04.tsx
import React from 'react'; import styles from './SlideLayouts.module.scss';
export const Slide04: React.FC = () => <div className={`${styles.slide} ${styles.center}`}><h1 className={styles.title}>Title 4</h1></div>;
APP
cat << 'APP' > src/features/presentation/slides/Slide05.tsx
import React from 'react'; import styles from './SlideLayouts.module.scss';
export const Slide05: React.FC = () => <div className={`${styles.slide} ${styles.center}`}><h1 className={styles.title}>Title 5</h1></div>;
APP
cat << 'APP' > src/features/presentation/slides/slides.registry.ts
import { Slide01 } from './Slide01'; import { Slide02 } from './Slide02'; import { Slide03 } from './Slide03'; import { Slide04 } from './Slide04'; import { Slide05 } from './Slide05';
export const SLIDES = [ { id: 'intro', title: 'Intro', component: Slide01 }, { id: 'problem', title: 'Il Problema', component: Slide02 }, { id: 'solution', title: 'La Soluzione', component: Slide03 }, { id: 'game-intro', title: 'Modalità Gioco', component: Slide04 }, { id: 'outro', title: 'Grazie', component: Slide05 } ];
APP

cat << 'APP' > src/features/presentation/PresentationView.module.scss
.presentation { width: 100%; height: 100%; position: relative; }
.controls { position: absolute; bottom: var(--space-4); left: 0; right: 0; display: flex; justify-content: center; align-items: center; gap: var(--space-4); pointer-events: none; z-index: var(--z-chrome); }
.controlButton { pointer-events: auto; opacity: 0; transition: opacity var(--duration-fast) var(--ease); &:focus-visible, .presentation:hover & { opacity: 1; } }
.indicator { font-family: var(--font-mono); font-size: 0.875rem; color: var(--color-text-muted); background-color: color-mix(in srgb, var(--color-bg) 80%, transparent); padding: var(--space-1) var(--space-2); border-radius: var(--radius-sm); pointer-events: none; opacity: 0; .presentation:hover & { opacity: 1; } }
APP

cat << 'APP' > src/features/presentation/PresentationView.tsx
import React, { useEffect } from 'react';
import { useAppState } from '../../state/AppStateContext';
import { useKeyboardNavigation } from '../../hooks/useKeyboardNavigation';
import { useWakeLock } from '../../hooks/useWakeLock';
import { Stage } from '../../components/layout/Stage';
import { IconButton } from '../../components/ui/IconButton';
import { ArrowLeftIcon, ArrowRightIcon } from '../../components/icons';
import { SLIDES } from './slides/slides.registry';
import styles from './PresentationView.module.scss';

export const PresentationView: React.FC = () => {
  const { session, updateSession } = useAppState();
  useWakeLock(true);
  const currentIndex = Math.min(Math.max(0, session.currentSlideIndex), SLIDES.length - 1);
  const CurrentSlide = SLIDES[currentIndex]?.component;
  const nextSlide = () => { if (currentIndex < SLIDES.length - 1) updateSession({ currentSlideIndex: currentIndex + 1 }); };
  const prevSlide = () => { if (currentIndex > 0) updateSession({ currentSlideIndex: currentIndex - 1 }); };
  useKeyboardNavigation([ { key: ['ArrowRight', 'PageDown', ' '], handler: nextSlide }, { key: ['ArrowLeft', 'PageUp'], handler: prevSlide } ]);
  useEffect(() => { if (session.mode !== 'presentation') updateSession({ mode: 'presentation' }); }, []);
  if (!CurrentSlide) return <div>No slides</div>;
  return (
    <div className={styles.presentation}>
      <Stage><CurrentSlide /></Stage>
      <div className={styles.controls}>
        <IconButton className={styles.controlButton} onClick={prevSlide} disabled={currentIndex === 0} aria-label="Prev"><ArrowLeftIcon /></IconButton>
        <div className={styles.indicator}>{currentIndex + 1} / {SLIDES.length}</div>
        <IconButton className={styles.controlButton} onClick={nextSlide} disabled={currentIndex === SLIDES.length - 1} aria-label="Next"><ArrowRightIcon /></IconButton>
      </div>
    </div>
  );
};
APP

# Game
cat << 'APP' > src/features/game/game.machine.ts
import { APP_CONFIG } from '../../config/app.config';
export type GameStep = 'IDLE' | 'CHALLENGE' | 'PROVOCATION' | 'DISCUSSION';
export interface GameState { step: GameStep; timerDeadline: number | null; currentProvocationId: string | null; usedProvocationIds: string[]; skippedProvocationIds: string[]; discussedCount: number; isFirstLoop: boolean; }
export type GameAction = { type: 'PLAY' } | { type: 'ACCEPT_CHALLENGE' } | { type: 'CHALLENGE_TIMEOUT' } | { type: 'ACCEPT_PROVOCATION' } | { type: 'CHANGE_PROVOCATION'; nextProvocationId: string | null } | { type: 'NEXT_PROVOCATION' } | { type: 'PAUSE_DISCUSSION' } | { type: 'RESUME_DISCUSSION' } | { type: 'HYDRATE'; state: GameState };
export const INITIAL_GAME_STATE: GameState = { step: 'IDLE', timerDeadline: null, currentProvocationId: null, usedProvocationIds: [], skippedProvocationIds: [], discussedCount: 0, isFirstLoop: true };
export function gameReducer(state: GameState, action: GameAction): GameState {
  const now = Date.now();
  switch (action.type) {
    case 'HYDRATE': return action.state;
    case 'PLAY': return state.isFirstLoop ? { ...state, step: 'PROVOCATION', timerDeadline: null } : { ...state, step: 'CHALLENGE', timerDeadline: now + APP_CONFIG.GAME_CHALLENGE_SECONDS * 1000 };
    case 'ACCEPT_CHALLENGE': return { ...state, step: 'DISCUSSION', timerDeadline: now + APP_CONFIG.GAME_DISCUSSION_SECONDS * 1000, discussedCount: state.discussedCount + 1, usedProvocationIds: state.currentProvocationId ? [...state.usedProvocationIds, state.currentProvocationId] : state.usedProvocationIds };
    case 'CHALLENGE_TIMEOUT': return { ...state, step: 'PROVOCATION', timerDeadline: null };
    case 'ACCEPT_PROVOCATION': return { ...state, step: 'DISCUSSION', timerDeadline: now + APP_CONFIG.GAME_DISCUSSION_SECONDS * 1000, discussedCount: state.discussedCount + 1, usedProvocationIds: state.currentProvocationId ? [...state.usedProvocationIds, state.currentProvocationId] : state.usedProvocationIds };
    case 'CHANGE_PROVOCATION': return { ...state, skippedProvocationIds: state.currentProvocationId ? [...state.skippedProvocationIds, state.currentProvocationId] : state.skippedProvocationIds, currentProvocationId: action.nextProvocationId };
    case 'NEXT_PROVOCATION': return { ...state, step: 'IDLE', timerDeadline: null, isFirstLoop: false };
    case 'PAUSE_DISCUSSION': return { ...state, timerDeadline: state.timerDeadline ? -(state.timerDeadline - now) : null };
    case 'RESUME_DISCUSSION': return { ...state, timerDeadline: state.timerDeadline ? now + (-state.timerDeadline) : null };
    default: return state;
  }
}
APP

cat << 'APP' > src/features/game/provocations/provocations.registry.ts
export const PROVOCATIONS = [
  { id: '1', title: 'P1', component: () => null },
  { id: '2', title: 'P2', component: () => null }
];
APP

cat << 'APP' > src/features/game/GameView.module.scss
.container { width: 100%; height: 100%; position: relative; background-color: var(--color-bg); }
APP

cat << 'APP' > src/features/game/GameView.tsx
import React, { useEffect, useReducer } from 'react';
import { useAppState } from '../../state/AppStateContext';
import { gameReducer, INITIAL_GAME_STATE } from './game.machine';
import styles from './GameView.module.scss';
export const GameView: React.FC = () => {
  return <div className={styles.container}>Game</div>;
};
APP

cat << 'APP' > src/features/stopCalls/StopCallsOverlay.module.scss
.overlay { position: fixed; inset: 0; z-index: 1000; background: red; }
APP

cat << 'APP' > src/features/stopCalls/StopCallsOverlay.tsx
import React from 'react';
export const StopCallsOverlay: React.FC = () => null;
APP

cat << 'APP' > src/App.tsx
import React from 'react';
import { HashRouter, Routes, Route, Navigate } from 'react-router-dom';
import { AppStateProvider } from './state/AppStateContext';
import { AppShell } from './components/layout/AppShell';

import { ConfigView } from './features/config/ConfigView';
import { PresentationView } from './features/presentation/PresentationView';
import { GameView } from './features/game/GameView';
import { StopCallsOverlay } from './features/stopCalls/StopCallsOverlay';

const AppRoutes = () => {
  return (
    <>
      <AppShell>
        <Routes>
          <Route path="/" element={<ConfigView />} />
          <Route path="/presentation" element={<PresentationView />} />
          <Route path="/game" element={<GameView />} />
          <Route path="*" element={<Navigate to="/" replace />} />
        </Routes>
      </AppShell>
      <StopCallsOverlay />
    </>
  );
};

function App() {
  return (
    <AppStateProvider>
      <HashRouter>
        <AppRoutes />
      </HashRouter>
    </AppStateProvider>
  );
}
export default App;
APP
