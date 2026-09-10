import React from 'react';
import styles from './Slides.module.scss';

export const Slide01: React.FC = () => {
  return (
    <div className={`${styles.slide} ${styles.titleSlide}`}>
      <h1>Il codice legacy è come una cipolla</h1>
      <p className={styles.subtitle}>Oltre a farti piangere, ha molti strati.</p>
    </div>
  );
};
