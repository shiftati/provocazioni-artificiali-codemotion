import { useEffect } from 'react';
export function useKeyboardNavigation(handlers: {key: string | string[], handler: (e: KeyboardEvent)=>void}[], isActive = true) {
  useEffect(() => {
    if (!isActive) return;
    const handle = (e: KeyboardEvent) => {
      if (['INPUT','TEXTAREA','SELECT'].includes((e.target as HTMLElement).tagName)) return;
      for (const h of handlers) {
        const keys = Array.isArray(h.key) ? h.key : [h.key];
        if (keys.includes(e.key)) { e.preventDefault(); h.handler(e); return; }
      }
    };
    window.addEventListener('keydown', handle); return () => window.removeEventListener('keydown', handle);
  }, [handlers, isActive]);
}
