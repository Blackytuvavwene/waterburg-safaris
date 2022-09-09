<script lang="ts">
	import type { BookingFormModel } from '$lib/app-components/booking-components/booking.types';
	import type {ActivitiesResponse, Package } from '$lib/app-components/activities-components/activities.types';
	import type {currentA}  from '$lib/app-components/activities-components/activity.stores';
    import { onMount } from 'svelte';
    import { createEventDispatcher, dataset_dev } from 'svelte/internal';
    export let currentActivity:currentA;

    let bookingModelData:BookingFormModel;
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

    // const getPackage=async()=>{
    //     if (currentActivity.pack != undefined && currentActivity.activity?.packages != undefined) {
    //         // console.log(currentActivity.pID);
    //         return await packages?.find(element=>element.packageId===currentActivity.pID);
    //     }
        
    // }

    // onMount(async()=>{
    //     const pD=await getPackage();
    //     packageData=pD as Package;
    // });


    


    bookingModelData={
        bookingCode: crypto.randomUUID(),
        activityDetails: {
            activityName: currentActivity.activity!.activityName,
            activityId: currentActivity.activity!.activityId,
            bookedPackage:{
                packageName:currentActivity.packageD!.packageName,
                packageId:currentActivity.packageD!.packageId,
            }
        },
        paid: true,
        amountPaid:currentActivity.packageD!.price,
        customerDetails: {
            fullNames: fullName!,
            email: email!,
            creditCardDetails: {
                cardNumber: ccNumber!,
                cvv: cvv!,
                cardHolderNames: ccHolderName!,
                expiryDate: ccExpiry!,
            }
       },
       departureDate: departureDate!,
       arrivalDate: arrivalDate!
    };

    function bookActivity(formD:BookingFormModel){
        dispatch("bookSafariActivity",{
           formD
        });
    }

$:({packageD}=currentActivity);

    
</script>

<section class="w-[100%] p-8 lg:p-28 xl:px-36">
    <h1 class="text-xl font-semibold text-primary">Book for {activityName}</h1>
    <form >
        <div class="bg-secondaryContainer p-6">
            <h2 class="text-base font-semibold">Selected Package</h2>
            <p class="text-sm">This is the package you selected for activity category 
                <em class="font-semibold"> {activityName}</em>
            </p>
            <fieldset class="bg-primaryContainer p-6 my-2"> 
                {#if packageD  && packageD.packageOffers}
                <p>{packageD.packageName}</p>
                <p class="text-onPrimaryContainer font-medium text-s ">The package includes</p>
                {#each packageD.packageOffers as offer}
                    <p class="text-xs">{offer}</p>
                {/each}
                {/if}
            </fieldset>
        </div>
        <div class="flex flex-col md:flex-row w-full ">
            <div class="flex flex-col bg-tertiaryContainer p-8 w-full">
                <h3 class="text-base font-semibold lg:font-bold">Card details</h3>
                <div class="flex flex-col gap-4">
                    <fieldset class="flex flex-col gap-2">
                        <div class="flex flex-col gap-1">
                            <label for="names">Name on card</label><p>{ccHolderName}</p>
                            <input type="text" id="names" name="names" bind:value={ccHolderName}>
                        </div>
                        <div class="flex flex-col gap-1">
                            <label for="names">Credit card number</label>
                            <input type="text" id="names" name="names" bind:value={ccNumber}>
                        </div>
                        <div class="flex flex-col gap-1">
                            <label for="names">Expiry</label>
                            <input type="month" id="names" name="names" bind:value={ccExpiry}>
                        </div>
                        <div class="flex flex-col gap-1">
                            <label for="names">CVV</label>
                            <input type="text" id="names" name="names" bind:value={cvv}>
                        </div>
                    </fieldset>
                </div>
            </div>
            <div class="flex flex-col bg-primaryContainer p-8 w-full">
                <h4 class="text-base font-semibold">Billing details</h4>
                <p>Enter your billing address details</p>
                <fieldset class="flex flex-col gap-2">
                    <div class="flex flex-col gap-1">
                        <label for="names">Full names</label>
                        <input type="text" id="names" name="names" bind:value={fullName}>
                    </div>
                    <div class="flex flex-col gap-1">
                        <label for="email">Email</label>
                        <input type="email" name="email" id="" bind:value={email}>
                    </div>
                </fieldset>
            </div>
            <div class="flex flex-col bg-primary-300 p-8 w-full">
                <h4 class="text-base font-semibold">Bookings dates</h4>
                <p>Enter your depature and arrival dates</p>
                <fieldset class="flex flex-col gap-2">
                    <div class="flex flex-col gap-1">
                        <label for="arr-date">Departure date</label>
                        <input type="datetime-local" min={Date.now()} id="arr-date" name="dep-date" 
                        on:click={()=>selectedDepartureDate=true} bind:value={departureDate}>
                    </div>
                    <div class="flex flex-col gap-1">
                        <label for="arr-date">Arrival date</label>
                        <input type="datetime-local" min={Date.now()} name="arr-date" id="arr-date" bind:value={arrivalDate}
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
        <div class="sticky bottom-0 p-2 flex flex-row items-center justify-between bg-primary">
            <p class=" text-base font-semibold text-onPrimary">$ {currentActivity?.packageD?.price}</p>
            <button type="button" value="Proceed to checkout" 
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
            class=" p-2  bg-successContainer text-onSuccessContainer font-bold">Proceed to checkout</button>
        </div>
    </form>
</section>