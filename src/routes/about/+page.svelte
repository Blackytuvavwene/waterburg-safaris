<script lang="ts">
import AboutGallery from "$lib/app-components/about-components/AboutGallery.svelte";
import Address from "$lib/app-components/about-components/Address.svelte";

import CompanyStaff from "$lib/app-components/about-components/CompanyStaff.svelte";
import Overview from "$lib/app-components/about-components/Overview.svelte";
import type { PageServerData } from './$types';


export let data: PageServerData;



$: ({companyStaff,  companyGallery,companyDetails}=data.about)



</script>

<svelte:head>
    <title>{companyDetails?.companyName}</title>
    <meta name="description" content={companyDetails?.seoDescription}>
</svelte:head>


<div class=" flex-1 flex-col justify-center items-center py-6 mx-6 h-full w-auto">
    <h1 class=" text-primary text-3xl font-bold my-2">{companyDetails?.companyName}</h1>
    {#if companyDetails?.overview}
    <Overview overviewData={companyDetails?.overview}/>
    {/if}
    {#if companyStaff}
    <CompanyStaff companyStaffData={companyStaff}/>
    {/if}
    {#if companyDetails}
    <Address addressData={companyDetails}/>
    {/if}
    <!-- {#if gallery}
    <AboutGallery galleryData={gallery}/>
    {/if} -->
</div>
