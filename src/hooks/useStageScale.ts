import { useState, useEffect } from 'react';
import type { RefObject } from 'react';
import { APP_CONFIG } from '../config/app.config';
export function useStageScale(containerRef: RefObject<HTMLElement | null>) {
  const [scale, setScale] = useState(1);
  useEffect(() => {
    const calc = () => {
      if (!containerRef.current) return;
      const { width, height } = containerRef.current.getBoundingClientRect();
      setScale(Math.min(width / APP_CONFIG.STAGE_WIDTH, height / APP_CONFIG.STAGE_HEIGHT));
    };
    calc();
    const obs = new ResizeObserver(calc);
    if (containerRef.current) obs.observe(containerRef.current);
    return () => obs.disconnect();
  }, [containerRef]);
  return scale;
}
