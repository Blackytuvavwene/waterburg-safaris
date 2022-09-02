<script lang="ts">
	import type {ActivitiesResponse, Package } from '$lib/app-components/activities-components/activities.types';
	import type {currentA}  from '$lib/app-components/activities-components/activity.stores';
import { onMount } from 'svelte';
    export let currentActivity:currentA;
    let packageData:Package;

    $:({activityName, seoDescription,overview,packages,tags}=currentActivity.activity as ActivitiesResponse);

    const getPackage=async()=>{
        if (currentActivity.pID != undefined && currentActivity.activity?.packages != undefined) {
            // console.log(currentActivity.pID);
            return await packages?.find(element=>element.packageId===currentActivity.pID);
        }
        
    }

    onMount(async()=>{
        const pD=await getPackage();
        packageData=pD as Package;
    });



    
</script>

<section class="w-[100%] p-8 lg:p-28 ">
    <h1>{activityName}</h1>
    <p>hello</p>
   
    
    <form action="" method="post">
        <div class="">
            <h2>Selected Package</h2>
            <p>This is the package you selected for activity category 
                <em> {activityName}</em>
            </p>
            <fieldset class="">
                {#await packageData}
                   <p>Loading</p> 
                {:then data} 
                <p>{data?.packageName}</p>
                {/await}
                
            </fieldset>
        </div>
        <div class="">
            <fieldset class="">
                <div>
                    <label for="names">Full names</label>
                    <input type="text" id="names" name="names">
                </div>
                <div>
                    <label for="names">Email</label>
                    <input type="email" id="names" name="names">
                </div>
            </fieldset>
        </div>
    </form>
</section>