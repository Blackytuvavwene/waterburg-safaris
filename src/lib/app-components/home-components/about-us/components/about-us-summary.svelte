<script lang="ts">
	import type { CompanyGallery } from "$lib/app-components/about-components/about.types";
  import ArrowCircleButton from "$lib/app-components/button/arrow-circle-button.svelte";
	import Image from "$lib/custom/Image.svelte";

  let services = [
     {
      title: "Game drives",
      index: '1',
      description: "We offer game drive activity in various areas across Botswana where you will have a spectacular safaris drive.",
    },
     {
      title: "Boat cruise",
      index: '2',
      description: "A boat cruise is arranged in the unique river to blowup your experience. Enjoy a cruise in the Chobe River and have an opportunity to experience an exceptional game flocking to the river to quench their thirsty.",
    },
     {
      title: "Canoe",
      index: '3',
      description: "An experiential Mokoro trip in the Okavango Delta will certainly impress your safari as channeling around the flood plains of the unique delta. Moreover opportunity to sport a vast of birds species is guaranteed.",
    },
    {
      title: "Transfers",
      index: '4',
      description: "We go an extra mile to be available to provide services of transfer to make sure the client reaches his or her destination on time. We transfer to wherever you want to go to, be it Maun, Victoria Falls and within Botswana",
    },
    {
      title: "Mobile Camping Safaris",
      index: '5',
      description: " safari which comprises of camping activity to various national parks of Botswana",
    },
]

    // image data
    export let image:CompanyGallery;
</script>




<section class=" bg-primary-100 h-fit md:w-[80vw] max-w-7xl self-center my-8 p-4 rounded-xl flex flex-col lg:flex-row md:gap-x-10 box-border">
    <div class="box-border  p-4 ">
        <span class=" text-secondary-300 font-semibold">
            Know us
        </span>
        <h2 class="text-xl font-bold ">
            About African Journey Tours
        </h2>
        <br>
        <p class="">
            We are committed to provide exceptional mobile safari experience to 
            our valued guests. Quality services is 
            what we are known best at delivering. 
            We give special attention to each 
            and everyone of our guests.
        </p>
        <br>
        <p>
            Africa is a continent of many wonders, and we are here to help you explore it
        </p>
        <br>
        <div class="h-full">
            <Image gallery={image} />
        </div>
    </div>
    <br>
    <section>
        <h3 class="text-2xl font-bold md:text-xl">
            Services we offer
        </h3>
        <ul class=" list-none p-0 m-0">
            {#each services as service, index}
                <li data-before='{index + 1}' 
                class=" before:content-['0'attr(data-before)'.'] before:text-primary-900 before:font-semibold before:px-2
                  my-2 md:my-8">
                    <span class="font-semibold text-xl">
                        {service.title}
                    </span>
                    <p class="pl-8">
                        {service.description}
                    </p>
                </li>
            {/each}
        </ul>
    </section>
</section>

