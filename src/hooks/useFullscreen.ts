import { useCallback } from 'react';
export function useFullscreen() {
  const requestFullscreen = useCallback(async (el: HTMLElement) => { try { if (!document.fullscreenElement) await el.requestFullscreen(); } catch (e) {} }, []);
  return { requestFullscreen };
}
