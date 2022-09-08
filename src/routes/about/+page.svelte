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

$: console.log(companyGallery);

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
        
        <div class="absolute  top-[50%] bottom-[50%] -translate-y-[50%]  -z-0 w-52 md:w-96">
            <FadeTransition>
                <img src={logo} class="w-full" alt="Waterburg Safaris logo">
            </FadeTransition>
        </div>
    </div> 
    {/if}
</div>

<div class=" flex-1 flex-col justify-center items-center  mx-6 h-full w-auto">
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


<style>
.swiper {
  width: 100%;
  height: 100%;
}

.swiper-slide {
  text-align: center;
  font-size: 18px;
  background: #fff;

  /* Center slide text vertically */
  display: -webkit-box;
  display: -ms-flexbox;
  display: -webkit-flex;
  display: flex;
  -webkit-box-pack: center;
  -ms-flex-pack: center;
  -webkit-justify-content: center;
  justify-content: center;
  -webkit-box-align: center;
  -ms-flex-align: center;
  -webkit-align-items: center;
  align-items: center;
}

.swiper-slide img {
  display: block;
  width: 100%;
  height: 100%;
  object-fit: cover;
}
</style>