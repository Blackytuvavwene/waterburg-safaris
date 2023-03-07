<script lang="ts">
import type { CompanyGallery } from "$lib/app-components/about-components/about.types";


    export let imageData: CompanyGallery;
</script>


    <img class=" max-h-[38rem] object-cover aspect-video object-center  " 
    src={imageData.imageUrl} loading="lazy" alt={imageData.imageDescription} />


