<script lang="ts">
import ContactFooter from "./components/ContactFooter.svelte";
import type { Address } from "$lib/app-components/about-components/about.types";


type FooterContactProps={
    address?:Address,
    email?:string,
    phone?:string
}

export let footerContactProps:FooterContactProps;
// console.log(footerContactProps);

</script>


<footer class=" w-full h-full bg-surfaceVariant">
<div>
    {#if footerContactProps}
    <ContactFooter footerContactProps={footerContactProps}/>
    {/if}
</div>
</footer>

