import React, { useEffect } from 'react';
import { createPortal } from 'react-dom';
import styles from './Overlay.module.scss';
export const Overlay: React.FC<{ isOpen: boolean, children: React.ReactNode }> = ({ isOpen, children }) => {
  useEffect(() => { document.body.style.overflow = isOpen ? 'hidden' : ''; return () => { document.body.style.overflow = ''; }; }, [isOpen]);
  if (!isOpen) return null;
  return createPortal(<div className={styles.overlay} role="dialog" aria-modal="true">{children}</div>, document.body);
};
