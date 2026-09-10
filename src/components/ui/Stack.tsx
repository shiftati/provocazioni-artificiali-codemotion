import React from 'react';
import styles from './Layouts.module.scss';
export const Stack: React.FC<{ gap?: number, align?: string, justify?: string, className?: string } & React.HTMLAttributes<HTMLDivElement>> = ({ children, gap = 4, align, justify, className = '', ...props }) => {
  const classes = [styles.stack, styles[`gap${gap}`], align ? styles[`align${align.charAt(0).toUpperCase() + align.slice(1)}`] : '', justify ? styles[`justify${justify.charAt(0).toUpperCase() + justify.slice(1)}`] : '', className].filter(Boolean).join(' ');
  return <div className={classes} {...props}>{children}</div>;
};
