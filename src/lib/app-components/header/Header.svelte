<script lang="ts">
import { onMount } from "svelte";
import { page } from "$app/stores";
import { fade, slide } from "svelte/transition";
import { quadInOut } from "svelte/easing";
import logo from "$lib/wblogos.svg";


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
        {
            name: "Book online",
            id: 'book-onine',
            path: '/book-onine'
        }
    ];

   

</script>



<header class="w-full h-full flex items-center sticky top-0 z-10 bg-primary-900 ">
    <nav class="w-full h-full sm:px-10 xl:px-72 flex flex-row  justify-between items-center ">
        <div class= "flex flex-col items-start justify-start h-full w-full">
            <div class="w-full h-full flex flex-row justify-between items-center ">
                <div class="flex flex-row items-center justify-center w-full">
                    <a href="/" class="float-left h-full p-3 flex justify-center items-center">
                        <img src={logo}  alt="Waterburg Safaris logo" width="50" height="50" />
                    </a>
                    <span class="float-left s:text-base text-xl w-full font-bold mx-2 text-onPrimary">Waterburg Safaris</span>
                </div>
                <div class="lg:hidden h-full transition delay-1000 flex flex-col w-full justify-end items-end">
                    <div class="w-8 h-full mr-4 " on:click={toggleNavBar}>
                        <div class="bg-white w-full h-1 {mobileNavBarShow ? "rotate-45 translate-y-1" : ""}"></div>
                        <div class="bg-none w-full h-2 {mobileNavBarShow ? "hidden" : ""}"></div>
                        <div class="bg-white w-full h-1 {mobileNavBarShow ? "-rotate-45" : ""}"></div>
                    </div>
                </div>
            </div>
            {#if mobileNavBarShow}
            <div class="pb-6 bg-gradient-to-b from-primary-900 to-primary {mobileNavBarShow === true ? "block" : "hidden"}
              w-full sidebar ease-in-out duration-500 transition" transition:slide="{{duration:500,easing:quadInOut}}">
                <div class="list-none flex flex-col  items-center w-full">
                    {#each  navLinks as link}
                        <a href={link.path} class="cursor-pointer text-onPrimary sm:text-center font-bold p-4 hover:bg-onPrimaryContainer hover:text-primaryContainer
                        {link === navLinks[navLinks.length - 1] ? "border-b-0" : "border-b-2"}
                          border-surfaceVariant w-full" on:click={toggleNavBar}>
                            {link.name}
                        </a>
                    {/each}
                </div>
            </div>
        {/if}
        </div>
        <div class="list-none hidden h-full lg:flex flex-row w-full justify-evenly flex-grow items-center">
            {#each  navLinks as link}
                <a href={link.path} class="cursor-pointer flex-grow w-full h-full px-6 hover:bg-tertiaryContainer py-6  
                hover:text-onTertiaryContainer text-center font-semibold {$page.routeId ===link.id ?"text-onTertiaryContainer bg-tertiaryContainer": "text-onPrimary"} ">
                    {link.name}
                </a>
            {/each}
        </div>
        
    </nav>
</header>


