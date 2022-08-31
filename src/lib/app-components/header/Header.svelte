<script lang="ts">
import { onMount } from "svelte";
import { page } from "$app/stores";
import { fade, slide } from "svelte/transition";
import { quadInOut } from "svelte/easing";


    let mobileNavBarShow = false;
    // hide and open navigation drawer
    function toggleNavBar() {
        mobileNavBarShow = !mobileNavBarShow;
    };

    // close navigation drawer when clicked outside of it
    function closeNavBar() {
       
        mobileNavBarShow = false;
    };

    

    // navigation links 
    const navLinks = [
        {
            name: "Home",
            id: "home",
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
        }
    ];

   

</script>



<header class="w-full flex items-center bg-primary">
    <nav class="w-full flex {mobileNavBarShow ? "flex-col" : "py-4"} justify-between items-center ">
        <div class= "flex flex-row items-center w-full justify-between ml-4">
            <a href="/">Logo</a>
            <div class="sm:hidden transition delay-1000 flex flex-col w-full justify-end items-end">
                <div class="w-8 h-full mr-4 {mobileNavBarShow ? "translate-y-4" : ""}" on:click={toggleNavBar}>
                    <div class="bg-white w-full h-1 {mobileNavBarShow ? "rotate-45 translate-y-1" : ""}"></div>
                    <div class="bg-none w-full h-2 {mobileNavBarShow ? "hidden" : ""}"></div>
                    <div class="bg-white w-full h-1 {mobileNavBarShow ? "-rotate-45" : ""}"></div>
                </div>
        </div>
        </div>
        
        <ul class="list-none hidden sm:flex flex-row mr-4 justify-between items-center">
            {#each  navLinks as link}
                <li class="cursor-pointer ">
                    <a href={link.path} class="text-white {link === navLinks[navLinks.length - 1] ? "mr-0" : "mr-10"}">
                        {link.name}
                    </a>
                </li>
            {/each}
        </ul>
        {#if mobileNavBarShow}
            <div class="p-6 bg-gradient-to-b from-primary to-black {mobileNavBarShow === true ? "block" : "hidden"}
              w-full sidebar ease-in-out duration-500 transition" transition:slide="{{duration:500,easing:quadInOut}}">
                <ul class="list-none flex flex-col  items-center">
                    {#each  navLinks as link}
                        <li class="cursor-pointer hover:bg-primaryContainer hover:text-onPrimaryContainer
                         border-b-2 p-4 border-surfaceVariant w-full">
                            <a href={link.path} class="text-onPrimary w-[100%] text-center hover:text-onPrimaryContainer
                            {link === navLinks[navLinks.length - 1] ? "mr-0" : "mb-4"}" on:click={toggleNavBar}>
                                {link.name}
                            </a>
                        </li>
                    {/each}
                </ul>
            </div>
        {/if}
    </nav>
</header>


