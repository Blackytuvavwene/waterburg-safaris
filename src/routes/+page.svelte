<script lang="ts">
	
   import AboutUs from "$lib/app-components/home-components/about-us/about-us.svelte";
   import Activities from "$lib/app-components/home-components/activities/activities.svelte";
   import Intro from "$lib/app-components/home-components/intro/intro.svelte";
   import { homeDataStore} from "$lib/app-components/home-components/helpers/home.stores";
   import type { HomeModel } from "$lib/app-components/home-components/helpers/home.firestore.helpers";
   import type { PageServerData } from "./$types";
	import Video from "$lib/custom/Video.svelte";

   let homeModel:HomeModel;



   export let data: PageServerData;

   $:({homeData}=data );

// $:console.log(aboutCompany!);




   homeDataStore().subscribe((homeData=>{
      return homeModel=homeData ;
      
   }));


// $:console.log('sets',homeData?.aboutCompany?.companyGallery![0]?.imageUrl);
</script>


<svelte:head>
   <title>
      Home-{homeData.aboutCompany.companyDetails?.companyName}, best safari out there
   </title>
   <meta name="description" content={homeData.aboutCompany.companyDetails?.seoDescription}>
   <!-- <script src="https://kit.fontawesome.com/d20804bf75.js" crossorigin="anonymous"></script> -->
   
</svelte:head>


<Intro homeModel={homeData}/>

<AboutUs gallery={homeData?.aboutCompany?.companyGallery != undefined ? homeData.aboutCompany.companyGallery : []}/>
{#if homeData?.homeActivities != undefined}
<Activities homeActivities={homeData.homeActivities} />
{:else}
<p>No data {homeData.aboutCompany?.companyId}</p>
{/if}
<Video videoUrl='./videos/AJT-WildlifeSlideshow.mp4'/>











