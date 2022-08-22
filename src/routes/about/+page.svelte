<script lang="ts">
import AboutGallery from "$lib/app-components/about-components/AboutGallery.svelte";
import Address from "$lib/app-components/about-components/Address.svelte";

import CompanyStaff from "$lib/app-components/about-components/CompanyStaff.svelte";
import Overview from "$lib/app-components/about-components/Overview.svelte";
import type { PageServerData } from './$types';


export let data: PageServerData;



$: ({ overview,companyStaff, contact, seoDescription, companyName, gallery}=data.about)



</script>

<svelte:head>
    <title>About</title>
    <meta name="description" content={seoDescription}>
</svelte:head>


<div class=" flex-1 flex-col justify-center items-center py-6 mx-6 h-full w-auto">
    <h1 class=" text-primary text-3xl font-bold my-2">{companyName}</h1>
    {#if overview}
    <Overview overviewData={overview}/>
    {/if}
    {#if companyStaff}
    <CompanyStaff companyStaffData={companyStaff}/>
    {/if}
    {#if contact}
    <Address addressData={contact}/>
    {/if}
    {#if gallery}
    <AboutGallery galleryData={gallery}/>
    {/if}
</div>
