<script lang="ts">
import type {  CompanyDetails } from "./about.types";


    export let addressData:CompanyDetails;
</script>

<div class="px-2 sm:px-12 lg:px-32 mb-10 w-full">
    <h3 class="text-2xl  font-bold mt-2 mb-4">Contact</h3>
    <div class="grid  md:grid-cols-3 md:h-48 justify-center w-full items-center gap-10 md:mx-0">
        <div class="bg-primary-100 h-full  w-full lg:w-80 rounded-xl flex flex-col justify-center items-center p-6">
            <i class="fa-solid fa-phone bg-primary-200 p-6 mb-1 text-primary-400 rounded-full"></i>
            <p class="text-base text-center break-all font-bold md:font-semibold text-primary-900">{addressData.telNo}</p>
        </div>
        <div class="bg-primary-100 h-full w-full lg:w-80 rounded-xl flex flex-col justify-center items-center p-6">
            <i class="fa-solid fa-envelope-open bg-primary-200 p-6 mb-1 text-primary-400 rounded-full"></i>
            <p class="text-base text-center break-all font-bold md:font-semibold text-primary-900">{addressData.email}</p>
        </div>
        <div class="bg-primary-100 h-full w-full lg:w-80 rounded-xl flex flex-col justify-center items-center p-6">
            <i class="fa-solid fa-map-location-dot bg-primary-200 p-6 mb-1 text-primary-400 rounded-full"></i>
            <p class="text-base text-center font-bold md:font-semibold text-primary-900 break-all">{addressData.companyAddress}</p>
        </div>
    </div>
    
    
</div>