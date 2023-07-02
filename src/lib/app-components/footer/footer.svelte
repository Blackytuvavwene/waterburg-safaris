<script lang="ts">
	import type{ HomeModel } from './../home-components/helpers/home.firestore.helpers';
import ContactFooter from "./components/ContactFooter.svelte";
import wblogoLg from "$lib/ajtfulllogo.png";

export let footerData:HomeModel;









</script>


<footer class=" w-full pt-6 flex flex-col justify-between items-center h-full bg-primary-100">
    <div class="flex flex-col h-full  md:flex-row justify-between w-full xl:px-44">
        <figure class="md:ml-6 xl:ml-0 p-6 mb-4 w-fit xl:mr-12 ">
            <img class=" w-[50%] md:w-4/6 xl:w-56  h-fit object-contain" src={wblogoLg} alt="Waterburg Safaris brand logo" height="200" width="200">
        </figure>
        
        <div class="  justify-end items-center w-fit xl:w-full h-full">
  
            <ContactFooter {footerData}/>
        </div>
    </div>
    <div class="bg-primary-900 p-2 w-full">
        <p class="text-center text-onPrimary font-semibold  flex flex-col md:flex-row items-center justify-center">
            Website made by <a href="https://www.tuvatech.xyz" class="md:ml-2 text-primary-500 font-bold visited:text-green-500"
            target="_blank" rel="noopener noreferrer">
                Boitumelo Tubabwene
            </a>
        </p>
    </div>
</footer>

