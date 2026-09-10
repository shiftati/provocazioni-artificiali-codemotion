#!/bin/bash
mkdir -p src/config src/styles src/components/ui src/components/icons src/components/layout src/features/config src/features/presentation/slides src/features/game/provocations src/features/stopCalls src/hooks src/state src/types src/utils public/icons

# Config
cat << 'CONFIG' > src/config/app.config.ts
export const APP_CONFIG = {
  STOP_CALLS_TARGET_SLIDE_INDEX: 3,
  GAME_CHALLENGE_SECONDS: 30,
  GAME_DISCUSSION_SECONDS: 5 * 60,
  STAGE_WIDTH: 1920,
  STAGE_HEIGHT: 1080,
  WARNING_THRESHOLD_SECONDS: 300,
  DANGER_THRESHOLD_SECONDS: 60,
} as const;
CONFIG

cat << 'CONFIG' > vite.config.ts
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],
  base: '/codemotion-app/',
  css: {
    modules: {
      localsConvention: 'camelCase',
    }
  }
})
CONFIG

cat << 'CONFIG' > public/manifest.webmanifest
{
  "name": "Codemotion App",
  "short_name": "Talk",
  "start_url": "./",
  "display": "fullscreen",
  "orientation": "landscape",
  "background_color": "#0E1E30",
  "theme_color": "#FF5C00",
  "icons": [
    {
      "src": "./icons/icon-192.png",
      "sizes": "192x192",
      "type": "image/png"
    },
    {
      "src": "./icons/icon-512.png",
      "sizes": "512x512",
      "type": "image/png"
    },
    {
      "src": "./icons/maskable.png",
      "sizes": "512x512",
      "type": "image/png",
      "purpose": "maskable"
    }
  ]
}
CONFIG
echo "" > public/.nojekyll

echo "iVBORw0KGgoAAAANSUhEUgAAAMAAAADAAQMAAAA/DkGNAAAAA1BMVEX/XAAAAGxJREFUeJztwTEBAAAAwqD1T20ND6AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA8B78AAABqXU4JwAAAABJRU5ErkJggg==" | base64 -d > public/icons/icon-192.png
echo "iVBORw0KGgoAAAANSUhEUgAAAgAAAAIAAQMAAADOtka5AAAAA1BMVEX/XAAAAGxJREFUeJztwTEBAAAAwqD1T20ND6AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA8B78AAABqXU4JwAAAABJRU5ErkJggg==" | base64 -d > public/icons/icon-512.png
cp public/icons/icon-512.png public/icons/maskable.png

# Styles
cat << 'STYLE' > src/styles/_tokens.scss
:root {
  --color-brand-orange: #ff5c00;
  --color-brand-navy: #0e1e30;
  --color-brand-white: #ffffff;
  --color-bg: var(--color-brand-navy);
  --color-surface: #16293f;
  --color-surface-raised: #1f364f;
  --color-text: var(--color-brand-white);
  --color-text-muted: color-mix(in srgb, var(--color-brand-white) 62%, var(--color-brand-navy));
  --color-accent: var(--color-brand-orange);
  --color-accent-hover: color-mix(in srgb, var(--color-brand-orange) 85%, var(--color-brand-white));
  --color-accent-contrast: var(--color-brand-navy);
  --color-success: #27c093;
  --color-warning: var(--color-brand-orange);
  --color-danger: #e5352b;
  --color-border: color-mix(in srgb, var(--color-brand-white) 14%, transparent);
  --font-display: "IBM Plex Sans", system-ui, sans-serif;
  --font-mono: "IBM Plex Mono", ui-monospace, monospace;
  --font-body: "Roboto", system-ui, sans-serif;
  --space-1: 0.25rem; --space-2: 0.5rem; --space-3: 0.75rem;
  --space-4: 1rem; --space-6: 1.5rem; --space-8: 2rem;
  --space-12: 3rem; --space-16: 4rem;
  --radius-sm: 4px; --radius-md: 8px; --radius-lg: 16px; --radius-pill: 999px;
  --duration-fast: 120ms; --duration-base: 240ms;
  --ease: cubic-bezier(0.2, 0, 0, 1);
  --z-stage: 10; --z-chrome: 100; --z-overlay: 1000;
}
STYLE

