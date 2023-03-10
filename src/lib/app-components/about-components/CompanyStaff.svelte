<script lang="ts">
	import type { LayoutServerData } from "../../../routes/$types";
import type { CompanyStaff } from "./about.types";

export let companyName:string | undefined;


    export let companyStaffData:CompanyStaff[];

 $:(companyName)
</script>

<svelte:head>
    <title>Company Staff</title>
</svelte:head>

<div class="flex-col flex-auto flex w-[100%]  my-6">
    <h1 class="my-2 mx-4 py-4 sm:px-12 lg:px-32 text-2xl font-bold">
        Below are the awesome staff at {companyName}
    </h1>
    <div class="flex flex-col sm:flex-wrap sm:flex-row justify-evenly mx-4 items-center">
        {#each companyStaffData as staff}
        <div class="flex flex-col items-center justify-center w-[100%] sm:w-80 mb-4 bg-tertiaryContainer p-4">
            <img src={staff.imageUrl} alt={staff.fullName} >
            <h1 class="text-2xl font-bold text-onTertiaryContainer">{staff?.fullName}</h1>
            <p class="text-s">{staff?.jobTitle}</p>
            <p class="text-s">{staff?.jobDescription}</p>
        </div>
    {/each}
    </div>
</div>