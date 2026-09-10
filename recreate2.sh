#!/bin/bash
# UI Components
cat << 'COMP' > src/components/ui/Button.module.scss
@use "../../styles/mixins" as *;
.button {
  display: inline-flex; align-items: center; justify-content: center; gap: var(--space-2);
  border: none; border-radius: var(--radius-lg); font-family: var(--font-display); font-weight: 700;
  cursor: pointer; transition: all var(--duration-fast) var(--ease); text-decoration: none;
  &:focus-visible { @include focus-ring; }
  &:disabled { opacity: 0.5; cursor: not-allowed; pointer-events: none; }
}
.primary { background-color: var(--color-accent); color: var(--color-accent-contrast); &:hover:not(:disabled) { background-color: var(--color-accent-hover); } }
.secondary { background-color: var(--color-surface); color: var(--color-text); border: 1px solid var(--color-border); &:hover:not(:disabled) { background-color: var(--color-surface-raised); } }
.ghost { background-color: transparent; color: var(--color-text); &:hover:not(:disabled) { background-color: var(--color-surface); } }
.danger { background-color: var(--color-danger); color: var(--color-text); &:hover:not(:disabled) { background-color: color-mix(in srgb, var(--color-danger) 80%, black); } }
.md { padding: var(--space-3) var(--space-6); font-size: 1rem; }
.lg { padding: var(--space-4) var(--space-8); font-size: 1.25rem; border-radius: calc(var(--radius-lg) * 1.5); }
.xl { padding: var(--space-6) var(--space-12); font-size: 1.5rem; border-radius: calc(var(--radius-lg) * 2); }
COMP

cat << 'COMP' > src/components/ui/Button.tsx
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
COMP

cat << 'COMP' > src/components/ui/IconButton.module.scss
@use "../../styles/mixins" as *;
.iconButton {
  display: inline-flex; align-items: center; justify-content: center; border: none; background: transparent;
  color: var(--color-text); border-radius: var(--radius-pill); cursor: pointer;
  transition: background-color var(--duration-fast) var(--ease), color var(--duration-fast) var(--ease); padding: var(--space-2);
  &:hover:not(:disabled) { background-color: var(--color-surface); }
  &:focus-visible { @include focus-ring; }
  &:disabled { opacity: 0.5; cursor: not-allowed; }
}
.md { font-size: 1.5rem; width: 2.5rem; height: 2.5rem; }
.lg { font-size: 2rem; width: 3.5rem; height: 3.5rem; }
COMP

cat << 'COMP' > src/components/ui/IconButton.tsx
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
COMP

cat << 'COMP' > src/components/ui/Badge.module.scss
.badge {
  display: inline-flex; align-items: center; padding: var(--space-1) var(--space-3); border-radius: var(--radius-pill);
  font-family: var(--font-display); font-size: 0.875rem; font-weight: 700; text-transform: uppercase; letter-spacing: 0.05em;
}
.default { background-color: var(--color-surface); color: var(--color-text-muted); }
.success { background-color: color-mix(in srgb, var(--color-success) 20%, transparent); color: var(--color-success); border: 1px solid color-mix(in srgb, var(--color-success) 40%, transparent); }
COMP

cat << 'COMP' > src/components/ui/Badge.tsx
import React from 'react';
import styles from './Badge.module.scss';
export interface BadgeProps extends React.HTMLAttributes<HTMLSpanElement> { variant?: 'default' | 'success'; }
export const Badge: React.FC<BadgeProps> = ({ children, variant = 'default', className = '', ...props }) => (
  <span className={[styles.badge, styles[variant], className].filter(Boolean).join(' ')} {...props}>{children}</span>
);
COMP

cat << 'COMP' > src/components/ui/Toggle.module.scss
@use "../../styles/mixins" as *;
.segmentedControl { display: inline-flex; background-color: var(--color-surface); border-radius: var(--radius-pill); padding: 4px; gap: 4px; }
.option {
  border: none; background: transparent; color: var(--color-text-muted); padding: var(--space-2) var(--space-6);
  border-radius: var(--radius-pill); font-family: var(--font-display); font-weight: 700; cursor: pointer; transition: all var(--duration-fast) var(--ease);
  &:hover:not(.active) { color: var(--color-text); }
  &.active { background-color: var(--color-surface-raised); color: var(--color-text); box-shadow: 0 2px 4px rgba(0,0,0,0.2); }
  &:focus-visible { @include focus-ring; }
}
COMP

cat << 'COMP' > src/components/ui/Toggle.tsx
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
COMP

cat << 'COMP' > src/components/ui/TimeInput.module.scss
@use "../../styles/mixins" as *;
.timeInput {
  display: inline-flex; align-items: center;
  input[type="time"] {
    background-color: var(--color-surface); color: var(--color-text); border: 1px solid var(--color-border);
    border-radius: var(--radius-md); padding: var(--space-3) var(--space-4); font-family: var(--font-mono); font-size: 1.5rem; color-scheme: dark;
    &:focus-visible { @include focus-ring; }
  }
}
COMP

