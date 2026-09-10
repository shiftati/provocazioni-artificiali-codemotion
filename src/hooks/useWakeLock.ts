import { useEffect, useRef } from 'react';

interface WakeLockSentinel {
  release: () => Promise<void>;
}

interface NavigatorWithWakeLock extends Navigator {
  wakeLock: {
    request: (type: 'screen') => Promise<WakeLockSentinel>;
  };
}

export function useWakeLock(isActive = true) {
  const wakeLockRef = useRef<WakeLockSentinel | null>(null);

  useEffect(() => {
    if (!isActive) {
      if (wakeLockRef.current) {
        wakeLockRef.current.release().catch(() => {});
        wakeLockRef.current = null;
      }
      return;
    }

    const req = async () => {
      try {
        if ('wakeLock' in navigator) {
          wakeLockRef.current = await (navigator as NavigatorWithWakeLock).wakeLock.request('screen');
        }
      } catch (e) {
        // Silently fail
      }
    };
    req();

    const handler = () => {
      if (wakeLockRef.current !== null && document.visibilityState === 'visible') {
        req();
      }
    };

    document.addEventListener('visibilitychange', handler);
    return () => {
      document.removeEventListener('visibilitychange', handler);
      if (wakeLockRef.current) {
        wakeLockRef.current.release().catch(() => {});
        wakeLockRef.current = null;
      }
    };
  }, [isActive]);
}
