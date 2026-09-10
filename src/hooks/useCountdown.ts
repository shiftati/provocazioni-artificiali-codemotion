import { useState, useEffect, useCallback } from 'react';
export function useCountdown(endTimestamp: number | null) {
  const calculate = useCallback(() => endTimestamp ? Math.max(0, Math.floor((endTimestamp - Date.now()) / 1000)) : 0, [endTimestamp]);
  const [timeLeft, setTimeLeft] = useState(calculate);
  useEffect(() => {
    setTimeLeft(calculate());
    if (endTimestamp) { const id = setInterval(() => setTimeLeft(calculate()), 250); return () => clearInterval(id); }
  }, [endTimestamp, calculate]);
  return timeLeft;
}
