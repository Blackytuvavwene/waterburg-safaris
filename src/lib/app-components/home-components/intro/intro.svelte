<script lang="ts">
import { resetCurrentSelectedPersist } from '$lib/app-components/activities-components/activity.stores';

import FadeTransition from '$lib/animations/FadeTransition.svelte';
import IntroImageSlider from "./components/IntroImageSlider.svelte";
import SlideText from '$lib/animations/SlideText.svelte';
import { quintOut } from 'svelte/easing';
import type { HomeModel } from '$lib/app-components/home-components/helpers/home.firestore.helpers';

export let homeModel: HomeModel;



$:({homeActivities, aboutCompany}= homeModel)
$:({imageUrl}=aboutCompany.companyGallery![0])
</script>


<div class="h-full flex bg-gradient-to-b from-primary-900 to-primary  flex-col min-h-[70vh] flex-auto">
    <div class="flex flex-auto flex-col justify-center self-center items-center h-full  
    lg:flex-row sm:justify-evenly py-8 lg:py-10 lg:px-6 w-[90vw] md:w-[80vw] max-w-7xl m-auto gap-10">
        <div class=" my-8 lg:w-[50%]">
            <section class="my-6 w-full">
                <div  class="w-full h-full">
                    <SlideText >
                        <h1 class="mb-6 font-extrabold text-tertiaryContainer font-sans text-start sm:text-center text-6xl sm:text-5xl lg:text-start">
                            Welcome to {aboutCompany.companyDetails?.companyName} 
                        </h1>
                    </SlideText>
                </div>
                <p class="text-start lg:text-3xl sm:text-center lg:text-start text-primaryContainer 
                text-base font-bold">Explore marvels of creation with us!</p>
            </section>
            <div class="flex flex-col md:flex-row h-full w-[100%] lg:max-w-sm">
                <a href="/activities" class="w-full h-[6vh]">
                    <button class="font-bold w-full bg-onPrimary text-primary shadow-md 
                    shadow-onPrimaryContainer hover:-translate-y-1 rounded-lg p-2 lg:p-0 h-full">View activities</button>
                </a>
            </div>
        </div>
            <FadeTransition>
                <div class=" box-border border-2 mx-2">
                {#if aboutCompany?.companyGallery}
                    <IntroImageSlider imageData={aboutCompany.companyGallery[1]}/>
                {/if}
               </div>
            </FadeTransition>
    </div>
</div>

