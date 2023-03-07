<script lang="ts">
	import type { CompanyGallery } from "$lib/app-components/about-components/about.types";
	import { onMount } from "svelte";
	import { quintOut,elasticIn ,sineIn, sineOut} from "svelte/easing";
	import { fade } from "svelte/transition";

    export let images: CompanyGallery[];
    export let transition:false = false;


    // init slideIndex
    let slideIndex= 0;


    onMount(() => {
        const interval = setInterval(() => {
                // Increment the slideIndex by 1 every 3 seconds and loop back to 0
                slideIndex = (slideIndex + 1) % images.length;
            }, 3000);

            return () => {
                clearInterval(interval);
            };
    });


    $: slideIndex


</script>

<div >
    {#each images as image, i}
        {#if i === slideIndex}
            <img 
            in:fade|local={{ duration: 500, delay: 0, easing: sineIn }}
            class=" object-cover max-h-[34vh] w-full h-full aspect-video object-center  " 
            src={image.imageUrl} loading="lazy" alt={image.imageDescription} />
        {/if}
    {/each}
</div>