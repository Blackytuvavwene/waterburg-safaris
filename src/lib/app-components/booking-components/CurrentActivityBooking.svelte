<script lang="ts">
	import type {ActivitiesResponse, Package } from '$lib/app-components/activities-components/activities.types';
	import type {currentA}  from '$lib/app-components/activities-components/activity.stores';
import { onMount } from 'svelte';
import { dataset_dev } from 'svelte/internal';
    export let currentActivity:currentA;
    let packageData:Package;

    $:({activityName, seoDescription,overview,packages,tags}=currentActivity.activity as ActivitiesResponse);

    // const getPackage=async()=>{
    //     if (currentActivity.pack != undefined && currentActivity.activity?.packages != undefined) {
    //         // console.log(currentActivity.pID);
    //         return await packages?.find(element=>element.packageId===currentActivity.pID);
    //     }
        
    // }

    // onMount(async()=>{
    //     const pD=await getPackage();
    //     packageData=pD as Package;
    // });



    
</script>

<section class="w-[100%] p-8 lg:p-28 ">
    <h1 class="text-xl font-semibold text-primary">Book for {activityName}</h1>
    <form action="" method="post">
        <div class="bg-secondaryContainer p-6">
            <h2 class="text-base font-semibold">Selected Package</h2>
            <p class="text-sm">This is the package you selected for activity category 
                <em class="font-semibold"> {activityName}</em>
            </p>
            <fieldset class="bg-primaryContainer p-6">
                {#await packageData}
                   <p>Loading</p> 
                {:then data} 
                <p>{data?.packageName}</p>
                {#if data?.packageOffers}
                <p class="text-onPrimaryContainer font-medium ">The package includes</p>
                {#each data?.packageOffers as offer}
                    <p class="text-xs">{offer}</p>
                {/each}
                {/if}
                
                {/await}
                
            </fieldset>
        </div>
        <div>
            <div class="flex flex-col bg-tertiaryContainer p-8">
                <h3 class="text-base font-semibold lg:font-bold">Card details</h3>
                <div class="flex flex-col gap-4">
                    <fieldset class="flex flex-col gap-2">
                        <div class="flex flex-col gap-1">
                            <label for="names">Name on card</label>
                            <input type="text" id="names" name="names" >
                        </div>
                        <div class="flex flex-col gap-1">
                            <label for="names">Credit card number</label>
                            <input type="text" id="names" name="names" >
                        </div>
                        <div class="flex flex-col gap-1">
                            <label for="names">Expiry</label>
                            <input type="text" id="names" name="names" >
                        </div>
                        <div class="flex flex-col gap-1">
                            <label for="names">CVV</label>
                            <input type="text" id="names" name="names" >
                        </div>
                    </fieldset>
                </div>
            </div>
            <div class="flex flex-col bg-secondaryContainer p-8">
                <h4 class="text-base font-semibold">Billing details</h4>
                <p>Enter your billing address details</p>
                <fieldset class="flex flex-col gap-2">
                    <div class="flex flex-col gap-1">
                        <label for="names">Full names</label>
                        <input type="text" id="names" name="names" >
                    </div>
                    <div class="flex flex-col gap-1">
                        <label for="email">Email</label>
                        <input type="email" name="email" id="">
                    </div>
                </fieldset>
            </div>
            <input type="submit" value="Proceed to checkout" class="my-2 p-4 bg-successContainer text-onSuccessContainer font-bold">
        </div>
    </form>
</section>