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
        <div class=" mx-[5%]  my-8 lg:w-[50%]">
            <section class="my-6 w-full">
                <div  class="w-full h-full">
                    <SlideText >
                        <h1 class="mb-6 font-extrabold text-tertiaryContainer font-sans text-start sm:text-center text-6xl sm:text-5xl lg:text-start">
                            Welcome to Waterburg Safaris 
                        </h1>
                    </SlideText>
                </div>
                
                
                <p class="text-start sm:text-center lg:text-start text-primaryContainer 
                text-base font-bold">Explore marvels of creation with us!</p>
            </section>
            <div class="flex flex-col md:flex-row h-full w-[100%]">
                <a href="/activities" class="w-full h-[6vh]">
                    <button class="font-bold w-full bg-onPrimary text-primary shadow-md sm:text-xl 
                    shadow-onPrimaryContainer hover:-translate-y-1 rounded-lg p-2 lg:p-0 h-full">View activities</button>
                </a>
                <span class="m-4 "></span>
                <a href="/book-online" class="w-full h-[6vh]">
                    <button class="font-bold w-full transition ease-in-out duration-500 hover:-translate-y-1 rounded-lg
                    border-onPrimary border-[1px] h-full sm:p-4 p-[7px] lg:p-0
                    text-onPrimary" on:click={resetCurrentSelectedPersist}>Book online</button>
                </a>
            </div>
        </div>
            <FadeTransition>
                <div class=" border-2  h-fit xl:h-full w-[90vw]
                sm:w-[80vw] lg:w-[56vw] xl:w-[58vw] lg:flex justify-center items-center ">
                {#if aboutCompany?.companyGallery}
                    <IntroImageSlider imageData={aboutCompany.companyGallery[0]}/>
                {/if}
               </div>
            </FadeTransition>
    </div>
</div>

