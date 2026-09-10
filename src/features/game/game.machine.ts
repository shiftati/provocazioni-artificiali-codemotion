import { APP_CONFIG } from '../../config/app.config';
export type GameStep = 'IDLE' | 'CHALLENGE' | 'PROVOCATION' | 'DISCUSSION';
export interface GameState { step: GameStep; timerDeadline: number | null; currentProvocationId: string | null; usedProvocationIds: string[]; skippedProvocationIds: string[]; discussedCount: number; isFirstLoop: boolean; }
export type GameAction = { type: 'PLAY' } | { type: 'ACCEPT_CHALLENGE' } | { type: 'CHALLENGE_TIMEOUT' } | { type: 'ACCEPT_PROVOCATION' } | { type: 'CHANGE_PROVOCATION'; nextProvocationId: string | null } | { type: 'NEXT_PROVOCATION' } | { type: 'PAUSE_DISCUSSION' } | { type: 'RESUME_DISCUSSION' } | { type: 'HYDRATE'; state: GameState };
export const INITIAL_GAME_STATE: GameState = { step: 'IDLE', timerDeadline: null, currentProvocationId: null, usedProvocationIds: [], skippedProvocationIds: [], discussedCount: 0, isFirstLoop: true };
export function gameReducer(state: GameState, action: GameAction): GameState {
  const now = Date.now();
  switch (action.type) {
    case 'HYDRATE': return action.state;
    case 'PLAY': return state.isFirstLoop ? { ...state, step: 'PROVOCATION', timerDeadline: null } : { ...state, step: 'CHALLENGE', timerDeadline: now + APP_CONFIG.GAME_CHALLENGE_SECONDS * 1000 };
    case 'ACCEPT_CHALLENGE': return { ...state, step: 'DISCUSSION', timerDeadline: now + APP_CONFIG.GAME_DISCUSSION_SECONDS * 1000, discussedCount: state.discussedCount + 1, usedProvocationIds: state.currentProvocationId ? [...state.usedProvocationIds, state.currentProvocationId] : state.usedProvocationIds };
    case 'CHALLENGE_TIMEOUT': return { ...state, step: 'PROVOCATION', timerDeadline: null };
    case 'ACCEPT_PROVOCATION': return { ...state, step: 'DISCUSSION', timerDeadline: now + APP_CONFIG.GAME_DISCUSSION_SECONDS * 1000, discussedCount: state.discussedCount + 1, usedProvocationIds: state.currentProvocationId ? [...state.usedProvocationIds, state.currentProvocationId] : state.usedProvocationIds };
    case 'CHANGE_PROVOCATION': return { ...state, skippedProvocationIds: state.currentProvocationId ? [...state.skippedProvocationIds, state.currentProvocationId] : state.skippedProvocationIds, currentProvocationId: action.nextProvocationId };
    case 'NEXT_PROVOCATION': return { ...state, step: 'IDLE', timerDeadline: null, isFirstLoop: false };
    case 'PAUSE_DISCUSSION': return { ...state, timerDeadline: state.timerDeadline ? -(state.timerDeadline - now) : null };
    case 'RESUME_DISCUSSION': return { ...state, timerDeadline: state.timerDeadline ? now + (-state.timerDeadline) : null };
    default: return state;
  }
}
