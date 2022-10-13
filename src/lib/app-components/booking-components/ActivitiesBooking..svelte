<script lang="ts">
import type { ActivitiesResponse, Package } from "$lib/app-components/activities-components/activities.types";
import { createEventDispatcher } from "svelte";
import {updateActivity, bookingStore,updatePackage, type BookingStore } from "./booking.stores";
import type { BookingFormModel } from "./booking.types";


    export let activitiesDataList:ActivitiesResponse[];
    let selected:ActivitiesResponse;
    let selectedPackage:Package|null;
    
    let bookingState:BookingStore;
    // create a dispatch dispatcher
    let dispatch = createEventDispatcher();
    // our form model to fill with data
    let bookingModelData:BookingFormModel;


    // values to bind to our form to book the event
    let fullName:string;
    let email:string;
    let ccNumber:string;
    let ccHolderName:string;
    let ccExpiry:Date;
    let cvv:string;
    let amtPaid:number;
    let departureDate:Date;
    let arrivalDate:Date;
    let selectedDepartureDate:boolean=false;
    let selectedArrivalDate:boolean=false;
    let bookCode= crypto.randomUUID().toString();

    bookingStore.subscribe(activ=>{
        bookingState= activ ;
        // console.log(bookingState);
    });

    function setPackage(){
        if(selectedPackage){
            return updatePackage(selectedPackage);
        }
    }

    function resetP(){
        if(selectedPackage){
            return selectedPackage=null;
        }
        
    }

    function setActivity(){
        // console.log('set',selected);
        if(selected){
            // console.log('set',selected);
            return updateActivity(selected);
        }
    }


     // function to dispacth an event to parent
     function bookActivity(formD:BookingFormModel){
        dispatch("bookSafariActivity",{
           formD
        });
    }

    $:({activity,packageD}=bookingState);
</script>

