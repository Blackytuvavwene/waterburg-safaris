<script lang="ts">
	import PackageCard from './PackageCard.svelte';
import type { ActivitiesResponse } from "./activities.types";
import ActivityImageSlider from './ActivityImageSlider.svelte';
	import ImageSlideShow from '$lib/animations/ImageSlideShow.svelte';


    export let activity:ActivitiesResponse;
</script>

<div class="h-full p-6 w-full bg-tertiaryContainer flex flex-col justify-center items-center ">
    <div class="flex flex-col justify-center items-center  lg:flex-row ">
        <div class=" lg:w-[40%] justify-center items-center lg:mr-12 ">
            <p class=" font-sans font-bold text-2xl mb-2 text-onTertiaryContainer text-center md:text-start">
                {activity.activityName}
            </p>
            <p>
                {activity.seoDescription}
            </p>
            <br>
            <p class=" max-h-28 line-clamp-4">
                {activity.overview}
            </p>
            <br>
            <a href="activities/{activity.activityId}"><button class="float-bottom bg-secondaryContainer
                p-4 rounded-lg hover:bg-secondary text-onSecondaryContainer font-bold
               hover:text-onSecondary">Learn more</button></a>
        </div>
        <div class=" flex flex-col justify-center lg:w-[50%] h-72 items-center  my-6">
            {#if activity.activityGallery}
                <ImageSlideShow images={activity.activityGallery}/>
            {/if}
        </div>
    </div>
</div>