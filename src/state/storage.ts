type StorageKey = 'codemotion-app:config' | 'codemotion-app:session' | 'codemotion-app:game' | 'codemotion-app:stats';
export const getItem = <T>(key: StorageKey, defaultValue: T): T => {
  try { const item = localStorage.getItem(key); return item ? JSON.parse(item).data : defaultValue; }
  catch (e) { return defaultValue; }
};
export const setItem = <T>(key: StorageKey, value: T, version = 1): void => {
  try { localStorage.setItem(key, JSON.stringify({ version, data: value })); } catch (e) {}
};