cat << 'STYLE' > src/styles/_reset.scss
*, *::before, *::after { box-sizing: border-box; }
* { margin: 0; padding: 0; }
body {
  line-height: 1.5;
  -webkit-font-smoothing: antialiased;
  background-color: var(--color-bg);
  color: var(--color-text);
  overflow: hidden;
  font-family: var(--font-body);
}
img, picture, video, canvas, svg { display: block; max-width: 100%; }
input, button, textarea, select { font: inherit; }
p, h1, h2, h3, h4, h5, h6 { overflow-wrap: break-word; }
#root { isolation: isolate; width: 100vw; height: 100vh; }
STYLE

cat << 'STYLE' > src/styles/_typography.scss
h1, h2, h3, h4, h5, h6 { font-family: var(--font-display); font-weight: 700; line-height: 1.2; }
h1 { font-size: clamp(2.5rem, 5vw, 4rem); }
h2 { font-size: clamp(2rem, 4vw, 3rem); }
h3 { font-size: clamp(1.5rem, 3vw, 2.25rem); }
h4 { font-size: clamp(1.25rem, 2.5vw, 1.75rem); }
.text-muted { color: var(--color-text-muted); }
.font-mono { font-family: var(--font-mono); font-variant-numeric: tabular-nums; }
STYLE

cat << 'STYLE' > src/styles/_mixins.scss
@mixin focus-ring { outline: 2px solid var(--color-accent); outline-offset: 2px; }
STYLE

cat << 'STYLE' > src/styles/index.scss
@layer reset, tokens, typography, components;
@import '../../public/fonts/fonts.css';
@layer tokens { @import './tokens'; }
@layer reset { @import './reset'; }
@layer typography { @import './typography'; }
STYLE

# Main entry
cat << 'MAIN' > src/main.tsx
import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import './styles/index.scss'
import App from './App.tsx'
import { registerSW } from './registerSW'

createRoot(document.getElementById('root')!).render(
  <StrictMode>
    <App />
  </StrictMode>,
)
registerSW()
MAIN

cat << 'MAIN' > src/registerSW.ts
export function registerSW() {
  if (import.meta.env.PROD && 'serviceWorker' in navigator) {
    window.addEventListener('load', () => {
      navigator.serviceWorker.register(\`\${import.meta.env.BASE_URL}sw.js\`).catch(() => {});
    });
  }
}
MAIN

cat << 'SW' > public/sw.js
const CACHE_NAME = 'codemotion-app-v1';
self.addEventListener('install', (event) => self.skipWaiting());
self.addEventListener('activate', (event) => {
  event.waitUntil(caches.keys().then((keys) => Promise.all(keys.map(k => k !== CACHE_NAME ? caches.delete(k) : null))));
  self.clients.claim();
});
self.addEventListener('fetch', (event) => {
  if (event.request.method !== 'GET' || !event.request.url.startsWith('http')) return;
  const url = new URL(event.request.url);
  if (url.pathname.includes('/assets/') || url.pathname.includes('/fonts/')) {
    event.respondWith(caches.match(event.request).then((res) => res || fetch(event.request).then((net) => {
      const clone = net.clone();
      caches.open(CACHE_NAME).then((cache) => cache.put(event.request, clone));
      return net;
    })));
    return;
  }
  event.respondWith(fetch(event.request).then((net) => {
    const clone = net.clone();
    caches.open(CACHE_NAME).then((cache) => cache.put(event.request, clone));
    return net;
  }).catch(() => caches.match(event.request).then((res) => {
    if (res) return res;
    if (event.request.mode === 'navigate') return caches.match('./index.html');
    return new Response('Network error', { status: 408 });
  })));
});
SW