<section class="lg:my-28 my-6 lg:px-32 sm:px-12 w-screen xl:px-72 flex flex-col">
    <h1 class=" text-start pb-10 px-6 sm:px-12 lg:px-32">Book your safari adventure activity now</h1>
    <form action="" method="post" class="flex flex-col px-6 w-full rounded-xl drop-shadow-xl bg-primary-50">
        <div class=" rounded-t-xl p-6 w-full">
            <h2 class="text-base font-semibold lg:font-bold">Activity & Package selection</h2>
            <p>Choose activity and package that suits you</p>
            <fieldset class="flex flex-col ">
                <div class="flex flex-col gap-1">
                    <label for="activity">Activity</label>
                    <select name="activity" id="" bind:value={selected}>
                        {#each activitiesDataList as activity}
                            <option value={activity} on:click={()=>{
                                setActivity();
                                resetP();
                                }} >
                             {activity?.activityName}
                            </option>
                        {/each}
                    </select> 
                </div>
                {#if selected  }
                <div class="flex flex-col py-6 ">
                    {#if selected.packages}
                        <label for="package" class="py-2">Choose package</label>
                        <select name="package" id="" bind:value={selectedPackage}>
                            {#each selected.packages as packagedata}
                            <option value={packagedata}>{packagedata.packageName}</option>
                            {/each}
                        </select>
                    {/if}
                </div>
                <div class="bg-primary-100 shadow-inner rounded-xl p-6 my-2">
                    {#if selectedPackage != null}
                        <p class="text-primary-600 font-bold sm:font-semibold text-s ">{selectedPackage.packageName}</p>
                        <p class="text-primary-600 font-medium text-s ">The package includes</p>
                        <ul class=" pl-6 list-disc ">
                            {#if  selectedPackage.packageOffers}
                                {#each selectedPackage.packageOffers as offer}
                                    <li class="text-xs">{offer}</li>
                                {/each}
                            {/if}
                        </ul>
                    {/if}
                </div>
                {:else}
                <p>Select activity first</p>
                {/if}
            </fieldset>
        </div>
        <div class="flex flex-col md:flex-row w-full ">
            <div class="flex flex-col  p-8 w-full ">
                <h3 class="text-base font-semibold lg:font-bold">Card details</h3>
                <div class="flex flex-col gap-10 w-full">
                    <fieldset class="flex flex-col gap-6">
                        <div class="flex flex-col gap-1">
                            <label for="ccHolderName">Name on card</label>
                            <input type="text" id="ccHolderName" name="ccHolderName" class="sm:w-[20vw] lg:w-[18vw]" bind:value={ccHolderName}>
                        </div>
                        <div class="flex flex-col gap-1">
                            <label for="ccNumber">Credit card number</label>
                            <input type="text" id="ccNumber" name="ccNumber" class="sm:w-[20vw] lg:w-[18vw]" bind:value={ccNumber}>
                        </div>
                        <div class="flex flex-col gap-1">
                            <label for="ccExpiry">Expiry</label>
                            <input type="month" id="ccExpiry" name="ccExpiry" class="sm:w-[20vw] lg:w-[18vw]" bind:value={ccExpiry}>
                        </div>
                        <div class="flex flex-col gap-1">
                            <label for="cvv">CVV</label>
                            <input type="text" id="cvv" name="cvv" class="sm:w-[20vw] lg:w-[18vw]" bind:value={cvv}>
                        </div>
                    </fieldset>
                </div>
            </div>
            <div class="flex flex-col  p-8 w-full ">
                <h4 class="text-base font-semibold">Billing details</h4>
                <p>Enter your billing address details</p>
                <fieldset class="flex flex-col gap-2 w-full">
                    <div class="flex flex-col gap-1 ">
                        <label for="customerNames">Full names</label>
                        <input type="text" id="customerNames" class="sm:w-[20vw] lg:w-[18vw]" name="customerNames" bind:value={fullName}>
                    </div>
                    <div class="flex flex-col gap-1">
                        <label for="customerEmail">Email</label>
                        <input type="email" name="customerEmail" class="sm:w-[20vw] lg:w-[18vw]" id="customerEmail" bind:value={email}>
                    </div>
                </fieldset>
            </div>
            <div class="flex flex-col bg-primary-100 p-8 w-full ">
                <h4 class="text-base font-semibold">Bookings dates</h4>
                <p>Enter your depature and arrival dates</p>
                <fieldset class="flex flex-col gap-2 w-full">
                    <div class="flex flex-col gap-1 w-full">
                        <label for="departureDate">Departure date</label>
                        <input type="datetime-local" min={Date.now()} class="sm:w-[20vw] lg:w-[18vw]" id="departureDate" name="departureDate" 
                        on:click={()=>selectedDepartureDate=true} bind:value={departureDate}>
                    </div>
                    <div class="flex flex-col gap-1 w-full">
                        <label for="arrivalDate">Arrival date</label>
                        <input type="datetime-local" min={Date.now()} class="sm:w-[20vw] lg:w-[18vw]" name="arrivalDate" id="arrivalDate" bind:value={arrivalDate}
                        on:click={()=>selectedArrivalDate=true}>
                    </div>
                </fieldset>
                <div class="w-full flex flex-col py-6 ">
                    <h5 class="font-bold sm:font-semibold py-2">Selected dates</h5>
                    <p class="font-semibold">Departure date :
                        <span class="font-normal">
                            {selectedDepartureDate !== false ? departureDate : 'Please enter a departure date'}
                        </span>
                    </p>
                    <p class="font-semibold">Arrival date :
                        <span class="font-normal">
                            {selectedArrivalDate !== false ? arrivalDate : 'Please enter a arrival date'}
                        </span>
                    </p>
                </div>
                
            </div>
        </div>
        <div class="sticky bottom-0 w-full p-2 flex flex-row items-center justify-between bg-primary">
            <p class=" text-base font-semibold text-onPrimary">$ {selectedPackage?.price}</p>
            <button type="button" value="Proceed to checkout" 
            on:click={()=>{
                bookingModelData={
                    bookingCode: bookCode,
                    activityDetails: {
                        activityName: selected.activityName,
                        activityId: selected.activityId,
                        bookedPackage:{
                            packageName: selectedPackage?.packageName,
                            packageId: selectedPackage?.packageId,
                        }
                    },
                    paid: true,
                    amountPaid: selectedPackage?.price,
                    customerDetails: {
                        fullNames: fullName,
                        email: email,
                        creditCardDetails: {
                            cardNumber: ccNumber,
                            cvv: cvv,
                            cardHolderNames: ccHolderName,
                            expiryDate: ccExpiry,
                        }
                    },
                    departureDate: departureDate,
                    arrivalDate: arrivalDate
                };

                bookActivity(bookingModelData);
            }} 
            class=" p-2 rounded-md shadow-xl drop-shadow-2xl bg-primaryContainer
             text-onPrimaryContainer font-bold hover:bg-success-150 hover:-translate-y-1 transition-all duration-75 ">
            Proceed to checkout</button>
        </div>
    </form>
</section>