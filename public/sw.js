const CACHE_NAME = 'codemotion-app-v1';
const BASE_PATH = '/provocazioni-artificiali-codemotion/';

const ASSETS = [
  BASE_PATH,
  `${BASE_PATH}index.html`,
  `${BASE_PATH}manifest.webmanifest`,
  `${BASE_PATH}fonts/IBMPlexMono-700.woff2`,
  `${BASE_PATH}fonts/IBMPlexSans-400.woff2`,
  `${BASE_PATH}fonts/IBMPlexSans-700.woff2`,
  `${BASE_PATH}fonts/Roboto-400.woff2`,
  `${BASE_PATH}fonts/Roboto-700.woff2`,
  `${BASE_PATH}fonts/fonts.css`,
  `${BASE_PATH}icons/icon-192.png`,
  `${BASE_PATH}icons/icon-512.png`,
  `${BASE_PATH}icons/maskable.png`
];

self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then((cache) => cache.addAll(ASSETS))
      .then(() => self.skipWaiting())
  );
});

self.addEventListener('activate', (event) => {
  event.waitUntil(
    caches.keys().then((cacheNames) => {
      return Promise.all(
        cacheNames.map((cacheName) => {
          if (cacheName !== CACHE_NAME) {
            return caches.delete(cacheName);
          }
        })
      );
    }).then(() => self.clients.claim())
  );
});

self.addEventListener('fetch', (event) => {
  const url = new URL(event.request.url);

  // Network-first for HTML
  if (event.request.mode === 'navigate' || (event.request.method === 'GET' && event.request.headers.get('accept').includes('text/html'))) {
    event.respondWith(
      fetch(event.request)
        .catch(() => caches.match(`${BASE_PATH}index.html`))
    );
    return;
  }

  // Cache-first for assets
  event.respondWith(
    caches.match(event.request)
      .then((response) => response || fetch(event.request))
  );
});
