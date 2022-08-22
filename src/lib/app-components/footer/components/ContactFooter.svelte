<script lang="ts">
import type { Address } from "$lib/app-components/about-components/about.types";


    type FooterContactProps={
    address?:Address,
    email?:string,
    phone?:string
}

export let footerContactProps:FooterContactProps;



$:({address,email,phone}=footerContactProps);
</script>

<div class="h-full p-6">
 <h1>Contact</h1>
    {#if footerContactProps}
        <p>{address?.formattedAddress}</p>
        <p>{email}</p>
        <p>{phone}</p>
    {/if}
</div>