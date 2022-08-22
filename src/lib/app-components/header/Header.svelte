<script lang="ts">
import { onMount } from "svelte";
import { page } from "$app/stores";


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
    <nav class="w-full flex justify-between items-center py-4 ml-4">
        <div class="">
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

        <div class="sm:hidden flex flex- justify-end items-center">
            <div class="w-8 h-full mr-4" on:click={toggleNavBar}>
                <div class="bg-white w-full h-1 {mobileNavBarShow ? "rotate-45 translate-y-1" : ""}"></div>
                <div class="bg-none w-full h-2 {mobileNavBarShow ? "hidden" : ""}"></div>
                <div class="bg-white w-full h-1 {mobileNavBarShow ? "-rotate-45" : ""}"></div>
            </div>

            <div class="p-6 absolute top-20 bg-black {mobileNavBarShow === true ? "block" : "hidden"}
            right-0 mx-4 my-2 min-w-[140px] sidebar">
                <ul class="list-none flex flex-col justify-between items-center">
                    {#each  navLinks as link}
                        <li class="cursor-pointer ">
                            <a href={link.path} class="text-white {link === navLinks[navLinks.length - 1] ? "mr-0" : "mb-4"}">
                                {link.name}
                            </a>
                        </li>
                    {/each}
                </ul>
            </div>
        </div>
    </nav>
</header>


