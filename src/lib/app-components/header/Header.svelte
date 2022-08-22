<script lang="ts">
import { onMount } from "svelte";
import { page } from "$app/stores";
import { fade } from "svelte/transition";


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
    <nav class="w-full flex {mobileNavBarShow ? "flex-col justify-center" : "py-4"} justify-between items-center ">
        <div class="{mobileNavBarShow ? "hidden" : "flex flex-col items-start justify-start "} ml-4">
            <a href="/">Logo</a>
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

        <div class="sm:hidden flex flex-col w-full justify-end items-end">
            <div class="{mobileNavBarShow ? "w-full bg-black h-full flex flex-row justify-between items-center" : ""}">
                <div class="{mobileNavBarShow ? "items-start ml-6" : "hidden"}">
                    <a href="/">Logo</a>
                </div>
                <div class="w-8 h-full mr-4 {mobileNavBarShow ? "translate-y-6" : ""}" on:click={toggleNavBar}>
                    <div class="bg-white w-full h-1 {mobileNavBarShow ? "rotate-45 translate-y-1" : ""}"></div>
                    <div class="bg-none w-full h-2 {mobileNavBarShow ? "hidden" : ""}"></div>
                    <div class="bg-white w-full h-1 {mobileNavBarShow ? "-rotate-45" : ""}"></div>
                </div>
            </div>
            


            {#if mobileNavBarShow}
            <div class="p-6 bg-black {mobileNavBarShow === true ? "block" : "hidden"}
              w-full sidebar transition-all" transition:fade>
                <ul class="list-none flex flex-col justify-between items-center">
                    {#each  navLinks as link}
                        <li class="cursor-pointer ">
                            <a href={link.path} class="text-white 
                            {link === navLinks[navLinks.length - 1] ? "mr-0" : "mb-4"}" on:click={toggleNavBar}>
                                {link.name}
                            </a>
                        </li>
                    {/each}
                </ul>
            </div>
            {/if}
            
        </div>
    </nav>
</header>


