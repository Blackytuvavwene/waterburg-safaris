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
    
    <div class=" relative max-w-full h-full">
            <img src={images[imageIndex].imageUrl} alt={images[imageIndex].imageDescription} class="object-contain h-full w-full"/>
            <div class="text-center absolute xs:bottom-[2px] s:bottom-[3px] bottom-[0.4%] text-3xl w-full backdrop-blur">
            {#each images  as image,index}
                <span class=" h-4 w-4 transition ease-in-out duration-500ms inline-block mr-2 {index===imageIndex ? "bg-primary":"bg-slate-300"}
                 rounded-full"></span>
            {/each}
            </div>
        <div class="absolute s:top-[40%] sm:top-[50%] top-[44%] w-full">
            <button class="float-left h-full text-3xl text-onPrimaryContainer bg-primaryContainer p-2" on:click={prev} >&#10094;</button>
            <button class="float-right h-full text-3xl text-onPrimaryContainer bg-primaryContainer p-2" on:click={next}>&#10095;</button>
        </div>
    </div>