<script lang="ts">
import type {  CompanyDetails } from "./about.types";


    export let addressData:CompanyDetails;
</script>

<div class="mx-2">
    <h1 class="text-2xl font-bold my-2">Contact</h1>
    <h1 class="text-2xl font-[800]">{addressData.companyAddress}</h1>
</div>