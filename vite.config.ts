import { defineConfig } from 'vitest/config';
import react from '@vitejs/plugin-react';
export default defineConfig({plugins:[react()],build:{lib:{entry:{index:'src/index.ts',examples:'src/examples/index.ts'},formats:['es'],fileName:(_,entry)=>`${entry}.js`},rollupOptions:{external:['react','react-dom','react/jsx-runtime','react-aria-components'],output:{banner:"'use client';"}}},test:{environment:'jsdom',setupFiles:['./tests/setup.ts'],include:['tests/**/*.test.{ts,tsx}']}});
