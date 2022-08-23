<script lang="ts">

    // Suggestion (check code before using, and possibly convert to data.X access later):
    // import type { PageData } from './$types';
    // export let data: PageData;
    // $: ({ flexDirection, topicText } = data);

    export let flexDirection:string;
    export let topicText:string;

    // import type { PageData } from './$types';
    // export let data: PageData;
    // $: ({ flexDirection, topicText } = data);
    // export let data={
    //         flexDirection:'row',
    //         topicText:'About us'
    //     };
    // $: ({ flexDirection, topicText } = data);

</script>

<div class="mx-6 lg:mx-28 flex items-center justify-between" style:flex-direction={flexDirection}>
    <div class="p-3 bg-primary rounded-xl w-36 lg:w-56 items-center">
        <h1 class="text-onPrimary font-extrabold text-center lg:text-3xl">{topicText}</h1>
    </div>
    <span class="w-4 lg:w-8"></span>
    <div class="w-full h-1 bg-primary"></div>
</div>

