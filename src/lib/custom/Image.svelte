<script lang="ts">
	import { onMount } from 'svelte';
	import type { CompanyGallery } from "$lib/app-components/about-components/about.types";

    export let gallery: CompanyGallery
    export let classList:string | undefined | null

    let loading = false
    let error = false
    let loaded = false

    onMount(()=>{
        // create new instance of image
        const img = new Image()

        // add the source
        img.src = gallery.imageUrl!

        // check status
        img.onload = () => {
            loading = false
            loaded = true
        }

        // on error
        img.onerror = () => {
            loading = false
            error = true
        }
    })
</script>

{#if loading}
    <p>Loading....</p>
{:else if loaded}
    <img class={classList} src={gallery.imageUrl} alt={gallery.imageDescription}>
{:else if error}
    <p>Failed to load image</p>
{/if}