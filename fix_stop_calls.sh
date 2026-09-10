cat << 'APP' > src/features/stopCalls/StopCallsOverlay.module.scss
.overlay {
  position: fixed; inset: 0; z-index: var(--z-overlay); background-color: var(--color-bg);
  display: flex; flex-direction: column; align-items: center; justify-content: center; text-align: center; padding: var(--space-8);
  &::before { content: ''; position: absolute; inset: 0; background: radial-gradient(circle at center, transparent 0%, rgba(0,0,0,0.8) 100%); pointer-events: none; }
}
.content { position: relative; z-index: 1; display: flex; flex-direction: column; align-items: center; gap: var(--space-12); }
.title { font-size: clamp(4rem, 10vw, 8rem); color: var(--color-danger); line-height: 1; text-transform: uppercase; font-weight: 900; letter-spacing: -0.02em; text-shadow: 0 8px 32px color-mix(in srgb, var(--color-danger) 50%, transparent); }
APP

cat << 'APP' > src/features/stopCalls/StopCallsOverlay.tsx
import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useAppState } from '../../state/AppStateContext';
import { useCountdown } from '../../hooks/useCountdown';
import { APP_CONFIG } from '../../config/app.config';
import { Button } from '../../components/ui/Button';
import { PhoneOffIcon } from '../../components/icons';
import styles from './StopCallsOverlay.module.scss';

export const StopCallsOverlay: React.FC = () => {
  const { config, session, updateSession, isConfigured } = useAppState();
  const navigate = useNavigate();
  const globalCountdown = useCountdown(config.endTimestamp);
  const [isOpen, setIsOpen] = useState(false);

  useEffect(() => {
    if (!isConfigured) return;
    if (globalCountdown === 0 && !session.stopCallsShown) {
      setIsOpen(true);
    }
  }, [globalCountdown, isConfigured, session.stopCallsShown]);

  useEffect(() => {
    if (isOpen) {
      const stopKeyboard = (e: KeyboardEvent) => e.stopPropagation();
      window.addEventListener('keydown', stopKeyboard, true);
      return () => window.removeEventListener('keydown', stopKeyboard, true);
    }
  }, [isOpen]);

  const handleProceed = () => {
    setIsOpen(false);
    updateSession({ stopCallsShown: true, mode: 'presentation', currentSlideIndex: APP_CONFIG.STOP_CALLS_TARGET_SLIDE_INDEX });
    navigate('/presentation');
  };

  if (!isOpen) return null;

  return (
    <div className={styles.overlay} role="dialog" aria-modal="true">
      <div className={styles.content}>
        <PhoneOffIcon size={120} color="var(--color-danger)" />
        <h1 className={styles.title}>Stop alle<br />telefonate</h1>
        <Button size="xl" variant="secondary" onClick={handleProceed}>Prosegui</Button>
      </div>
    </div>
  );
};
APP
