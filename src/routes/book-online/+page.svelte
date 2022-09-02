<script lang="ts">
import type { ActivitiesResponse, Package } from '$lib/app-components/activities-components/activities.types';
import {  persistCurrentSelectedStore, type currentA } from '$lib/app-components/activities-components/activity.stores';
import ActivitiesBooking from '$lib/app-components/booking-components/ActivitiesBooking..svelte';
import CurrentActivityBooking from '$lib/app-components/booking-components/CurrentActivityBooking.svelte';
import { activitiesData, activityData } from '$lib/firebase';
import type { PageServerData } from './$types';
import { onMount } from 'svelte';
export let data:PageServerData;

let cselected:currentA;

persistCurrentSelectedStore.subscribe(data =>{
        cselected = data;
        console.log(data);
    });



let activitiesDataList=data.activities;

    $: ({ pID ,activity} = cselected);
</script>

<svelte:head>
    <title>Book {activity!= null? activity.activityName :"activities"} online</title>
</svelte:head>

{#if activity}
<div class="w-full">
    <CurrentActivityBooking currentActivity={cselected}/>
</div>  
{:else}
<ActivitiesBooking {activitiesDataList}/>
{/if}