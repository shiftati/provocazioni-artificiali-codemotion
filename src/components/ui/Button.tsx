import React from 'react';
import styles from './Button.module.scss';
export interface ButtonProps extends React.ButtonHTMLAttributes<HTMLButtonElement> {
  variant?: 'primary' | 'secondary' | 'ghost' | 'danger';
  size?: 'md' | 'lg' | 'xl';
  loading?: boolean;
}
export const Button = React.forwardRef<HTMLButtonElement, ButtonProps>(
  ({ children, variant = 'primary', size = 'md', loading, disabled, className = '', ...props }, ref) => {
    return (
      <button ref={ref} className={[styles.button, styles[variant], styles[size], className].filter(Boolean).join(' ')} disabled={disabled || loading} {...props}>
        {loading ? '...' : children}
      </button>
    );
  }
);
Button.displayName = 'Button';
