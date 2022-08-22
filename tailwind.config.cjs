/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ['./src/**/*.{html,js,svelte,ts}'],
  theme: {
    extend: {
      fontFamily:{
        sans: ['Dosis', 'sans-serif'],
      },
      colors:{
        "primary":"var(--primary)",
        "secondary":"var(--secondary)",
        "tertiary":"var(--tertiary)",
        "success":"var(--success)",
        "error":"var(--error)",
        "background":"var(--background)",
        "surface":"var(--surface)",
        "surfaceVariant":"var(--surface-variant)",
        "onPrimary":"var(--on-primary)",
        "onSecondary":"var(--on-secondary)",
        "onTertiary":"var(--on-tertiary)",
        "onSuccess":"var(--on-success)",
        "onError":"var(--on-error)",
        "onBackground":"var(--on-background)",
        "onSurface":"var(--on-surface)",
        "onSurfaceVariant":"var(--on-surface-variant)",
        "primaryContainer":"var(--primary-container)",
        "secondaryContainer":"var(--secondary-container)",
        "tertiaryContainer":"var(--tertiary-container)",
        "successContainer":"var(--success-container)",
        "errorContainer":"var(--error-container)",
        "onPrimaryContainer":"var(--on-primary-container)",
        "onSecondaryContainer":"var(--on-secondary-container)",
        "onTertiaryContainer":"var(--on-tertiary-container)",
        "onSuccessContainer":"var(--on-success-container)",
        "onErrorContainer":"var(--on-error-container)",
        "outline":"var(--outline)",
      }
    },
  },
  plugins: [],
};
