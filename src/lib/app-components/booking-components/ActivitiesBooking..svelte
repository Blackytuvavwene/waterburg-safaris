<script lang="ts">
import type { ActivitiesResponse, Package } from "$lib/app-components/activities-components/activities.types";
import {updateActivity, bookingStore,updatePackage, type BookingStore } from "./booking.stores";


    export let activitiesDataList:ActivitiesResponse[];
    let selected:ActivitiesResponse;
    let selectedPackage:Package|null;
    
    let bookingState:BookingStore;

    bookingStore.subscribe(activ=>{
        bookingState= activ ;
        console.log(bookingState);
    });

    function setPackage(){
        if(selectedPackage){
            return updatePackage(selectedPackage);
        }
    }

    function setActivity(){
        console.log('set',selected);
        if(selected){
            console.log('set',selected);
            return updateActivity(selected);
        }
    }

    $:({activity,packageD}=bookingState);
</script>

<section class="m-8 lg:m-28">
    <h1>Book your safari adventure activity now</h1>
    <form action="" method="post" class="flex flex-col">
        <div class="bg-primaryContainer p-6">
            <h2 class="text-base font-semibold lg:font-bold">Activity & Package selection</h2>
            <p>Choose activity and package that suits you</p>
            <fieldset class="flex flex-col ">
                <div class="flex flex-col gap-1">
                    <label for="activity">Activity</label>
                    <select name="activity" id="" bind:value={selected}>
                        {#each activitiesDataList as activity}
                            <option value={activity} on:click={setActivity} on:click="{()=>{selected=activity,selectedPackage=null}}">
                             {activity?.activityName}
                            </option>
                        {/each}
                    </select> 
                </div>
                {#if selected != undefined }
                <div>
                    {#if selected.packages}
                    <label for="package">Choose package</label>
                    <select name="package" id="" bind:value={selectedPackage}>
                        {#each selected.packages as packagedata}
                        <option value={packagedata}>{packagedata.packageName}</option>
                        {/each}
                    </select>
                    {/if}
                </div>
                <div class="py-4">
                    {#if selectedPackage}
                    <p>{selectedPackage.description}</p> 
                    {/if}
                </div>
                {:else}
                <p>Select activity first</p>
                {/if}
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
        </div>
        <div class="sticky bottom-0 p-2 flex flex-row items-center justify-between bg-primary">
            <p class=" text-base font-semibold text-onPrimary">$ {selectedPackage?.price}</p>
            <input type="submit" value="Proceed to checkout" class=" p-2  bg-successContainer text-onSuccessContainer font-bold">
        </div>
    </form>
</section>