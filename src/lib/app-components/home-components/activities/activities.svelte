<script lang="ts">
import TopicTextSection from "../topic-text-section/topic-text-section.svelte";

import ActivityCard from "./components/activity-card.svelte";



</script>


<div class="h-full my-20 flex flex-col justify-center ">
    <TopicTextSection topicText="Activities" flexDirection="row-reverse" />
    <div class="my-10 flex flex-col items-center">
        <ActivityCard />
    </div>
    
</div>

