<script lang="ts">
import type { Address, Contact } from "./about.types";


    export let addressData:Contact;
</script>

<div class="mx-2">
    <h1 class="text-2xl font-bold my-2">Contact</h1>
    <h1 class="text-2xl font-[800]">{addressData.address?.formattedAddress}</h1>
    <p class="text-xl">{addressData.email}</p>
    <p class="text-xl">{addressData.phone}</p>
</div>