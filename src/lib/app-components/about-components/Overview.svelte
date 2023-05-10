<script lang="ts">
    export let overviewData:string;

    // split the overview text into an array of paragraphs
    let paragraphs=overviewData.split('  ');
</script>


<div class="h-full w-full flex flex-col items-center">
    <section class="max-w-md xl:max-w-7xl lg:max-w-4xl sm:max-w-lg md:max-w-2xl">
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
