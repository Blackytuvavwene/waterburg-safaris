<script lang="ts">
	import PackageCard from './PackageCard.svelte';
import type { ActivitiesResponse } from "./activities.types";
import ActivityImageSlider from './ActivityImageSlider.svelte';


    export let activity:ActivitiesResponse;
</script>

<div class="h-full m-6 w-full flex flex-col md:flex-row ">
    <div class=" md:w-[40%]">
        <h1 class=" font-sans font-bold text-lg text-center">{activity.activity}</h1>
        <p>{activity.description}</p>
    </div>
    <div class=" flex flex-col justify-center float-right items-center md:flex-row my-6">
    {#if activity.gallery}
        <ActivityImageSlider images={activity.gallery}/>
    {/if}
</div>
</div>