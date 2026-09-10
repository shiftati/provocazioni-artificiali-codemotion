import { useState, useEffect } from 'react';
import { getItem, setItem } from '../state/storage';

export function usePersistentState<T>(key: string, defaultValue: T) {
  const [state, setState] = useState<T>(() => getItem(key, defaultValue));
  useEffect(() => { setItem(key, state); }, [key, state]);
  return [state, setState] as const;
}
