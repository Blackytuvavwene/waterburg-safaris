<script lang="ts">
import type { ButtonProps } from "$lib/app-components/button/button.props.types";


import blob from "$lib/background-blob.svg";
import type { HomeActivities } from "../../helpers/home.firestore.helpers";
import ImageBlob from "./image-blob.svelte";

export let activity:HomeActivities;

const buttonData:ButtonProps={
        title:"Learn more",
        backGroundColor:'bg-black',
    }
</script>


    

<div class=" h-fit w-fit sm:w-80 lg:w-10/12 xl:w-[60%] rounded-2xl mx-6 lg:mx-2  my-6 flex flex-col-reverse lg:flex-row justify-center items-center
border-primary border-2">
    <section class="lg:ml-10 h-[30%] w-full lg:w-[60%] w-flex flex-col justify-start items-start lg:items-center p-4">
        <h1 class=" text-2xl font-extrabold text-onPrimaryContainer lg:text-4xl mb-4">{activity.activityName}</h1>
        {#if activity.tags}
        <ul class="pl-6 w-full list-disc">
            {#each activity.tags as tags}
            <li>{tags}</li>
        {/each}
        </ul>
        
        {/if}
        <a class="w-full" href="/activities/{activity.activityId}"><button class="rounded-lg bg-primaryContainer 
            text-onPrimaryContainer p-3 font-bold mt-4 lg:mt-10 w-full lg:w-full ">Learn more</button></a>
    </section>
    <span class="m-2"></span>
    <figure class="w-full object-cover justify-center h-full lg:justify-end flex  ">
        <img class="w-full rounded-t-2xl lg:rounded-r-2xl lg:rounded-l-none max-h-[300px]" loading="lazy" src={activity.image?.imageUrl} alt={activity.image?.imageDescription} srcset="">
    </figure>
</div>

