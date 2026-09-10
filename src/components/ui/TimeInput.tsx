import React from 'react';
import styles from './TimeInput.module.scss';
export const TimeInput = React.forwardRef<HTMLInputElement, Omit<React.InputHTMLAttributes<HTMLInputElement>, 'type'>>(
  ({ className = '', ...props }, ref) => (
    <div className={`${styles.timeInput} ${className}`}><input type="time" ref={ref} {...props} /></div>
  )
);
TimeInput.displayName = 'TimeInput';
