import React from 'react';
import styles from './CountdownDisplay.module.scss';
export const CountdownDisplay: React.FC<{ seconds: number, warningThreshold?: number, dangerThreshold?: number } & React.HTMLAttributes<HTMLSpanElement>> = ({ seconds, warningThreshold = 300, dangerThreshold = 60, className = '', ...props }) => {
  const m = Math.floor(Math.max(0, seconds) / 60).toString().padStart(2, '0');
  const s = (Math.max(0, seconds) % 60).toString().padStart(2, '0');
  let statusClass = styles.normal;
  if (seconds <= dangerThreshold) statusClass = styles.danger;
  else if (seconds <= warningThreshold) statusClass = styles.warning;
  return <span className={`${styles.countdown} ${statusClass} ${className}`} aria-live="polite" {...props}>{m}:{s}</span>;
};
