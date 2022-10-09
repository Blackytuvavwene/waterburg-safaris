<script lang="ts">
	import type { AboutCompanyResponse, CompanyGallery } from '$lib/app-components/about-components/about.types';
import AboutGallery from "$lib/app-components/about-components/AboutGallery.svelte";
import Address from "$lib/app-components/about-components/Address.svelte";
import CompanyStaff from "$lib/app-components/about-components/CompanyStaff.svelte";
import Overview from "$lib/app-components/about-components/Overview.svelte";
import type { PageServerData } from './$types';
import logo from "$lib/wblogolg.svg";
import FadeTransition from '$lib/animations/FadeTransition.svelte';
import { onMount } from 'svelte';
import SliderImage from '$lib/app-components/sliders/SliderImage.svelte';

export let data: PageServerData;

let slideIndex:number = 1;
let hideSlide:string;




$: ({companyStaff,  companyGallery,companyDetails}=data.about as AboutCompanyResponse)



</script>

<svelte:head>
    <title>{companyDetails?.companyName}</title>
    <meta name="description" content={companyDetails?.seoDescription}>
</svelte:head>


<div class="w-full flex items-center  justify-center relative h-64 sm:h-80 lg:h-96 mb-6">
    {#if companyGallery}
    <div class=" w-full h-full flex items-center justify-center">
        <div class="w-full h-full  ">
            <SliderImage gallery={companyGallery} />
        </div>
        
        <div class="absolute  top-[50%] bottom-[50%] -translate-y-[50%]  -z-0 w-96 md:w-96">
            <div class="w-full h-full items-center justify-center flex-col flex">
                <FadeTransition>
                    <img src={logo} class="w-96 md:w-96 h-52 lg:h-80" alt="Waterburg Safaris logo">
                </FadeTransition>
            </div>
            
        </div>
    </div> 
    {/if}
</div>

<div class=" flex-1 flex-col justify-center items-center   h-full w-auto">
    <h1 class=" text-primary text-3xl sm:px-12 px-6 lg:px-32 lg:text-4xl font-bold my-2">{companyDetails?.companyName}</h1>
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


