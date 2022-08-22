<script lang="ts">
import TopicTextSection from "../topic-text-section/topic-text-section.svelte";

import ActivityCard from "./components/activity-card.svelte";



</script>


<div class="h-full my-6">
    <TopicTextSection topicText="Activities" flexDirection="row-reverse" />
    <div class="activity-card">
        <ActivityCard />
    </div>
</div>

