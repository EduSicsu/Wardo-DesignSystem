'use client';
import { createContext,useContext,type HTMLAttributes } from 'react';
export type WardoTheme = 'wardo-light'|'wardo-dark'|'ocean-light'|'ocean-dark'|'orchid-light'|'orchid-dark'|'ember-light'|'ember-dark'|'cloud-light'|'cloud-dark';
const Theme=createContext<WardoTheme>('wardo-light');
export const useWardoTheme=()=>useContext(Theme);
export function WardoProvider({theme='wardo-light',children,...props}:HTMLAttributes<HTMLDivElement>&{theme?:WardoTheme}){return <Theme.Provider value={theme}><div {...props} data-wardo-theme={theme}>{children}</div></Theme.Provider>;}
