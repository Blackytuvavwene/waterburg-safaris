<script>
import ImageSlider from "./components/image-slider.svelte";



</script>


<div class="h-[70vh] bg-black flex w-full flex-col sm:h-full">
    <div class=" bg-primary flex flex-col justify-center items-center h-[40vh]  
    sm:flex-row sm:justify-between sm:static sm:h-full">
        <div class=" mx-6">
            <h1 class=" font-[800] text-center text-2xl sm:text-start">
                Explore marvels of creation with Waterburg Safaris
            </h1>
        </div>
        <div class=" bg-slate-600 top-[28vh] sm:static sm:w-[30%] sm:m-8">
            <ImageSlider/>
        </div>
    </div>
</div>

