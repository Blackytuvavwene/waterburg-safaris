<script lang="ts">
	
import type { CompanyDetails } from "$lib/app-components/about-components/about.types";
import type { HomeModel } from "$lib/app-components/home-components/helpers/home.firestore.helpers";



export let footerData:HomeModel;

$: ({aboutCompany,homeActivities}=footerData);



// console.log('hello',$footerPropStore);
</script>

<div class="h-full p-6 flex justify-between  flex-wrap gap-10">
    <div class="flex flex-col mr-10">
        <h1 class="text-2xl font-bold mb-4">Contact</h1>
        <div class="flex items-center">
            <i class="fa-solid fa-phone text-lg mr-4"></i>
            <p class="font-normal text-md ">
                {aboutCompany?.companyDetails?.telNo}
            </p>
        </div>
        <div class="flex items-center">
            <i class="fa-solid fa-envelope-open text-lg mr-4"></i>
            <p class="font-normal text-md ">
                {aboutCompany?.companyDetails?.email}
            </p>
        </div>
        <div class="flex items-center mb-6">
            <i class="fa-solid fa-map-location-dot mr-4 "></i>
            <p class="font-normal text-md ">
                {aboutCompany?.companyDetails?.companyAddress}
            </p>
        </div>
    </div>
    <div class="flex flex-col mr-10 ">
        <h2 class="text-2xl font-bold mb-4">Activities</h2>
        {#if homeActivities}
        <div class="flex flex-row flex-wrap  ">
            {#each homeActivities as activity,index}
            <div class="flex flex-col {index=== homeActivities.length-1 ? "" :"mr-10"}">
                <h3 class="text-xl font-semibold mb-2">{activity.activityName}</h3>
                {#if activity.tags}
                    {#each activity.tags as tags}
                        <p>{tags}</p>
                    {/each}
                {/if}
            </div>
            
        {/each}
        </div>
            
        {/if}
        
    </div>
</div>