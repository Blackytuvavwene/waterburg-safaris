<script lang="ts">
import type { ActivitiesResponse } from '$lib/app-components/activities-components/activities.types';
import PackageCard from '$lib/app-components/activities-components/PackageCard.svelte';

    import type { PageServerData} from './$types';

    export let data: PageServerData;

    $:({id,packages,description, activity,gallery}= data.activity as ActivitiesResponse);
</script>

<svelte:head>
    <title>{activity}</title>
    <meta name="description" content={description}>
</svelte:head>

<div class="w-full h-full flex flex-col my-6">
    <p class="m-6">{description}</p>
    <div class="flex flex-row flex-wrap  sm:flex-row justify-around items-center p-4 w-full h-full">
    {#if packages}
        {#each packages as packageData}
            <div class=" m-2 w-52 h-full sm:w-80">
                <PackageCard {packageData}/>
            </div>
        {/each}
    {/if}
</div>
</div>

