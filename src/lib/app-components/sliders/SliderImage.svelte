<script lang="ts">
    import { Carousel,CarouselTransition } from "flowbite-svelte";
    import type { CompanyGallery } from "../about-components/about.types";
    import { elasticIn } from 'svelte/easing';
    export let duration=3000;
    export let showThumbs=false
    export let showCaptions=false
    export let showIndicators=false
    export let slideControls=false

    export let gallery:CompanyGallery[];

    const images= gallery.map((item,index)=>{
        return {
            id: index,
            name: item.imageDescription,
            imgurl: item.imageUrl,
            attribution:"Waterburg Safaris"
        }
    });
</script>

<div class="w-full opacity-80">
    <CarouselTransition {images} divClass="overflow-hidden relative  h-64 sm:h-80 lg:h-96"  loop {slideControls} transitionType="fade" transitionParams="{{ duration: 1000 }}" {showIndicators} {showThumbs} {showCaptions} {duration} />
</div>