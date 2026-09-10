import React, { Component, ErrorInfo, ReactNode } from 'react';
import { Button } from '../ui/Button';

interface Props {
  children: ReactNode;
}

interface State {
  hasError: boolean;
  error?: Error;
}

export class ErrorBoundary extends Component<Props, State> {
  public state: State = {
    hasError: false
  };

  public static getDerivedStateFromError(error: Error): State {
    return { hasError: true, error };
  }

  public componentDidCatch(error: Error, errorInfo: ErrorInfo) {
    // We suppress the actual console.error per requirements ("no console.log in final code")
    // but in a real app we'd log this to an error tracking service.
  }

  public render() {
    if (this.state.hasError) {
      return (
        <div style={{
          display: 'flex',
          flexDirection: 'column',
          alignItems: 'center',
          justifyContent: 'center',
          height: '100vh',
          backgroundColor: 'var(--color-bg)',
          color: 'var(--color-text)',
          padding: '2rem',
          textAlign: 'center'
        }}>
          <h1 style={{ fontFamily: 'var(--font-display)', fontSize: '2rem', marginBottom: '1rem', color: 'var(--color-danger)' }}>
            Qualcosa è andato storto
          </h1>
          <p style={{ marginBottom: '2rem', color: 'var(--color-text-muted)' }}>
            L'applicazione ha riscontrato un errore inaspettato.
          </p>
          <Button onClick={() => window.location.reload()}>Ricarica</Button>
        </div>
      );
    }

    return this.props.children;
  }
}
