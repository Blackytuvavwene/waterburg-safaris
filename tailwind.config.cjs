/** @type {import('tailwindcss').Config} */
module.exports = {
	content: ['./src/**/*{.html,.js,.svelte,.ts}',
		'./node_modules/flowbite-svelte/**/*.{html,js,svelte,ts}',
		'./node_modules/tw-elements/dist/js/**/*.js'
	],

	theme: {
		extend: {
			fontFamily: {
				sans: ['Dosis', 'sans-serif']
			},
			colors: {
				primary: {
					DEFAULT: 'var(--primary)',
					50: '#fcfcff',
					100: '#e7f2ff',
					200: '#cce5ff',
					300: '#92ccff',
					400: '#46b3fe',
					500: '#1698e1',
					600: '#007dbd',
					700: '#004b73',
					800: '#003351',
					900: '#001d31'
				},
				secondary: {
					DEFAULT: 'var(--secondary)',
					50: '#f4fff5',
					100: '#bfffda',
					200: '#8df7c1',
					300: '#71dba6',
					400: '#54be8c',
					500: '#35a373',
					600: '#05885b',
					700: '#005235',
					800: '#003823',
					900: '#002113'
				},
				tertiary: {
					DEFAULT: 'var(--tertiary)',
					50: '#f9fdff',
					100: '#dcf5ff',
					200: '#b3ebff',
					300: '#5ad5f9',
					400: '#34b9dc',
					500: '#009ebe',
					600: '#00829d',
					700: '#004e5f',
					800: '#003642',
					900: '#001f27'
				},
				success: {
					DEFAULT: 'var(--success)',
					50: '#f5fff5',
					100: '#c0ffd6',
					150: '#6bfdb2',
					200: '#4adf98',
					300: '#1dc37e',
					400: '#00a669',
					500: '#008956',
					600: '#006d43',
					700: '#005231',
					800: '#003921',
					900: '#002111'
				},
				error: 'var(--error)',
				background: 'var(--background)',
				surface: {
					DEFAULT: 'var(--surface)',
					1: '#eff4fa',
					2: '#e8f0f7',
					3: '#e0ebf4',
					4: '#dde9f2',
					5: '#d8e6f0'
				},
				surfaceVariant: 'var(--surface-variant)',
				onPrimary: 'var(--on-primary)',
				onSecondary: 'var(--on-secondary)',
				onTertiary: 'var(--on-tertiary)',
				onSuccess: 'var(--on-success)',
				onError: 'var(--on-error)',
				onBackground: 'var(--on-background)',
				onSurface: 'var(--on-surface)',
				onSurfaceVariant: 'var(--on-surface-variant)',
				primaryContainer: 'var(--primary-container)',
				secondaryContainer: 'var(--secondary-container)',
				tertiaryContainer: 'var(--tertiary-container)',
				successContainer: 'var(--success-container)',
				errorContainer: 'var(--error-container)',
				onPrimaryContainer: 'var(--on-primary-container)',
				onSecondaryContainer: 'var(--on-secondary-container)',
				onTertiaryContainer: 'var(--on-tertiary-container)',
				onSuccessContainer: 'var(--on-success-container)',
				onErrorContainer: 'var(--on-error-container)',
				outline: 'var(--outline)'
			},
			screens: {
				xxs: '320px',
				xs: '360px',
				s: '390px'
			},
			animation: {
				slideFromLeft: 'slideFromLeft 1.5s ease-in-out'
			},
			keyframes: {
				slideFromLeft: {
					'0%': {
						translate: 'translateX(-20vw)'
					},
					'100%': 'translateX(0)'
				}
			}
		}
	},
	plugins: [require('flowbite/plugin'), require('tw-elements/dist/plugin')],
	darkMode: 'class'
};
