import React from 'react'; import type { IconProps } from './IconProps';
export const PauseIcon: React.FC<IconProps> = ({ size = '1em', title, ...props }) => (<svg width={size} height={size} viewBox="0 0 24 24" fill="currentColor" aria-hidden={!title} {...props}>{title && <title>{title}</title>}<path d="M6 19h4V5H6v14zm8-14v14h4V5h-4z" /></svg>);
