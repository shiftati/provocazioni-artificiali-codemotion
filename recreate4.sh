#!/bin/bash
# Layout, Features
cat << 'FEAT' > src/components/layout/Stage.module.scss
.stageContainer { flex: 1; width: 100%; height: 100%; display: flex; align-items: center; justify-content: center; overflow: hidden; position: relative; }
.stage { position: relative; transform-origin: center; background-color: var(--color-bg); color: var(--color-text); overflow: hidden; box-shadow: 0 0 0 1px var(--color-border); }
FEAT

cat << 'FEAT' > src/components/layout/Stage.tsx
import React, { useRef } from 'react';
import { useStageScale } from '../../hooks/useStageScale';
import { APP_CONFIG } from '../../config/app.config';
import styles from './Stage.module.scss';
export const Stage: React.FC<{children: React.ReactNode}> = ({ children }) => {
  const containerRef = useRef<HTMLDivElement>(null);
  const scale = useStageScale(containerRef);
  return (
    <div className={styles.stageContainer} ref={containerRef}>
      <div className={styles.stage} style={{ width: APP_CONFIG.STAGE_WIDTH, height: APP_CONFIG.STAGE_HEIGHT, transform: \`scale(\${scale})\` }}>
        {children}
      </div>
    </div>
  );
};
FEAT

cat << 'FEAT' > src/components/layout/AppShell.module.scss
.appShell { display: flex; flex-direction: column; height: 100vh; width: 100vw; overflow: hidden; }
.chrome { position: absolute; top: 0; left: 0; right: 0; z-index: var(--z-chrome); padding: var(--space-4) var(--space-6); display: flex; align-items: center; justify-content: space-between; pointer-events: none; }
.chromeLeft, .chromeCenter, .chromeRight { pointer-events: auto; display: flex; align-items: center; }
.chromeCenter { position: absolute; left: 50%; transform: translateX(-50%); }
.logo { height: 32px; }
.countdownWrapper { background-color: color-mix(in srgb, var(--color-bg) 80%, transparent); backdrop-filter: blur(4px); padding: var(--space-2) var(--space-4); border-radius: var(--radius-pill); font-size: 1.5rem; }
.content { flex: 1; position: relative; z-index: var(--z-stage); }
FEAT

cat << 'FEAT' > src/components/layout/LogoPlaceholder.tsx
import React from 'react';
export const LogoPlaceholder: React.FC<{className?: string}> = ({ className }) => (
  <svg className={className} viewBox="0 0 200 40" fill="none"><text x="10" y="25" fill="var(--color-text)" fontFamily="var(--font-display)" fontSize="20" fontWeight="bold">SHIFTATI DI TESTA</text></svg>
);
FEAT

cat << 'FEAT' > src/components/layout/AppShell.tsx
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
FEAT

cat << 'FEAT' > src/features/config/ConfigView.module.scss
.container { height: 100%; display: flex; flex-direction: column; align-items: center; justify-content: center; padding: var(--space-8); }
.card { width: 100%; max-width: 480px; }
.logo { height: 64px; margin-bottom: var(--space-8); }
.footer { margin-top: var(--space-8); color: var(--color-text-muted); font-size: 0.875rem; }
FEAT

cat << 'FEAT' > src/features/config/ConfigView.tsx
import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useAppState } from '../../state/AppStateContext';
import { useFullscreen } from '../../hooks/useFullscreen';
import { Button } from '../../components/ui/Button';
import { Card } from '../../components/ui/Card';
import { TimeInput } from '../../components/ui/TimeInput';
import { Stack } from '../../components/ui/Stack';
import { Cluster } from '../../components/ui/Cluster';
import { LogoPlaceholder } from '../../components/layout/LogoPlaceholder';
import styles from './ConfigView.module.scss';

export const ConfigView: React.FC = () => {
  const { config, setConfig, isConfigured, clearConfig } = useAppState();
  const navigate = useNavigate();
  const { requestFullscreen } = useFullscreen();
  const [timeStr, setTimeStr] = useState(config.endTime || '');

  const handleSave = (e: React.FormEvent) => {
    e.preventDefault();
    if (!timeStr) return;
    const [hours, minutes] = timeStr.split(':').map(Number);
    const end = new Date(); end.setHours(hours, minutes, 0, 0);
    setConfig({ endTime: timeStr, endTimestamp: end.getTime() });
  };
  const handleResume = async () => { await requestFullscreen(document.documentElement); navigate('/presentation'); };

  return (
    <div className={styles.container}>
      <LogoPlaceholder className={styles.logo} />
      <Card className={styles.card}>
        {isConfigured ? (
          <Stack gap={6}><Stack gap={2}><h2>Sessione in corso</h2></Stack><Stack gap={4}><Button size="lg" onClick={handleResume}>Riprendi Talk</Button><Button variant="danger" onClick={clearConfig}>Ricomincia</Button></Stack></Stack>
        ) : (
          <form onSubmit={handleSave}><Stack gap={6}><Stack gap={2}><h2>Configurazione</h2></Stack><Cluster gap={4}><TimeInput value={timeStr} onChange={(e) => setTimeStr(e.target.value)} required /><Button type="submit" variant="secondary" disabled={!timeStr}>Salva</Button></Cluster></Stack></form>
        )}
      </Card>
    </div>
  );
};
FEAT
