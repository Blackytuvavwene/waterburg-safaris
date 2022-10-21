<script lang="ts" >
import type { ActivitiesResponse, Package } from '$lib/app-components/activities-components/activities.types';
import {  persistCurrentSelectedStore, type currentA } from '$lib/app-components/activities-components/activity.stores';
import ActivitiesBooking from '$lib/app-components/booking-components/ActivitiesBooking..svelte';
import CurrentActivityBooking from '$lib/app-components/booking-components/CurrentActivityBooking.svelte';
import { activitiesData, activityData, db } from '$lib/firebase';
import type { PageServerData } from './$types';
import { onMount } from 'svelte';
import { doc, setDoc,  } from 'firebase/firestore';
import { DatabaseHandler } from '$lib/helpers/firestore.converters';
import type { BookingFormModel } from '$lib/app-components/booking-components/booking.types';
import { bookingState } from '$lib/app-components/booking-components/booking.stores';
export let data:PageServerData;
import successSvg from "$lib/success.svg";
import { Spinner } from 'flowbite-svelte';
	import { goto } from '$app/navigation';

let cselected:currentA;
let bookingError:any;
let bookingResult:any;

persistCurrentSelectedStore.subscribe(data =>{
        cselected = data;
        // console.log(data);
    });

let loading=false;

async function bookActivity(event:any){
    
        bookingState.setLoading(true);
        // const docRef=doc(db,'bookings',event.detail.bookingModel.bookingCode);

        const model= event.detail.formD as BookingFormModel;
if(model){


    return  DatabaseHandler.setBooking(model.bookingCode!,model).then((result)=>{
        bookingState.setSubmitted(true,model,model.bookingCode);
    
    }).catch(error=>{
        bookingState.setError(true,error.message);
    });
}

    
}

let activitiesDataList=data.activities;

    $: ({ packageD ,activity} = cselected);
</script>

<svelte:head>
    <title>Book {activity!= null? activity.activityName :"activities"} online</title>
</svelte:head>

{#await data.activities}
    <div class="h-screen w-screen bg-black text-white text-4xl">loading...</div>

{/await}

<div class="{$bookingState.status === 'Idle'? "" : "relative" } w-full h-fit">
{#if $bookingState.status === 'Booking' || $bookingState.status === 'Idle'}
    {#if $bookingState.status === 'Booking'}
    <div class="w-full flex flex-col justify-center z-20 items-center h-[100vh] backdrop-invert backdrop-opacity-30 absolute top-0   bottom-0">
        <div class="w-fit bg-onPrimary rounded-xl h-fit opacity-100 p-6 backdrop-opacity-30 flex flex-col items-center justify-center">
          <h6 class="mb-6 text-xl font-bold border-b-2 border-primary w-full text-center pb-2">{$bookingState.status}</h6>
          <p>{$bookingState.message}</p>
          <div class="w-full flex flex-col justify-center items-center my-10">
            <Spinner size="20"/>
          </div>
            
        </div>
    </div>
    {/if}
    {#if activity}
        <div class="w-full h-fit">
            <CurrentActivityBooking currentActivity={cselected} on:bookSafariActivity={bookActivity}/>
        </div>  
        {:else}
        <div class="w-full h-fit">
            <ActivitiesBooking {activitiesDataList} on:bookSafariActivity={bookActivity}/>
        </div>
        
    {/if}
    {:else if $bookingState.status === 'Success'}
    <section class="w-full h-fit flex flex-col items-center">
        <div class="text-center bg-success-100 p-4 border-2 border-success-200 rounded-xl w-fit my-6">
            <i class="fa-solid fa-circle-check text-xl mr-4 text-success-200"></i>
            Booking {$bookingState.status}
        </div>
        <div class="flex flex-col sm:px-10 lg:px-28 xl:px-96 sm:flex-row items-center justify-center lg:my-20 xl:my-52 my-10 w-full">
            <img class="w-52 mb-10 sm:w-56 sm:h-56 h-52 object-cover items-center -translate-x-4 sm:translate-x-0 sm:mr-10" src={successSvg} alt="Successfully booked an activity with Waterburg Safaris">
            <div class="w-full h-full">
                <h1 class="text-success-900 text-lg font-bold px-6">Your booking was successful!</h1>
                <p class="text-md pb-6 pt-2 px-6">You have successfully booked a {$bookingState.data?.activityDetails?.activityName}
                activity with <em class="font-bold">Waterburg Safaris</em>. <span>Please check your email for further details</span></p>
                <p class="ml-6 mb-10">Here is your unique booking code <span class="bg-success-50 p-2 text-lg rounded-xl shadow-lg">{$bookingState.data?.bookingCode}</span></p>
                <div class="w-full flex px-6 gap-6">
                    <button class="p-3 w-full bg-success text-onSuccess rounded-xl " on:click={bookingState.resetAll}>Make a new booking</button>
                    <button class="p-3 text-success border-success border-2 w-full rounded-xl " on:click={()=> goto('/')}>Go home</button>
                </div>
                
            </div>
        </div>
    </section>
    {:else if $bookingState.status === 'Error'}
    <p>{$bookingState.message}</p>
{/if}
</div>

