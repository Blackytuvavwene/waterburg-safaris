<script>
import ImageSlider from "./components/image-slider.svelte";



</script>


<div class="h-full bg-black flex w-full flex-col ">
    <div class=" bg-primary flex flex-col justify-center items-center h-full  
    lg:flex-row sm:justify-evenly py-8">
        <div class=" mx-6 my-8">
            <section class="my-6">
                <h1 class=" font-[800] text-tertiaryContainer font-sans text-center text-4xl lg:text-start">
                    Welcome to Waterburg Safaris
                </h1>
                <p class="text-center lg:text-start text-primaryContainer 
                text-base font-bold">Explore marvels of creation with us!</p>
            </section>
            <div class="flex flex-col md:flex-row h-full w-[100%]">
                <button class="font-bold bg-onPrimary text-primary shadow-md sm:text-xl sm:p-4
                shadow-onPrimaryContainer hover:-translate-y-1 rounded-lg p-2 md:w-[50%] ">View our activities</button>
                <span class="m-4 "></span>
                <button class="font-bold hover:-translate-y-1 rounded-lg border-onPrimary border-[1px] sm:p-4 p-[7px]
                 md:w-[50%] text-onPrimary">Book online</button>
            </div>
        </div>
        <div class="flex bg-slate-600 lg:w-[50%] lg:flex justify-center items-center ">
            <ImageSlider/>
        </div>
    </div>
</div>

