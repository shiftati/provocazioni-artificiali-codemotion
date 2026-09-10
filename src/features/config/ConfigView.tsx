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
