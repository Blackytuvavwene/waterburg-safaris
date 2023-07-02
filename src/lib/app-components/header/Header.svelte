<script lang="ts">
    import { onMount } from "svelte";
    import { page } from "$app/stores";
    import { fade, slide } from "svelte/transition";
    import { quadInOut } from "svelte/easing";
    import logo from "$lib/ajtfavicon.svg";
    import { resetCurrentSelectedPersist } from '$lib/app-components/activities-components/activity.stores';




    let mobileNavBarShow = false;
    // hide and open navigation drawer
    function toggleNavBar() {
        mobileNavBarShow = !mobileNavBarShow;
    };

    // close navigation drawer when clicked outside of it
    function closeNavBar() {
       
        mobileNavBarShow = false;
    };

    let mouseHover:boolean=false;

    // header background color on scroll
    let headerBackground:string = 'bg-primary-900';

    

    // navigation links 
    const navLinks = [
        {
            name: "Home",
            id: "",
            path: "/"
        },
        {
            name: "About",
            id: "about",
            path: "/about"
        },
        {
            name: "Activities",
            id: "activities",
            path: "/activities"
        },
        {
            name: "Contact",
            id: "contact",
            path: "/contact"
        },
    ];

   onMount(()=>{
       // listen for view port size change
         window.addEventListener('resize',()=>{
              if(window.innerWidth>1022){
                mobileNavBarShow=false;
              }
         })

         // listen for scroll event to provide background to header
            window.addEventListener('scroll',()=>{
                if(window.scrollY>10){
                    headerBackground='bg-primary-900 bg-opacity-70';
                }else{
                    headerBackground='bg-primary-900';
                }
            })

   })

    // set active link
    $: activeLink = navLinks.find((link) => link.id === $page.params.id);

</script>



<header class="w-full h-full flex lg:justify-center items-center sticky top-0 z-10 {headerBackground}">
    <nav class="w-full h-fit max-w-6xl self-center flex flex-row  justify-between items-center ">
        <div class= "flex flex-col items-start justify-start h-full w-full lg:w-fit">
            <div class="w-full h-full flex flex-row justify-between items-center ">
                <div class="flex flex-row items-center justify-center w-full">
                    <a href="/" class="float-left h-full p-3 flex justify-center items-center">
                        <img src={logo}  alt="African Journey Tours logo" width="50" height="50" />
                    </a>
                    <span class="float-left s:text-base text-xl w-full font-bold mx-2 text-onPrimary">African Journey Tours</span>
                </div>
                <div class="lg:hidden h-full float-right transition delay-1000 flex flex-col w-fit justify-end items-end">
                    <button class="w-8 h-full mr-4 " on:click={toggleNavBar}>
                        <div class="bg-white w-full h-1 {mobileNavBarShow ? "rotate-45 translate-y-1" : ""}"></div>
                        <div class="bg-none w-full h-2 {mobileNavBarShow ? "hidden" : ""}"></div>
                        <div class="bg-white w-full h-1 {mobileNavBarShow ? "-rotate-45" : ""}"></div>
                    </button>
                </div>
            </div>
            {#if mobileNavBarShow}
                <div class="pb-6 bg-gradient-to-b from-primary-900 to-primary {mobileNavBarShow === true ? "block" : "hidden"}
                w-full sidebar ease-in-out duration-500 transition" transition:slide="{{duration:500,easing:quadInOut}}">
                    <div class="list-none flex flex-col  items-center w-full">
                        {#each  navLinks as link}
                            <a href={link.path} class="cursor-pointer text-onPrimary sm:text-center font-bold p-4 hover:bg-onPrimaryContainer hover:text-primaryContainer
                            {link === navLinks[navLinks.length - 1] ? "border-b-0" : "border-b-2"}
                            border-surfaceVariant w-full" on:click={toggleNavBar} data-sveltekit-noscroll>
                                {link.name}
                            </a>
                        {/each}
                    </div>
                </div>
            {/if}
        </div>
        <div class="list-none hidden h-full lg:flex flex-row w-fit justify-evenly  items-center">
            {#each  navLinks as link}
                <a href={link.path} class="cursor-pointe w-fit h-fit px-7 hover:bg-tertiaryContainer   
                hover:text-onTertiaryContainer items-center py-7 text-center font-semibold 
                {$page.route.id ===link.id ?"text-onTertiaryContainer bg-tertiaryContainer": "text-onPrimary"} " 
                 data-sveltekit-noscroll>
                    {link.name}
                </a>
            {/each}
        </div>
        
    </nav>
</header>





