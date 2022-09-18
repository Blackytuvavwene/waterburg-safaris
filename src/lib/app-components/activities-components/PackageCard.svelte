<script lang="ts">


	
    import type { ActivitiesResponse, Package } from './activities.types';
import { setCurrentSelectedPersist } from './activity.stores';
    export let packageData:Package;
    export let activity:ActivitiesResponse;

    const setBookActivity=()=>{
        if(activity.activityId && packageData){
            console.log(activity,'set');
            return setCurrentSelectedPersist(activity,packageData);
        }
    }

   
</script>

<div class="w-full shadow bg-secondary-50 h-[70vh] flex flex-col justify-between items-center rounded-xl">
    <div class="w-full h-32 p-4 flex flex-col justify-evenly items-center">
        <h1 class="text-lg  font-bold text-secondary-400">
            <strong >
                {packageData.packageName}
            </strong>
        </h1>
        <p class=" font-bold ">${packageData.price}</p>
    </div>
    
    <div class=" flex w-full bg-surface-1 h-full rounded-b-xl flex-col justify-between p-6 items-center">
        <p class=" text-lg font-bold mb-2">Package offers:</p>
        <div class=" w-full h-[100%] object-contain mb-4 ">
            {#if packageData.packageOffers}
                {#each packageData.packageOffers as offer}
                <p class=" text-onTertiaryContainer border-secondar
                    {offer ===packageData.packageOffers[packageData.packageOffers.length -1] ? ""
                    : "border-b-[1px] py-1"}">
                   <i class="fa-solid fa-circle-check mr-4"></i> {offer}
                </p>
                {/each}
            {/if}
        </div>
        <a class="w-full" href="/book-online">
            <button class="text-onPrimary p-2 rounded-lg w-full bg-secondary" on:click={setBookActivity}>
                Book online
            </button>
        </a>
    </div>
    
</div>