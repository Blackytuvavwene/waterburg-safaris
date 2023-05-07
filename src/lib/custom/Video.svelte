<script lang="ts">
	import { onMount } from 'svelte';
    export let videoUrl:string
    export let width:number | 480

    onMount(() => {
        // const video = new Video
    })
</script>

<video controls width={width} src={videoUrl}>
    trac
</video>