<script lang="ts">
import type { CompanyGallery } from "$lib/app-components/about-components/about.types";
	import Image from "$lib/custom/Image.svelte";


    export let imageData: CompanyGallery;
</script>


<Image gallery={imageData} />


