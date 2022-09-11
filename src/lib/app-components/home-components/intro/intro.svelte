<script lang="ts">
	import { persistHomeDataStore } from '$lib/app-components/home-components/helpers/home.stores';
import { resetCurrentSelectedPersist } from '$lib/app-components/activities-components/activity.stores';

import FadeTransition from '$lib/animations/FadeTransition.svelte';
import IntroImageSlider from "./components/IntroImageSlider.svelte";
import SlideText from '$lib/animations/SlideText.svelte';
import { quintOut } from 'svelte/easing';
import type { HomeModel } from '$lib/app-components/home-components/helpers/home.firestore.helpers';

export let homeModel: HomeModel;



$:({homeActivities, aboutCompany}= homeModel)
</script>


<div class="h-full flex w-full flex-col ">
    <div class=" bg-gradient-to-b lg:bg-gradient-to-br from-primary to-black flex flex-col justify-center items-center h-full  
    lg:flex-row sm:justify-evenly py-8 lg:py-10 lg:px-6 ">
        <div class=" mx-[5%] xl:ml-72 my-8 lg:w-[50%]">
            <section class="my-6">
                <div  class="w-full h-full">
                    <SlideText >
                        <h1 class="mb-6 font-extrabold text-tertiaryContainer font-sans text-start sm:text-center text-5xl sm:text-6xl lg:text-start">
                            Welcome to Waterburg Safaris {$persistHomeDataStore.aboutCompany?.companyDetails?.companyName}
                        </h1>
                    </SlideText>
                </div>
                
                
                <p class="text-start sm:text-center lg:text-start text-primaryContainer 
                text-base font-bold">Explore marvels of creation with us!</p>
            </section>
            <div class="flex flex-col md:flex-row h-full w-[100%]">
                <a href="/activities" class="w-full h-full md:w-[50%]">
                    <button class="font-bold w-full bg-onPrimary text-primary shadow-md sm:text-xl sm:p-4
                    shadow-onPrimaryContainer hover:-translate-y-1 rounded-lg p-2  ">View our activities</button>
                </a>
                <span class="m-4 "></span>
                <a href="/book-online" class="w-full  md:w-[50%]">
                    <button class="font-bold w-full transition ease-in-out duration-500 hover:-translate-y-1 rounded-lg
                    border-onPrimary border-[1px] sm:p-4 p-[7px]
                    text-onPrimary" on:click={resetCurrentSelectedPersist}>Book online</button>
                </a>
            </div>
        </div>
            <FadeTransition>
                <div class=" border-2 h-fit xl:h-full
                w-[90%] xl:w-[90%] lg:flex justify-center items-center ">
                {#if aboutCompany?.companyGallery}
                    <IntroImageSlider imageData={aboutCompany.companyGallery[0]}/>
                {/if}
               </div>
            </FadeTransition>
    </div>
</div>