cat << 'COMP' > src/components/ui/TimeInput.tsx
import React from 'react';
import styles from './TimeInput.module.scss';
export const TimeInput = React.forwardRef<HTMLInputElement, Omit<React.InputHTMLAttributes<HTMLInputElement>, 'type'>>(
  ({ className = '', ...props }, ref) => (
    <div className={`${styles.timeInput} ${className}`}><input type="time" ref={ref} {...props} /></div>
  )
);
TimeInput.displayName = 'TimeInput';
COMP

cat << 'COMP' > src/components/ui/Card.module.scss
.card { background-color: var(--color-surface); border-radius: var(--radius-lg); padding: var(--space-8); border: 1px solid var(--color-border); }
COMP

cat << 'COMP' > src/components/ui/Card.tsx
import React from 'react';
import styles from './Card.module.scss';
export const Card: React.FC<React.HTMLAttributes<HTMLDivElement>> = ({ children, className = '', ...props }) => (
  <div className={`${styles.card} ${className}`} {...props}>{children}</div>
);
COMP

cat << 'COMP' > src/components/ui/CountdownDisplay.module.scss
.countdown { font-family: var(--font-mono); font-variant-numeric: tabular-nums; font-weight: 700; line-height: 1; transition: color var(--duration-base) var(--ease); }
.normal { color: var(--color-text); }
.warning { color: var(--color-warning); }
.danger { color: var(--color-danger); }
COMP

cat << 'COMP' > src/components/ui/CountdownDisplay.tsx
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
COMP

cat << 'COMP' > src/components/ui/Overlay.module.scss
.overlay { position: fixed; inset: 0; z-index: var(--z-overlay); background-color: color-mix(in srgb, var(--color-bg) 95%, transparent); backdrop-filter: blur(8px); display: flex; flex-direction: column; align-items: center; justify-content: center; padding: var(--space-8); }
COMP

cat << 'COMP' > src/components/ui/Overlay.tsx
import React, { useEffect } from 'react';
import { createPortal } from 'react-dom';
import styles from './Overlay.module.scss';
export const Overlay: React.FC<{ isOpen: boolean, children: React.ReactNode }> = ({ isOpen, children }) => {
  useEffect(() => { document.body.style.overflow = isOpen ? 'hidden' : ''; return () => { document.body.style.overflow = ''; }; }, [isOpen]);
  if (!isOpen) return null;
  return createPortal(<div className={styles.overlay} role="dialog" aria-modal="true">{children}</div>, document.body);
};
COMP

cat << 'COMP' > src/components/ui/Layouts.module.scss
.stack { display: flex; flex-direction: column; }
.cluster { display: flex; flex-direction: row; flex-wrap: wrap; align-items: center; }
.alignStart { align-items: flex-start; } .alignCenter { align-items: center; } .alignEnd { align-items: flex-end; } .alignStretch { align-items: stretch; }
.justifyStart { justify-content: flex-start; } .justifyCenter { justify-content: center; } .justifyEnd { justify-content: flex-end; } .justifyBetween { justify-content: space-between; }
.gap1 { gap: var(--space-1); } .gap2 { gap: var(--space-2); } .gap3 { gap: var(--space-3); } .gap4 { gap: var(--space-4); } .gap6 { gap: var(--space-6); } .gap8 { gap: var(--space-8); } .gap12 { gap: var(--space-12); } .gap16 { gap: var(--space-16); }
COMP

cat << 'COMP' > src/components/ui/Stack.tsx
import React from 'react';
import styles from './Layouts.module.scss';
export const Stack: React.FC<{ gap?: number, align?: string, justify?: string, className?: string } & React.HTMLAttributes<HTMLDivElement>> = ({ children, gap = 4, align, justify, className = '', ...props }) => {
  const classes = [styles.stack, styles[`gap${gap}`], align ? styles[`align${align.charAt(0).toUpperCase() + align.slice(1)}`] : '', justify ? styles[`justify${justify.charAt(0).toUpperCase() + justify.slice(1)}`] : '', className].filter(Boolean).join(' ');
  return <div className={classes} {...props}>{children}</div>;
};
COMP

cat << 'COMP' > src/components/ui/Cluster.tsx
import React from 'react';
import styles from './Layouts.module.scss';
export const Cluster: React.FC<{ gap?: number, align?: string, justify?: string, className?: string } & React.HTMLAttributes<HTMLDivElement>> = ({ children, gap = 4, align, justify, className = '', ...props }) => {
  const classes = [styles.cluster, styles[`gap${gap}`], align ? styles[`align${align.charAt(0).toUpperCase() + align.slice(1)}`] : '', justify ? styles[`justify${justify.charAt(0).toUpperCase() + justify.slice(1)}`] : '', className].filter(Boolean).join(' ');
  return <div className={classes} {...props}>{children}</div>;
};
COMP
