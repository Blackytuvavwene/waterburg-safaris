<script lang="ts">
    export let overviewData:string;

    // split the overview text into an array of paragraphs
    let paragraphs=overviewData.split('  ');
</script>


<div class="h-full w-full">
    <section class="max-w-7xl">
        <h1 class=" font-bold text-2xl my-2 lg:my-14">
            Company overview
        </h1>
        {#each paragraphs as line}
            <p class=" text-base lg:text-lg my-6">
                {line}
            </p>
        {/each}
    </section>
</div>
