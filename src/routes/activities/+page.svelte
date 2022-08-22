<script lang="ts">
import type { ActivitiesList, ActivitiesResponse } from '$lib/app-components/activities-components/activities.types';
import ActivityContainer from '$lib/app-components/activities-components/ActivityContainer.svelte';

import type {PageServerData} from './$types';

export let data: PageServerData;

let activities= data.activities as ActivitiesResponse[];

    

console.log(activities);
</script>

<svelte:head>
    <title>Activities</title>
</svelte:head>


<div class="h-full">
    <h1>Waterburg Safaris Activities</h1>
    <p>Our company offers a variety of safari adventure activities that will leave yearning for more</p>
    <div class="flex flex-wrap justify-center">
        {#each activities as activity}
        <ActivityContainer activity={activity}/>
        <a href="activities/{activity.id}"><button class="float-right bg-secondaryContainer p-2 rounded-lg hover:bg-secondary
             hover:text-onSecondary">Learn more</button></a>
        {/each}
    </div>
</div>
