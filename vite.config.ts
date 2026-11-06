import { defineConfig } from 'vitest/config';
import react from '@vitejs/plugin-react';
export default defineConfig({plugins:[react()],build:{lib:{entry:'src/index.ts',formats:['es'],fileName:'index'},rollupOptions:{external:['react','react-dom','react/jsx-runtime'],output:{banner:"'use client';"}}},test:{environment:'jsdom',setupFiles:['./tests/setup.ts'],include:['tests/**/*.test.tsx']}});
