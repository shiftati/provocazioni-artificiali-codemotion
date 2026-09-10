import React from 'react';
import { useNavigate, useLocation } from 'react-router-dom';
import { useAppState } from '../../state/AppStateContext';
import { Toggle } from '../ui/Toggle';
import { CountdownDisplay } from '../ui/CountdownDisplay';
import { useCountdown } from '../../hooks/useCountdown';
import { APP_CONFIG } from '../../config/app.config';
import { LogoPlaceholder } from './LogoPlaceholder';
import styles from './AppShell.module.scss';

export const AppShell: React.FC<{children: React.ReactNode}> = ({ children }) => {
  const { config, session, updateSession } = useAppState();
  const navigate = useNavigate();
  const location = useLocation();
  const globalCountdown = useCountdown(config.endTimestamp);
  const isHome = location.pathname === '/';
  return (
    <div className={styles.appShell}>
      {!isHome && (
        <header className={styles.chrome}>
          <div className={styles.chromeLeft}><LogoPlaceholder className={styles.logo} /></div>
          <div className={styles.chromeCenter}>
            <Toggle options={[{ label: 'Slide', value: 'presentation' }, { label: 'Gioco', value: 'game' }]} value={session.mode} onChange={(m) => { updateSession({ mode: m }); navigate('/'+m); }} />
          </div>
          <div className={styles.chromeRight}>
            {config.endTimestamp && <div className={styles.countdownWrapper}><CountdownDisplay seconds={globalCountdown} warningThreshold={APP_CONFIG.WARNING_THRESHOLD_SECONDS} dangerThreshold={APP_CONFIG.DANGER_THRESHOLD_SECONDS}/></div>}
          </div>
        </header>
      )}
      <main className={styles.content}>{children}</main>
    </div>
  );
};
