cat << 'APP' > src/features/game/provocations/provocations.registry.ts
import { Provocation01 } from './Provocation01';
export const PROVOCATIONS = [
  { id: '1', title: 'P1', component: Provocation01 }
];
APP
