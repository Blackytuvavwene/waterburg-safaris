<script lang="ts">
	import PackageCard from './PackageCard.svelte';
import type { ActivitiesResponse } from "./activities.types";
import ActivityImageSlider from './ActivityImageSlider.svelte';


    export let activity:ActivitiesResponse;
</script>

<div class="h-full p-6 w-full bg-tertiaryContainer flex flex-col justify-center items-center ">
    <div class="flex flex-col justify-center items-center  lg:flex-row ">
        <div class=" lg:w-[40%] justify-center items-center lg:mr-12 ">
            <h1 class=" font-sans font-bold text-2xl mb-2 text-onTertiaryContainer text-center md:text-start">{activity.activityName}</h1>
            <h2>{activity.seoDescription}</h2>
            <br>
            <p class=" max-h-28 overflow-hidden text-ellipsis ">{activity.overview}</p>
            <br>
            <a href="activities/{activity.activityId}"><button class="float-bottom bg-secondaryContainer
                p-4 rounded-lg hover:bg-secondary text-onSecondaryContainer font-bold
               hover:text-onSecondary">Learn more</button></a>
        </div>
        <div class=" flex flex-col justify-center lg:w-[50%] h-full items-center  my-6">
            {#if activity.activityGallery}
                <ActivityImageSlider images={activity.activityGallery}/>
            {/if}
        </div>
    </div>
</div>