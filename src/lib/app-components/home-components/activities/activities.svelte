<script lang="ts">
	import type{ HomeActivities } from '$lib/app-components/home-components/helpers/home.firestore.helpers';
import TopicTextSection from "../topic-text-section/topic-text-section.svelte";

import ActivityCard from "./components/activity-card.svelte";

let indexes=[0,1,2,3];

export let homeActivities:HomeActivities[] ;

</script>


<div class="h-full my-20 flex flex-col justify-center ">
    <TopicTextSection topicText="Activities" flexDirection="row-reverse" />
    <div class="my-10 flex flex-col items-center gap-12 justify-center sm:flex-row mx-6 self-center ">
        {#if homeActivities}
            {#each homeActivities as activity}
            <ActivityCard {activity} /> 
            {/each}
        {/if}
    </div>
    
</div>

