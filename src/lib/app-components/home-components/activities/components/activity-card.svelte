<script lang="ts">
import type { ButtonProps } from "$lib/app-components/button/button.props.types";


import blob from "$lib/background-blob.svg";
	import Image from "$lib/custom/Image.svelte";
import type { HomeActivities } from "../../helpers/home.firestore.helpers";
import ImageBlob from "./image-blob.svelte";

export let activity:HomeActivities;

const buttonData:ButtonProps={
        title:"Learn more",
        backGroundColor:'bg-black',
    }
</script>


    

<div class="max-w-xs w-full bg-primary-100 box-border flex flex-col justify-between">
    <Image classList="h-52 w-full aspect-video object-cover" gallery={activity.image} />
    <section class="p-4 flex gap-4 flex-col">
        <h1 class="font-bold">
            {activity.activityName}
        </h1>
        <p class=" line-clamp-3">
            {activity.activityDetails}
        </p>
        {#if activity.tags}
        <ul class="pl-6 w-full list-disc">
            {#each activity.tags as tags}
            <li>{tags}</li>
        {/each}
        </ul>
        
        {/if}
        <a class="w-full mt-4 text-primary" href="/activities/{activity.activityId}">
           Learn more
        </a>
    </section>
</div>

