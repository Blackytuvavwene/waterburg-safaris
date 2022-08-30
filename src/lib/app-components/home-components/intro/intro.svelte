<script>
	import FadeTransition from './../../animations/FadeTransition.svelte';
import IntroImageSlider from "./components/IntroImageSlider.svelte";



</script>


<div class="h-full flex w-full flex-col ">
    <div class=" bg-primary flex flex-col justify-center items-center h-full  
    lg:flex-row sm:justify-evenly py-8 lg:py-10 lg:px-6">
        <div class=" mx-[5%] my-8 lg:w-[50%]">
            <section class="my-6">
                <h1 class="mb-6 font-extrabold text-tertiaryContainer font-sans text-center text-5xl sm:text-6xl lg:text-start">
                    Welcome to Waterburg Safaris
                </h1>
                <p class="text-center lg:text-start text-primaryContainer 
                text-base font-bold">Explore marvels of creation with us!</p>
            </section>
            <div class="flex flex-col md:flex-row h-full w-[100%]">
                <button class="font-bold bg-onPrimary text-primary shadow-md sm:text-xl sm:p-4
                shadow-onPrimaryContainer hover:-translate-y-1 rounded-lg p-2 md:w-[50%] ">View our activities</button>
                <span class="m-4 "></span>
                <button class="font-bold transition ease-in-out duration-500 hover:-translate-y-1 rounded-lg
                 border-onPrimary border-[1px] sm:p-4 p-[7px]
                 md:w-[50%] text-onPrimary">Book online</button>
            </div>
        </div>
        <div class="lg:w-[50%] w-full">
            <FadeTransition>
                <div class="flex border-secondaryContainer border-2 w-[90%] h-full sm:h-10/12 md:w-[90%]
                lg:w-fit lg:h-96 lg:flex justify-center items-center ">
                   <IntroImageSlider/>
               </div>
            </FadeTransition>
        </div>
        
        
    </div>
</div>

