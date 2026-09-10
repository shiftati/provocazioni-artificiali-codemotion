import React from 'react';
import styles from './Toggle.module.scss';
export const Toggle: React.FC<{ options: {label: string, value: string}[], value: string, onChange: (v: string)=>void, className?: string }> = ({ options, value, onChange, className = '' }) => (
  <div className={`${styles.segmentedControl} ${className}`} role="group">
    {options.map((option) => (
      <button key={option.value} type="button" className={`${styles.option} ${value === option.value ? styles.active : ''}`} onClick={() => onChange(option.value)} aria-pressed={value === option.value}>
        {option.label}
      </button>
    ))}
  </div>
);
