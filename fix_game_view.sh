# Let's fix GameView properly
cat << 'GAME' > src/features/game/GameView.tsx
import React, { useEffect, useReducer } from 'react';
import { useAppState } from '../../state/AppStateContext';
import { useWakeLock } from '../../hooks/useWakeLock';
import { useCountdown } from '../../hooks/useCountdown';
import { gameReducer, INITIAL_GAME_STATE } from './game.machine';
import { PROVOCATIONS } from './provocations/provocations.registry';
import { Stage } from '../../components/layout/Stage';
import { Button } from '../../components/ui/Button';
import { Badge } from '../../components/ui/Badge';
import { PlayIcon, PauseIcon, ShuffleIcon, CheckIcon } from '../../components/icons';
import { APP_CONFIG } from '../../config/app.config';
import styles from './GameView.module.scss';

export const GameView: React.FC = () => {
  const { session, updateSession } = useAppState();
  useWakeLock(true);
  const [gameState, dispatch] = useReducer(gameReducer, INITIAL_GAME_STATE);

  useEffect(() => {
    const saved = localStorage.getItem('codemotion-app:game');
    if (saved) { try { dispatch({ type: 'HYDRATE', state: JSON.parse(saved).data }); } catch(e){} }
  }, []);

  useEffect(() => {
    if (gameState !== INITIAL_GAME_STATE) localStorage.setItem('codemotion-app:game', JSON.stringify({ version: 1, data: gameState }));
  }, [gameState]);

  useEffect(() => { if (session.mode !== 'game') updateSession({ mode: 'game' }); }, []);

  const isPaused = gameState.timerDeadline !== null && gameState.timerDeadline < 0;
  const runningDeadline = isPaused ? null : gameState.timerDeadline;
  const currentCountdownSeconds = useCountdown(runningDeadline);
  const displaySeconds = isPaused ? Math.floor(Math.abs(gameState.timerDeadline!) / 1000) : currentCountdownSeconds;

  useEffect(() => { if (gameState.step === 'CHALLENGE' && !isPaused && displaySeconds === 0) dispatch({ type: 'CHALLENGE_TIMEOUT' }); }, [gameState.step, isPaused, displaySeconds]);

  const formatTime = (ts: number) => Math.floor(ts/60).toString().padStart(2,'0') + ':' + (ts%60).toString().padStart(2,'0');

  const getUnused = () => PROVOCATIONS.filter(p => !gameState.usedProvocationIds.includes(p.id) && !gameState.skippedProvocationIds.includes(p.id));
  const currentObj = PROVOCATIONS.find(p => p.id === gameState.currentProvocationId);
  const CurrentProv = currentObj?.component || null;

  return (
    <div className={styles.container}>
      <Stage>
        {gameState.discussedCount > 0 && gameState.step !== 'IDLE' && <div className={styles.statsBar}><Badge>Discusse: {gameState.discussedCount}</Badge></div>}

        {gameState.step === 'IDLE' && (
          <div className={styles.centerContent}>
            <h2 className={styles.title}>Voglio fare un gioco con te.</h2>
            <button className={styles.playButton} onClick={()=>dispatch({type:'PLAY'})} aria-label="Play"><PlayIcon /></button>
          </div>
        )}

        {gameState.step === 'CHALLENGE' && (
          <div className={styles.centerContent}>
            <div className={styles.giantTimer + ' ' + (displaySeconds <= 10 ? styles.danger : '')}>{formatTime(displaySeconds)}</div>
            <Button size="xl" onClick={()=>{
              if(!gameState.currentProvocationId){ const av = getUnused(); if(av.length>0) dispatch({type:'CHANGE_PROVOCATION', nextProvocationId: av[0].id}); }
              dispatch({type:'ACCEPT_CHALLENGE'});
            }}>Accetta Provocazione</Button>
          </div>
        )}

        {gameState.step === 'PROVOCATION' && (
          <>
            <div className={styles.provocationContainer}>{CurrentProv ? <CurrentProv /> : <div>Nessuna provocazione rimasta</div>}</div>
            <div className={styles.overlayControls}>
              <Button size="lg" onClick={()=>dispatch({type:'ACCEPT_PROVOCATION'})}><CheckIcon /> Accetta</Button>
              <Button size="lg" variant="secondary" onClick={()=>{
                const av = getUnused().filter(p=>p.id!==gameState.currentProvocationId);
                if(av.length>0) dispatch({type:'CHANGE_PROVOCATION', nextProvocationId: av[0].id});
                else alert("Non ci sono più provocazioni nuove!");
              }}><ShuffleIcon /> Cambia</Button>
            </div>
          </>
        )}

        {gameState.step === 'DISCUSSION' && (
          <div className={styles.centerContent}>
            <div className={styles.giantTimer + ' ' + (displaySeconds===0||displaySeconds<=APP_CONFIG.DANGER_THRESHOLD_SECONDS?styles.danger:displaySeconds<=APP_CONFIG.WARNING_THRESHOLD_SECONDS?styles.warning:'')}>{formatTime(displaySeconds)}</div>
            <div className={styles.controls}>
              {displaySeconds > 0 && <Button size="lg" variant="secondary" onClick={()=>isPaused?dispatch({type:'RESUME_DISCUSSION'}):dispatch({type:'PAUSE_DISCUSSION'})}>{isPaused ? <PlayIcon/> : <PauseIcon/>} {isPaused?'Riprendi':'Pausa'}</Button>}
              <Button size="lg" onClick={()=>dispatch({type:'NEXT_PROVOCATION'})}>Prossima Provocazione</Button>
            </div>
          </div>
        )}
      </Stage>
    </div>
  );
};
GAME
