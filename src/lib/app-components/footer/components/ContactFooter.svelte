<script lang="ts">
import type { Address } from "$lib/app-components/about-components/about.types";
import { footerPropStore, type FooterContactProps } from "../footerprops.types";



let footerContactProps:FooterContactProps;

footerPropStore.subscribe(value=>{
    footerContactProps=value;
});



$:({address,contacts}=footerContactProps);
</script>

<div class="h-full p-6">
 <h1>Contact</h1>
    {#if footerContactProps}
        <p>{address?.country}</p>
        <p>{contacts?.email}</p>
    {/if}
</div>