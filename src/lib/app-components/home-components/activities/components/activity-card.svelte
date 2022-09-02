<script lang="ts">
import type { ButtonProps } from "$lib/app-components/button/button.props.types";

import FlatButton from "$lib/app-components/button/flat-button.svelte";


import blob from "$lib/background-blob.svg";
import ImageBlob from "./image-blob.svelte";


const buttonData:ButtonProps={
        title:"Learn more",
        backGroundColor:'bg-black',
    }
</script>


    

<div class=" h-full w-fit sm:w-80 lg:w-10/12 rounded-2xl mx-6 lg:mx-2  my-6 flex flex-col-reverse lg:flex-row justify-center items-center
border-primary border-2">
    <section class="my-2 lg:ml-10 flex flex-col justify-start items-start p-4">
        <h1 class=" text-2xl font-extrabold text-onPrimaryContainer lg:text-4xl">Boat cruise</h1>
        <p class=" text-onPrimaryContainer lg:text-2xl">Lorem ipsum dolor sit amet consectetur adipisicing elit.
             Quisquam, quidem.</p>
        <a class="w-full" href="/activities"><button class="rounded-lg bg-primaryContainer 
            text-onPrimaryContainer p-3 font-bold my-4 w-full lg:w-full ">Learn more</button></a>
    </section>
    <span class="m-2"></span>
    <figure class="w-full h-full justify-center  lg:justify-end flex  ">
        <img class=" rounded-t-2xl lg:rounded-r-2xl lg:rounded-l-none object-contain w-full h-full" src="/images/boatCruise1.webp" alt="" srcset="">
    </figure>
</div>

