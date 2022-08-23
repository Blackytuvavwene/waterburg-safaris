<script lang="ts">
   
    // Suggestion (check code before using, and possibly convert to data.X access later):
    // import type { PageData } from './$types';
    // export let data: PageData;
    // $: ({ lionImage, waterBerg } = data);

    let lionImage='/images/lion.webp';
    let waterBerg='/images/waterberg.webp';
</script>

<div class="w-full h-full items-center justify-center">
    <div class=" m-10 lg:m-28 lg:flex lg:flex-row">
        <img src={lionImage} alt="lion" class="w-full h-full lg:w-[50%] border-secondaryContainer border-8"/>
        <span class="m-4"></span>
        <img src={waterBerg} alt="lion2" class=" w-full h-full lg:w-[50%] border-tertiaryContainer border-8">
    </div>
</div>


