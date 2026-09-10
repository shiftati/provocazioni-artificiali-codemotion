import React from 'react'; import type { IconProps } from './IconProps';
export const ArrowLeftIcon: React.FC<IconProps> = ({ size = '1em', title, ...props }) => (<svg width={size} height={size} viewBox="0 0 24 24" fill="currentColor" aria-hidden={!title} {...props}>{title && <title>{title}</title>}<path d="M15.41 16.59L10.83 12l4.58-4.59L14 6l-6 6 6 6 1.41-1.41z" /></svg>);
