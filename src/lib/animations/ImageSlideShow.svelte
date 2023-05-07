<script lang="ts">
	import type { CompanyGallery } from "$lib/app-components/about-components/about.types";
	import Image from "$lib/custom/Image.svelte";
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

<div class="h-full w-full">
    {#each images as image, i}
        {#if i === slideIndex}
        <div 
            class="h-full w-full"
            in:fade|local={{ duration: 100, delay: 50, easing: sineIn }}>
            <Image 
                classList=" object-cover h-full w-full aspect-video object-center  " 
                gallery={image} />
        </div>
        {/if}
    {/each}
</div>