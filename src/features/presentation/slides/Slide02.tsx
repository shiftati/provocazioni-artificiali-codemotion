import React from 'react';
import styles from './Slides.module.scss';

export const Slide02: React.FC = () => {
  return (
    <div className={`${styles.slide} ${styles.titleContentSlide}`}>
      <h2>Perché facciamo refactoring?</h2>
      <ul className={styles.contentList}>
        <li>Per capire come funziona il sistema.</li>
        <li>Perché non riusciamo ad aggiungere una nuova feature.</li>
        <li>Perché il debito tecnico ha gli interessi troppo alti.</li>
        <li>Per mascherare la nostra noia in ufficio.</li>
      </ul>
    </div>
  );
};
