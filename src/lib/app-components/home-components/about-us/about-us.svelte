
<script lang="ts">
import FadeTransition from "$lib/animations/FadeTransition.svelte";
import SlideText from "$lib/animations/SlideText.svelte";
	import type { CompanyGallery } from "$lib/app-components/about-components/about.types";

import TopicTextSection from "../topic-text-section/topic-text-section.svelte";

import AboutUsImageView from "./components/about-us-image-view.svelte";

import AboutUsSummary from "./components/about-us-summary.svelte";

export let gallery: CompanyGallery[] ;

let ttt={
    topicText: "About us",
    flexDirection: "row"
}


</script>


<div class="z-auto h-full self-center mt-20 flex flex-col">
    <TopicTextSection topicText="About us" flexDirection="row"/>
    <AboutUsSummary image={gallery[0]}/>
</div>

