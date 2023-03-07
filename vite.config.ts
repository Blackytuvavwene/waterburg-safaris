import { sveltekit } from '@sveltejs/kit/vite';
import { defineConfig } from 'vitest/config';
import tailwindcss from 'tailwindcss';

export default defineConfig({
	plugins: [sveltekit()],
	test: {
		include: ['src/**/*.{test,spec}.{js,ts}']
	},
	server:{
		port: 3001,
	},
	css:{
		postcss:{
			plugins: [tailwindcss]
		}
	}
});
