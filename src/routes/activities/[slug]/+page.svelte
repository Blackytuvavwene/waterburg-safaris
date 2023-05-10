<script lang="ts">
	import SliderImage from '$lib/app-components/sliders/SliderImage.svelte';
	import FadeTransition from '$lib/animations/FadeTransition.svelte';
import type { ActivitiesResponse } from '$lib/app-components/activities-components/activities.types';
import SlugActivityImageSlider from '$lib/app-components/activities-components/SlugActivityImageSlider.svelte';
import PackageCard from '$lib/app-components/activities-components/PackageCard.svelte';

    import type { PageServerData} from './$types';
	import ImageSlideShow from '$lib/animations/ImageSlideShow.svelte';

    export let data: PageServerData;

    $:({activityId,packages,seoDescription,activityName,activityGallery,overview}= data.activity as ActivitiesResponse);
</script>

<svelte:head>
    <title>{activityName} &#10073; African Journey Tours</title>
    <meta name="description" content={seoDescription}>
</svelte:head>

<div class="w-full h-full flex flex-col items-center">
    <div class="max-w-md lg:max-w-7xl w-full sm:max-w-xl">
        <section class="mt-6">
            <h1>
                <strong class="text-3xl lg:text-4xl lg:font-bold text-primary">
                    {activityName}
                </strong>
            </h1>
            <p class="my-6 font-semibold lg:font-medium lg:text-lg">
                {overview}
            </p>
            <p class="my-6 font-semibold lg:font-medium lg:text-lg">
                {seoDescription}
            </p>
        </section>
        <div class="flex flex-row flex-wrap justify-center
        items-center w-full h-full">
            <div class="py-6 flex flex-col items-center justify-center">
                <h2 class="font-bold text-center pb-6 text-xl sm:text-2xl md:text-3xl">Choose a package that suits</h2>
                <p class="text-center text-lg lg:text-2xl">Below are the packages that we currently offer under 
                    <strong class="text-2xl font-bold">
                        {activityName}
                    </strong> to our clients
                </p>
            </div>
            <div class="flex flex-col items-center my-12 justify-center md:flex-row md:overflow-x-scroll ">
                {#if packages}
                {#each packages as packageData}
                    <div class=" m-4 w-full h-full sm:w-80">
                        <PackageCard activity={data.activity} {packageData}/>
                    </div>
                {/each}
            {/if}
            </div>
        </div>
        <section class="w-full  h-fit mb-10">
            <h2 class=" font-bold text-2xl sm:font-semibold mb-6">{activityName}'s detailed package info</h2>
            <ul class=" px-6 w-full h-fit">
                {#if packages}
                {#each packages as packageData,index}
                <FadeTransition delay={300 + (index * 300)} x={ index % 2 == 0 ? 30 : -30}>
                    <li class=" bg-secondary-100 p-6 my-4">
                        <FadeTransition delay={500 + (index * 500)}>
                            <h3 class="text-xl text-secondary-500 sm:font-medium font-semibold mb-6">
                                {packageData.packageName}
                            </h3>
                        </FadeTransition>
                        <FadeTransition delay={600 + (index * 600)} >
                            <p>{packageData.description}</p>
                        </FadeTransition>
                        {#if packageData.packageOffers}
                        <h4 class="mt-6 mb-2 text-lg font-medium px-10">{packageData.packageName} offers:</h4>
                        <FadeTransition delay={700 + (index * 700)}>
                            <ul class="list-disc px-16 list-inside">
                                {#each packageData.packageOffers as offer}
                                <li class="">{offer}</li>
                                {/each}
                            </ul>
                        </FadeTransition>
                        {/if}
                    </li>
                </FadeTransition>
                    
                {/each}
            {/if}
               
            </ul>
        </section>
    </div>
    <div class=" flex flex-col justify-center w-full h-full ">
        {#if activityGallery}
            <ImageSlideShow images={activityGallery} />
        {/if}
    </div>
</div>

