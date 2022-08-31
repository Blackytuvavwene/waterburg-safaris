<script lang="ts">
    export let overviewData:string;

    // split the overview text into an array of paragraphs
    let paragraphs=overviewData.split('  ');
</script>


<div class=" h-full w-[100%]">
    <h1 class=" font-bold text-2xl my-2 lg:my-8">Company overview</h1>
    {#each paragraphs as line}
        <p class="font-semibold text-lg lg:text-2xl">{line}</p><br>
    {/each}
</div>
