<script lang="ts">
    import { Carousel,CarouselTransition } from "flowbite-svelte";
    import type { CompanyGallery } from "../about-components/about.types";
    import { circIn, elasticIn, elasticInOut, quartIn } from 'svelte/easing';
    export let duration=3000;
    export let showThumbs=false
    export let showCaptions=false
    export let showIndicators=false
    export let slideControls=false
    export let opacity="opacity-80"
    export let lgHeight = "h-96"
    export let smHeight = "h-80"
    export let height = "h-64"

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

<div class="w-full {opacity}">
    <CarouselTransition 
        {images} 
        divClass="overflow-hidden relative {height} sm:{smHeight} lg:{lgHeight}"  
        loop 
        {slideControls} 
        transitionType="blur"
        transitionParams="{{ duration: 1500  , easing: circIn}}" 
        {showIndicators} 
        {showThumbs} 
        {showCaptions} 
        {duration} 
    />
</div>