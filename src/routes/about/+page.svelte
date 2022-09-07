<script lang="ts">
	import type { AboutCompanyResponse } from '$lib/app-components/about-components/about.types';
import AboutGallery from "$lib/app-components/about-components/AboutGallery.svelte";
import Address from "$lib/app-components/about-components/Address.svelte";

import CompanyStaff from "$lib/app-components/about-components/CompanyStaff.svelte";
import Overview from "$lib/app-components/about-components/Overview.svelte";
import type { PageServerData } from './$types';
import logo from "$lib/wblogolg.svg";
import FadeTransition from '$lib/animations/FadeTransition.svelte';
import { Carousel, CarouselTransition } from 'flowbite-svelte';

export let data: PageServerData;



$: ({companyStaff,  companyGallery,companyDetails}=data.about as AboutCompanyResponse)

 



let d:string="3000";
//  autoplay={{
//             delay: 2500,
//             disableOnInteraction: false
//           }}

</script>

<svelte:head>
    <title>{companyDetails?.companyName}</title>
    <meta name="description" content={companyDetails?.seoDescription}>
</svelte:head>


<div class="w-full">
    {#if companyGallery}
    <div class="  static flex   justify-center items-center">
        <Carousel images={companyGallery} loop />
        <div class="top-[50%] bottom-[50%] -translate-y-[50%] -z-0 w-52 md:w-96">
            <FadeTransition>
                <img src={logo} class="" alt="Waterburg Safaris logo">
            </FadeTransition>
        </div>
    </div>
    {/if}
</div>

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
