
<script lang="ts">
import TopicTextSection from "../topic-text-section/topic-text-section.svelte";

import AboutUsImageView from "./components/about-us-image-view.svelte";

import AboutUsSummary from "./components/about-us-summary.svelte";

let ttt={
    topicText: "About us",
    flexDirection: "row"
}


</script>


<div class=" z-auto h-full my-6">
    <TopicTextSection topicText="About us" flexDirection="row"/>
    <AboutUsSummary />
    <AboutUsImageView/>
</div>

