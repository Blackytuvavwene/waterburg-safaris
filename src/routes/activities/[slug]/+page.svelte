<script lang="ts">
import type { ActivitiesResponse } from '$lib/app-components/activities-components/activities.types';
import SlugActivityImageSlider from '$lib/app-components/activities-components/SlugActivityImageSlider.svelte';
import PackageCard from '$lib/app-components/activities-components/PackageCard.svelte';

    import type { PageServerData} from './$types';

    export let data: PageServerData;

    $:({activityId,packages,seoDescription,activityName,activityGallery,overview}= data.activity as ActivitiesResponse);
</script>

<svelte:head>
    <title>{activityName} &#10073; Waterburg Safaris</title>
    <meta name="description" content={seoDescription}>
</svelte:head>

<div class="w-full h-full flex flex-col pt-6">
    <section class="p-6 lg:px-36">
        <h1><strong class="text-3xl lg:text-4xl lg:font-bold text-primary">{activityName}</strong></h1>
        <p class="my-6 font-semibold lg:text-lg">{overview}</p>
        <p class="my-6 font-semibold lg:text-lg">{seoDescription}</p>
    </section>
    <div class="flex flex-row flex-wrap justify-center
    items-center p-4 w-full h-full">
        <div class="py-6 flex flex-col items-center justify-center">
            <h2 class="font-bold text-center pb-6 text-xl sm:text-2xl md:text-3xl">Choose a package that suits</h2>
            <p class="text-center text-lg lg:text-2xl lg:font-semibold">Below are the packages that we currently offer under 
                <strong class="text-2xl font-bold">{activityName}</strong> to our clients</p>
        </div>
        <div class="flex items-center justify-center md:flex-row flex-wrap ">
            {#if packages}
            {#each packages as packageData}
                <div class=" m-4 w-full h-full sm:w-80">
                    <PackageCard {packageData}/>
                </div>
            {/each}
        {/if}
        </div>
    </div>
    <div class=" flex flex-col justify-center lg:w-full h-full items-cente">
        {#if activityGallery}
            <SlugActivityImageSlider images={activityGallery}/>
        {/if}
    </div>
</div>

