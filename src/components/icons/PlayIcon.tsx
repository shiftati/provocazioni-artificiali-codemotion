import React from 'react'; import type { IconProps } from './IconProps';
export const PlayIcon: React.FC<IconProps> = ({ size = '1em', title, ...props }) => (<svg width={size} height={size} viewBox="0 0 24 24" fill="currentColor" aria-hidden={!title} {...props}>{title && <title>{title}</title>}<path d="M8 5v14l11-7z" /></svg>);
