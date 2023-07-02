<script lang="ts">
	import type { BookingFormModel } from '$lib/app-components/booking-components/booking.types';
	import type {ActivitiesResponse, Package } from '$lib/app-components/activities-components/activities.types';
	import type {currentA}  from '$lib/app-components/activities-components/activity.stores';
    import { onMount } from 'svelte';
    import { createEventDispatcher, dataset_dev } from 'svelte/internal';
    export let currentActivity:currentA;

    let bookingModelData:BookingFormModel;

    // create a dispatch dispatcher
    let dispatch = createEventDispatcher();
    

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


    $:({activityName, seoDescription,overview,packages,tags}=currentActivity.activity as ActivitiesResponse);

    
    // function to dispacth an event to parent
    function bookActivity(formD:BookingFormModel){
        dispatch("bookSafariActivity",{
           formD
        });
    }

$:({packageD}=currentActivity);

    
</script>

<section class="lg:my-28 my-6 self-center w-full flex flex-col">
    <h1 class="text-xl font-semibold text-primary text-center">Book for {activityName}</h1>
    <form class="flex flex-col self-center px-6 w-full max-w-[90vw] md:max-w-[80vw] lg:max-w-7xl rounded-xl drop-shadow-xl bg-primary-50" >
        <div class="rounded-xl p-6">
            <h2 class="text-base font-semibold">Selected Package</h2>
            <p class="text-sm">This is the package you selected for activity category 
                <em class="font-semibold"> {activityName}</em>
            </p>
            <fieldset class="bg-primary-100 shadow-inner rounded-xl p-6 my-2"> 
                {#if packageD  && packageD.packageOffers}
                <p class="text-primary-600 font-bold sm:font-semibold text-s ">{packageD.packageName}</p>
                <p class="text-primary-600 font-medium text-s ">The package includes</p>
                <ul class=" pl-6 list-disc ">
                    {#each packageD.packageOffers as offer}
                        <li class="text-xs">{offer}</li>
                    {/each}
                </ul>
                {/if}
            </fieldset>
        </div>
        <div class="flex flex-col md:flex-row w-full ">
            <div class="flex flex-col  p-8 w-full">
                <h4 class="text-base font-semibold">Personal information</h4>
                <p>Enter your names and email</p>
                <fieldset class="flex flex-col gap-2">
                    <div class="flex flex-col gap-1">
                        <label for="customerNames">Full names</label>
                        <input type="text" id="customerNames" name="customerNames" bind:value={fullName}>
                    </div>
                    <div class="flex flex-col gap-1">
                        <label for="customerEmail">Email</label>
                        <input type="email" name="customerEmail" id="customerEmail" bind:value={email}>
                    </div>
                </fieldset>
            </div>
            <div class="flex flex-col bg-primary-100 p-8 w-full">
                <h4 class="text-base font-semibold">Bookings dates</h4>
                <p>Enter your depature and arrival dates</p>
                <fieldset class="flex flex-col gap-2">
                    <div class="flex flex-col gap-1">
                        <label for="departureDate">Departure date</label>
                        <input type="datetime-local" min={Date.now()} id="departureDate" name="departureDate" 
                        on:click={()=>selectedDepartureDate=true} bind:value={departureDate}>
                    </div>
                    <div class="flex flex-col gap-1">
                        <label for="arrivalDate">Arrival date</label>
                        <input type="datetime-local" min={Date.now()} name="arrivalDate" id="arrivalDate" bind:value={arrivalDate}
                        on:click={()=>selectedArrivalDate=true}>
                    </div>
                </fieldset>
                <div class="w-full flex flex-col py-6">
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
        <br>
            <button type="button" value="Book now" 
            on:click={()=>{
                bookingModelData={
                    bookingCode: bookCode,
                    activityDetails: {
                        activityName: currentActivity?.activity?.activityName,
                        activityId: currentActivity?.activity?.activityId,
                        bookedPackage:{
                            packageName:currentActivity?.packageD?.packageName,
                            packageId:currentActivity?.packageD?.packageId,
                        }
                    },
                    paid: true,
                    amountPaid:currentActivity?.packageD?.price,
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
            Book now
        </button>
    </form>
</section>