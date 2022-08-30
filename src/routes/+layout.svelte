<script lang="ts">
import type {  AboutCompanyResponse } from '$lib/app-components/about-components/about.types';
import ContactForm from '$lib/app-components/contact-form/ContactForm.svelte';


import Footer from '$lib/app-components/footer/footer.svelte';
import Header from '$lib/app-components/header/Header.svelte';
import '../app.css';

import type { LayoutServerData } from './$types';

export let data: LayoutServerData;
// console.log(data.about);

$: ({ companyDetails } = data.about);



</script>



<Header/>
<main>
    <slot/>
    <ContactForm/>
</main>

<Footer />




