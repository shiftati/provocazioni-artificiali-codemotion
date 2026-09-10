import React from 'react'; import type { IconProps } from './IconProps';
export const ArrowRightIcon: React.FC<IconProps> = ({ size = '1em', title, ...props }) => (<svg width={size} height={size} viewBox="0 0 24 24" fill="currentColor" aria-hidden={!title} {...props}>{title && <title>{title}</title>}<path d="M8.59 16.59L13.17 12 8.59 7.41 10 6l6 6-6 6-1.41-1.41z" /></svg>);
