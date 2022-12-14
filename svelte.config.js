import adapter from '@sveltejs/adapter-auto';
import preprocess from 'svelte-preprocess';

/** @type {import('@sveltejs/kit').Config} */
const config = {
	// Consult https://github.com/sveltejs/svelte-preprocess
	// for more information about preprocessors
	preprocess:[
		preprocess({
			postcss:true,
			
		})
	] ,
	prerender: {
		crawl: true,
		default: true,
		enabled: true,
		entries: ['*'],
		onError: 'continue',
		origin: 'http://sveltekit-prerender'
	  },

	kit: {
		adapter: adapter(),
		
		
	},
	// files:{
	// 	routes:'src/**'
	// }
	
};

export default config;
