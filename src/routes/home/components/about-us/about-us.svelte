
<script lang="ts">
    import TopicTextSection from './../home-components/topic-text-section.svelte';
    import AboutUsImageView from './components/about-us-image-view.svelte';
    import AboutUsSummary from './components/about-us-summary.svelte';
</script>


<div class="about-us-container">
    <TopicTextSection topicText="About us"/>
    <AboutUsSummary />
    <AboutUsImageView/>
</div>

<style lang="scss">
    .about-us-container{
        height: 70vh;
        margin-top: 8vh;
    }
</style>