import React from 'react';
import styles from './IconButton.module.scss';
export interface IconButtonProps extends React.ButtonHTMLAttributes<HTMLButtonElement> {
  size?: 'md' | 'lg';
  'aria-label': string;
}
export const IconButton = React.forwardRef<HTMLButtonElement, IconButtonProps>(
  ({ children, size = 'md', className = '', ...props }, ref) => (
    <button ref={ref} className={[styles.iconButton, styles[size], className].filter(Boolean).join(' ')} {...props}>{children}</button>
  )
);
IconButton.displayName = 'IconButton';
