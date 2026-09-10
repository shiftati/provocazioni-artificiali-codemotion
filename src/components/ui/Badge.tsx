import React from 'react';
import styles from './Badge.module.scss';
export interface BadgeProps extends React.HTMLAttributes<HTMLSpanElement> { variant?: 'default' | 'success'; }
export const Badge: React.FC<BadgeProps> = ({ children, variant = 'default', className = '', ...props }) => (
  <span className={[styles.badge, styles[variant], className].filter(Boolean).join(' ')} {...props}>{children}</span>
);
