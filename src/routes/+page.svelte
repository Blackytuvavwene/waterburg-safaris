<script lang="ts">
	
import AboutUs from "$lib/app-components/home-components/about-us/about-us.svelte";
import Activities from "$lib/app-components/home-components/activities/activities.svelte";
import Intro from "$lib/app-components/home-components/intro/intro.svelte";
import { persistHomeDataStore } from "$lib/app-components/home-components/helpers/home.stores";
import type { HomeModel } from "$lib/app-components/home-components/helpers/home.firestore.helpers";
	import type { PageServerData } from "./$types";

let homeModel:HomeModel;



export let data: PageServerData;

$:({homeData}=data );

// $:console.log(aboutCompany!);




persistHomeDataStore.subscribe((homeData=>{
   return homeModel=homeData ;
    
}));


// $:console.log('sets',homeData?.aboutCompany?.companyGallery![0]?.imageUrl);
</script>


<svelte:head>
    <title>Home-Waterburg Safaris, best safari out there</title>
    <meta name="description" content="Welcome to Waterburg Safaris. Waterburg Safaris & Investments (Pty)
     Ltd is formed to provision of tourism services such as guided safari tours (mobile tented camping safaris
      tours to all the game reserves and national parks of Botswana, Chobe National Park, Savute, Okavango Delta
       moremi Khwai and xakanaxa), nxai pan, Kgalagadi, mabuasehube game reserve), day trips into chobe national
        park, Mighty Victoria Falls Daytrips in Zimbabwe, Boat cruise in chobe river and transfers to various places.">
        <!-- <script src="https://kit.fontawesome.com/d20804bf75.js" crossorigin="anonymous"></script> -->
   
</svelte:head>


<Intro homeModel={homeData}/>
<AboutUs gallery={homeData?.aboutCompany?.companyGallery != undefined ? homeData.aboutCompany.companyGallery : []}/>
{#if homeData?.homeActivities != undefined}
<Activities homeActivities= {homeData.homeActivities} />
{:else}
<p>No data {homeData.aboutCompany?.companyId}</p>
{/if}











