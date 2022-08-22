<script lang="ts">
   
    // Suggestion (check code before using, and possibly convert to data.X access later):
    // import type { PageData } from './$types';
    // export let data: PageData;
    // $: ({ lionImage, waterBerg } = data);

    let lionImage='/images/lion.webp';
    let waterBerg='/images/waterberg.webp';
</script>

<div class="image-container">
    <img src={lionImage} alt="lion" class="image1"/>
    <img src={waterBerg} alt="" class="image2">
</div>
