<script lang="ts">
import type { ActivitiesList, ActivitiesResponse } from '$lib/app-components/activities-components/activities.types';
import ActivityContainer from '$lib/app-components/activities-components/ActivityContainer.svelte';

import type {PageServerData} from './$types';
import {navigating}from '$app/stores';

export let data: PageServerData;

let activities= data.activities ;

    

// console.log(activities);
</script>

<svelte:head>
    <title>Activities &#10073; African Journey Tours</title>
    <meta name="description" content='African Journey Tours offers a variety of safari activities taking you on an adventure that leaves wanting more'>
</svelte:head>



<section class="h-full w-full flex flex-col items-center">
    <div class="px-6 lg:px-0 lg:max-w-7xl w-full">
        <h1 class="px-6 pt-6 text-2xl font-bold lg:px-10">African Journey Tours - Activities</h1>
        <p class="px-6 lg:px-10">Our company offers a variety of safari adventure activities that will leave yearning for more</p>
        <div class="flex flex-wrap justify-center py-10">
            {#each activities as activity}
                <div class="m-4 w-full h-full">
                    <ActivityContainer activity={activity}/>
                </div>
            {/each}
        </div>
    </div>
</section>
