import React from 'react';
import styles from './Card.module.scss';
export const Card: React.FC<React.HTMLAttributes<HTMLDivElement>> = ({ children, className = '', ...props }) => (
  <div className={`${styles.card} ${className}`} {...props}>{children}</div>
);
