<script lang="ts">
	import { isLoading } from '$lib/helpers/global.stores';
	import { page,navigating } from '$app/stores';
import type {  AboutCompanyResponse } from '$lib/app-components/about-components/about.types';
import ContactFormFooter from '$lib/app-components/contact-form/ContactFormFooter.svelte';


import Footer from '$lib/app-components/footer/footer.svelte';
import Header from '$lib/app-components/header/Header.svelte';
import '../app.css';
import logo from "$lib/wblogolg.svg";

import type { LayoutServerData } from './$types';
import { onMount } from 'svelte';
import PageLoader from '$lib/animations/PageLoader.svelte';

let isPageLoaded = false;



export let data: LayoutServerData;
// // console.log(data.about);

// $: ({ companyDetails } = data.about as AboutCompanyResponse);


onMount(()=>{
    setTimeout(()=>{
isPageLoaded = true;
},800);
});
</script>


<!-- {#if !isPageLoaded}
<PageLoader/>
{/if} -->


<!-- <Header/> -->
<main >
    <slot />
    <!-- {#if $page.url.pathname!=="/contact"}
   
    <ContactFormFooter/>
    {/if} -->
    
</main>

<!-- <Footer footerData={data.homeData} /> -->




