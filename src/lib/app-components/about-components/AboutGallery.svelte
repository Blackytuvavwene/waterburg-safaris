<script lang="ts">
    export let galleryData:string[];
</script>

<div>
    <h1 class=" font-bold text-2xl my-2">Gallery</h1>
    <div class="flex flex-col sm:flex-wrap sm:flex-row justify-evenly items-center">
        {#each galleryData as image}
        <div class="flex flex-col items-center justify-center w-[100%] sm:w-80 mb-4 bg-tertiaryContainer p-4">
            <img src={image} alt=""/>
        </div>
    {/each}
    </div>
</div>