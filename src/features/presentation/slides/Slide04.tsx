import React from 'react';
import styles from './Slides.module.scss';

export const Slide04: React.FC = () => {
  return (
    <div className={`${styles.slide} ${styles.fullBleedSlide}`}>
      <div className={styles.centerBox}>
        <h2>Il Test Driven Development</h2>
        <p>Una bellissima fiaba che raccontiamo ai junior.</p>
      </div>
    </div>
  );
};
