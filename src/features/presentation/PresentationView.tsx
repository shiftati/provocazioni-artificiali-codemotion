import React, { useEffect } from 'react';
import { useAppState } from '../../state/AppStateContext';
import { useKeyboardNavigation } from '../../hooks/useKeyboardNavigation';
import { useWakeLock } from '../../hooks/useWakeLock';
import { Stage } from '../../components/layout/Stage';
import { IconButton } from '../../components/ui/IconButton';
import { ArrowLeftIcon, ArrowRightIcon } from '../../components/icons';
import { SLIDES } from './slides/slides.registry';
import styles from './PresentationView.module.scss';

export const PresentationView: React.FC = () => {
  const { session, updateSession } = useAppState();
  useWakeLock(true);
  const currentIndex = Math.min(Math.max(0, session.currentSlideIndex), SLIDES.length - 1);
  const CurrentSlide = SLIDES[currentIndex]?.component;
  const nextSlide = () => { if (currentIndex < SLIDES.length - 1) updateSession({ currentSlideIndex: currentIndex + 1 }); };
  const prevSlide = () => { if (currentIndex > 0) updateSession({ currentSlideIndex: currentIndex - 1 }); };
  useKeyboardNavigation([ { key: ['ArrowRight', 'PageDown', ' '], handler: nextSlide }, { key: ['ArrowLeft', 'PageUp'], handler: prevSlide } ]);
  useEffect(() => { if (session.mode !== 'presentation') updateSession({ mode: 'presentation' }); }, []);
  if (!CurrentSlide) return <div>No slides</div>;
  return (
    <div className={styles.presentation}>
      <Stage><CurrentSlide /></Stage>
      <div className={styles.controls}>
        <IconButton className={styles.controlButton} onClick={prevSlide} disabled={currentIndex === 0} aria-label="Prev"><ArrowLeftIcon /></IconButton>
        <div className={styles.indicator}>{currentIndex + 1} / {SLIDES.length}</div>
        <IconButton className={styles.controlButton} onClick={nextSlide} disabled={currentIndex === SLIDES.length - 1} aria-label="Next"><ArrowRightIcon /></IconButton>
      </div>
    </div>
  );
};
