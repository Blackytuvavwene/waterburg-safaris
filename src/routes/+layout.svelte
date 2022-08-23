<script lang="ts">
import type { Address, AboutResponse } from '$lib/app-components/about-components/about.types';
import ContactForm from '$lib/app-components/contact-form/ContactForm.svelte';


import Footer from '$lib/app-components/footer/footer.svelte';
import Header from '$lib/app-components/header/Header.svelte';
import '../app.css';

import type { LayoutServerData } from './$types';

export let data: LayoutServerData;
data.about as AboutResponse;

$: ({ contact } = data.about);


type FooterContactProps={
    address?:Address,
    email?:string,
    phone?:string
}

let footerContactProps:FooterContactProps=data.about.contact as FooterContactProps;
</script>



<Header/>
<main>
    <slot/>
    <ContactForm/>
</main>

<Footer {footerContactProps}/>




