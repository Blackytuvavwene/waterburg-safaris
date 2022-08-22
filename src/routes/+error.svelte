<script lang="ts">
    import { page } from '$app/stores';
</script>

<svelte:head>
    <title>Error</title>
</svelte:head>


<div class=" h-screen flex flex-col justify-center items-center bg-errorContainer">
    <p class="text-error">{$page.error.message}</p>
</div>


