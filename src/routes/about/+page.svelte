<script lang="ts">
	import ImageSlideShow from './../../lib/animations/ImageSlideShow.svelte';
	import type { AboutCompanyResponse, CompanyGallery } from '$lib/app-components/about-components/about.types';
import AboutGallery from "$lib/app-components/about-components/AboutGallery.svelte";
import Address from "$lib/app-components/about-components/Address.svelte";
import CompanyStaff from "$lib/app-components/about-components/CompanyStaff.svelte";
import Overview from "$lib/app-components/about-components/Overview.svelte";
import type { PageServerData } from './$types';
import logoLg from "$lib/ajtfulllogo.png";
import FadeTransition from '$lib/animations/FadeTransition.svelte';
import { onMount } from 'svelte';
import SliderImage from '$lib/app-components/sliders/SliderImage.svelte';

export let data: PageServerData;

let slideIndex:number = 1;
let hideSlide:string;




$: ({companyStaff, companyGallery, companyDetails} = data.about as AboutCompanyResponse)



</script>

<svelte:head>
    <title>{companyDetails?.companyName}</title>
    <meta name="description" content={companyDetails?.seoDescription}>
</svelte:head>


<div class="w-full flex-auto flex items-center justify-center relative h-64 sm:h-80 lg:h-96 mb-6 box-border">
    {#if companyGallery}
    <div class="w-full h-full flex-auto flex items-center justify-center">
        <div class="w-full h-full">
            <ImageSlideShow images={companyGallery}/>
        </div>
        
        <div class="absolute  top-[50%] bottom-[50%] -translate-y-[50%]  -z-0 w-96 md:w-96">
            <div class="w-full h-full items-center justify-center flex-col flex">
                <FadeTransition>
                    <img src={logoLg} class="w-96 md:w-96 h-52 lg:h-80" alt="{companyDetails?.companyName} logo">
                </FadeTransition>
            </div>
        </div>
    </div> 
    {/if}
</div>

<div class="flex-col justify-center items-center h-full w-full flex md:mt-20">
    <h1 class=" text-primary text-3xl sm:px-12 px-6 lg:px-32 lg:text-4xl font-bold my-2">
        {companyDetails?.companyName}
    </h1>
    {#if companyDetails?.overview}
        <div>
            <Overview overviewData={companyDetails?.overview}/>
        </div>
    {/if}
    {#if companyStaff}
        <div>
            <CompanyStaff companyStaffData={companyStaff} companyName={companyDetails?.companyName}/>
        </div>
    {/if}
    {#if companyDetails}
        <div>
            <Address addressData={companyDetails}/>
        </div>
    {/if}
    <!-- {#if gallery}
    <AboutGallery galleryData={gallery}/>
    {/if} -->
</div>


