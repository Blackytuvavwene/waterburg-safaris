<script>
import TopicTextSection from "../home-components/topic-text-section.svelte";

import ActivityCard from "./components/activity-card.svelte";

</script>
<div class="activities">
    <TopicTextSection topicText="Activities" flexDirection="row-reverse" />
    <div class="activity-card">
        <ActivityCard />
    </div>
</div>

<style lang="scss">
    .activities {
        height: 100vh;
        margin-top: 8vh;

        .activity-card {
            width: 100%;
            height: 100%;
            display: flex;
            flex-direction: column;
            margin-top: 25%;
            align-items: center;
        }
    }
</style>