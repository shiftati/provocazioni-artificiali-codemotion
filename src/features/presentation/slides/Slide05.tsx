import React from 'react';
import styles from './Slides.module.scss';

export const Slide05: React.FC = () => {
  return (
    <div className={`${styles.slide} ${styles.titleSlide}`}>
      <h1>Grazie e alla prossima!</h1>
      <p className={styles.subtitle}>Ricordate di chiudere le issue e idratarvi.</p>
    </div>
  );
};
