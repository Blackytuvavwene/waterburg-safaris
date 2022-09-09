<script lang="ts">
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

<main class="relative w-full">
  

{#if $bookingState.status === 'Booking'}
    <div class="w-full flex flex-col justify-center items-center bg-black h-[100vh] absolute top-0 opacity-50 bottom-0">
        <div class="w-fit bg-primary-200 h-fit p-6 animate-pulse">
          <h6>{$bookingState.status}</h6>
          <p>{$bookingState.message}</p>  
        </div>
    </div>
    {:else if $bookingState.status === 'Success'}
    <section class="w-full h-full">
<h1>{$bookingState.status}</h1>
<p>{$bookingState.message}</p>
    </section>
   
    {:else if $bookingState.status === 'Error'}
    <p>{$bookingState.message}</p>
    {:else}
    {#if activity}
    <div class="w-full">
        <CurrentActivityBooking currentActivity={cselected} on:bookSafariActivity={bookActivity}/>
    </div>  
    {:else}
    <ActivitiesBooking {activitiesDataList}/>
    {/if}
{/if}

</main>

