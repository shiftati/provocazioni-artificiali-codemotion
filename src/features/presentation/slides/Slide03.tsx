import React from 'react';
import styles from './Slides.module.scss';

export const Slide03: React.FC = () => {
  return (
    <div className={`${styles.slide} ${styles.splitSlide}`}>
      <div className={styles.leftPane}>
        <h2>Aspettative</h2>
        <p>Codice pulito, test copertura al 100%, deploy venerdì alle 17:00 senza paura.</p>
      </div>
      <div className={styles.rightPane}>
        <h2>Realtà</h2>
        <p>Un file "utils.ts" di 4000 righe e un commento "// TODO: refactor this hack later".</p>
      </div>
    </div>
  );
};
