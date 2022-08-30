<script lang="ts">
	
import type { CompanyDetails } from "$lib/app-components/about-components/about.types";
import { footerPropStore,  type FooterContactProps } from "../footerprops.types";


let footerContactProps:CompanyDetails;


// footerPropStore.subscribe(value=>{
//     footerContactProps=value ;
//     // console.log('hello3',footerContactProps.email);
// });

// $: ({email,telNo}=$footerPropStore);

console.log('hello',$footerPropStore);
</script>

<div class="h-full p-6">
 <h1>Contact</h1>
 {#if $footerPropStore}
    <p>{$footerPropStore.email?.toString()}</p>
 {/if}
    <p>{$footerPropStore.email}</p>
</div>