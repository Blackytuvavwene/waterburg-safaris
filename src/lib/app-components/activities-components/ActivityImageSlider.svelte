<script lang="ts">
import type { CompanyGallery } from "../about-components/about.types";


    export let images:CompanyGallery[];

    let imageIndex:number=0;

  function  next(){
        if(imageIndex < images.length -1){
            imageIndex+=1;
        }
    }

    function prev(){
        if(imageIndex > 0){
            imageIndex-=1;
        }
    }

</script>

<div class="border-primary border-solid border-8 relative max-w-full h-full">
    <div class="w-full min-w-[250px] min-h-[100px]  h-full">
        
        <img src={images[imageIndex].imageUrl} alt={images[imageIndex].imageDescription} loading="lazy" class="object-contain w-full h-full"/>
    </div>
        
        <div class="text-center absolute bottom-0 text-3xl w-full backdrop-blur">
        {#each images  as image,index}
            <span class=" h-4 w-4 transition ease-in-out duration-500ms inline-block mr-2 {index===imageIndex ? "bg-primary":"bg-slate-300"}
             rounded-full"></span>
        {/each}
        </div>
    <div class="absolute top-[50%] bottom-[50%] -translate-y-[50%] h-fit w-full">
        <button class="float-left h-full text-3xl text-onPrimaryContainer bg-primaryContainer p-2" on:click={prev} >&#10094;</button>
        <button class="float-right h-full text-3xl text-onPrimaryContainer bg-primaryContainer p-2" on:click={next}>&#10095;</button>
    </div>
</div>