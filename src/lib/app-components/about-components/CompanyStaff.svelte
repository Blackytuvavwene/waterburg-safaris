<script lang="ts">
import type { CompanyStaff } from "./about.types";


    export let companyStaffData:CompanyStaff[];
</script>

<svelte:head>
    <title>Company Staff</title>
</svelte:head>

<div class="flex-col flex w-[100%]  my-6">
    <h1 class="my-2 ml-2 text-2xl font-bold">Below are the awesome staff at Waterburg Safaris</h1>
    <div class="flex my-6 flex-col sm:flex-wrap sm:flex-row justify-evenly items-center">
        {#each companyStaffData as staff}
        <div class="flex flex-col mr-2 items-center justify-center w-[100%] sm:w-80 mb-4 bg-tertiaryContainer pb-4">
            <img src={staff.imageUrl} alt={staff.fullName} >
            <h1 class="text-2xl font-bold text-onTertiaryContainer">{staff?.fullName}</h1>
            <p class="text-s">{staff?.jobTitle}</p>
            <p class="text-s">{staff?.jobDescription}</p>
        </div>
    {/each}
    </div>
</div>