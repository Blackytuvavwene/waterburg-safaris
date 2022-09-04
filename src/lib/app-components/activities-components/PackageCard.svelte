<script lang="ts">
import type { ButtonProps } from '../button/button.props.types';

	import FlatButton from '../button/flat-button.svelte';
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

<div class="w-full bg-secondaryContainer flex flex-col justify-center items-center  py-4 rounded-xl">
    <h1><strong class="text-lg font-bold text-onSecondaryContainer">{packageData.packageName}</strong></h1>
    <p class=" font-bold">${packageData.price}</p>
    <div class=" flex w-full h-fit flex-col justify-center mb-4 items-center">
        <p class=" text-lg font-bold mb-2">Package offers:</p>
        <div class="bg-tertiaryContainer w-full h-fit object-contain p-6 ">
            {#if packageData.packageOffers}
                {#each packageData.packageOffers as offer}
                <p class=" text-onTertiaryContainer border-secondary my-2
                 {offer ===packageData.packageOffers[packageData.packageOffers.length -1] ? ""
                  : "border-b-[1px] py-4"}">{offer}</p>
                {/each}
            {/if}
        </div>
    </div>
    <a class="w-full" href="/book-online">
        <button class="text-onPrimary p-4 w-full bg-secondary" on:click={setBookActivity}>Book online</button></a>
</div>