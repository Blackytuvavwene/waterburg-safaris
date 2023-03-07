<script lang="ts">
import type { CompanyGallery } from "$lib/app-components/about-components/about.types";


    export let imageData: CompanyGallery;
</script>


    <img class="h-[30vh] sm:h-[40vh] lg:h-[60vh] xl:h-[60vh] w-[100%] object-fill aspect-video object-center  " 
    src={imageData.imageUrl} loading="lazy" alt={imageData.imageDescription} />


