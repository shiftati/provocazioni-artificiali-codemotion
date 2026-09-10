import React from 'react';
export const LogoPlaceholder: React.FC<{className?: string}> = ({ className }) => (
  <svg className={className} viewBox="0 0 200 40" fill="none"><text x="10" y="25" fill="var(--color-text)" fontFamily="var(--font-display)" fontSize="20" fontWeight="bold">SHIFTATI DI TESTA</text></svg>
);
