<script lang="ts">
	import { page,navigating } from '$app/stores';
import type {  AboutCompanyResponse } from '$lib/app-components/about-components/about.types';
import ContactFormFooter from '$lib/app-components/contact-form/ContactFormFooter.svelte';


import Footer from '$lib/app-components/footer/footer.svelte';
import Header from '$lib/app-components/header/Header.svelte';
import '../app.css';

import type { LayoutServerData } from './$types';

// export let data: LayoutServerData;
// // console.log(data.about);

// $: ({ companyDetails } = data.about as AboutCompanyResponse);



</script>

<!-- {#if $navigating}
   <img class="w-[100vw] h-[100vh] absolute z-10 bg-red-500" src="$lib/wblogo.svg" alt="Loading Waterburg Safaris logo">
{/if} -->

<Header/>
<main>
    <slot/>
    {#if $page.url.pathname==="/contact"}
    {:else}
    <ContactFormFooter/>
    {/if}
    
</main>

<Footer />




