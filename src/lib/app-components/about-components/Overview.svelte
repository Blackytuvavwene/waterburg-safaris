<script lang="ts">
    export let overviewData:string;

    // split the overview text into an array of paragraphs
    let paragraphs=overviewData.split('  ');
</script>


<div class=" h-full w-full">
    <h1 class=" font-bold text-2xl my-2 mx-6 sm:mx-12 lg:mx-32 lg:my-14">Company overview</h1>
    {#each paragraphs as line}
        <p class=" font-bold lg:font-medium mx-6 sm:mx-12 text-base lg:text-lg my-6  lg:mx-32">{line}</p>
    {/each}

</div>
