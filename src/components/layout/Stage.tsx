import React, { useRef } from 'react';
import { useStageScale } from '../../hooks/useStageScale';
import { APP_CONFIG } from '../../config/app.config';
import styles from './Stage.module.scss';
export const Stage: React.FC<{children: React.ReactNode}> = ({ children }) => {
  const containerRef = useRef<HTMLDivElement>(null);
  const scale = useStageScale(containerRef);
  return (
    <div className={styles.stageContainer} ref={containerRef}>
      <div className={styles.stage} style={{ width: APP_CONFIG.STAGE_WIDTH, height: APP_CONFIG.STAGE_HEIGHT, transform: `scale(${scale})` }}>
        {children}
      </div>
    </div>
  );
};
