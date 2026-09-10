import { HashRouter, Routes, Route, Navigate } from 'react-router-dom';
import { AppStateProvider } from './state/AppStateContext';
import { AppShell } from './components/layout/AppShell';
import { ErrorBoundary } from './components/layout/ErrorBoundary';

import { ConfigView } from './features/config/ConfigView';
import { PresentationView } from './features/presentation/PresentationView';
import { GameView } from './features/game/GameView';
import { StopCallsOverlay } from './features/stopCalls/StopCallsOverlay';

const AppRoutes = () => {
  return (
    <>
      <AppShell>
        <Routes>
          <Route path="/" element={<ConfigView />} />
          <Route path="/presentation" element={<PresentationView />} />
          <Route path="/game" element={<GameView />} />
          <Route path="*" element={<Navigate to="/" replace />} />
        </Routes>
      </AppShell>
      <StopCallsOverlay />
    </>
  );
};

function App() {
  return (
    <ErrorBoundary>
      <AppStateProvider>
        <HashRouter>
          <AppRoutes />
        </HashRouter>
      </AppStateProvider>
    </ErrorBoundary>
  );
}

export default App;
