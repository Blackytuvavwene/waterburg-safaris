<script lang="ts">
    import "../app.postcss";
	import { isLoading, pageLoading } from '$lib/helpers/global.stores';
	import { page,navigating } from '$app/stores';
    import type {  AboutCompanyResponse } from '$lib/app-components/about-components/about.types';
    import ContactFormFooter from '$lib/app-components/contact-form/ContactFormFooter.svelte';
    // import {
    //         afterNavigate,
    //         beforeNavigate
    //        } from '$app/navigation';

    import Footer from '$lib/app-components/footer/footer.svelte';
    import Header from '$lib/app-components/header/Header.svelte';
	import type { LayoutServerData } from './$types';
	import { onMount } from "svelte";
	import { browser } from "$app/environment";

    let openWidget = false;


   

    export let data: LayoutServerData;

    onMount(() => {

            var chatbox = document.getElementById('fb-customer-chat');

            chatbox!.setAttribute("page_id", "101164178799129");

            chatbox!.setAttribute("attribution", "biz_inbox");

    });


   
    // // console.log(data.about);

    // $: ({ companyDetails } = data.about as AboutCompanyResponse);

    // beforeNavigate(async (url) => {
    //     pageLoading.set(true);
    // });

    // afterNavigate(async (url) => {
    //     pageLoading.set(false);
    // });

    $:({homeData} = data)
    
</script>



<svelte:head>
    <!-- head content -->
    <script>
        window.fbAsyncInit = function() {
                FB.init({
                  xfbml            : true,
                  version          : 'v15.0'
                });
              };
        
              (function(d, s, id) {
                var js, fjs = d.getElementsByTagName(s)[0];
                if (d.getElementById(id)) return;
                js = d.createElement(s); js.id = id;
                js.src = 'https://connect.facebook.net/en_US/sdk/xfbml.customerchat.js';
                fjs.parentNode.insertBefore(js, fjs);
              }(document, 'script', 'facebook-jssdk'));
    </script>
</svelte:head>

<Header/>
<main>
    <slot></slot>
    <!-- {#if $page.url.pathname!=='/contact'}
   
    <ContactFormFooter/>
    {/if} -->
    
</main>
<!-- whatsapp chat widget -->
<div class=" fixed bottom-0 right-0 -translate-x-[4vw] -translate-y-[2vh] z-40">
    <div class=" w-full bg-primary-100 flex flex-col gap-0 transition {openWidget ? " " : "hidden"} h-full rounded-xl mb-4">
        <div class=" p-2 flex border-0 items-center gap-6 rounded-t-xl">
            <div class="bg-white rounded-full w-fit h-fit p-4">
                <span class="text-lg text-primary-400 font-extrabold">
                    W
                    <span class="text-lg text-secondary-400 font-extrabold">
                        B
                    </span>
                </span>
            </div>
            <h6 class="text-xl font-bold text-primary">
                African Journey Tours
            </h6>
        </div>
        <div class="w-fit h-full border-0 border-spacing-0 m-0 rounded-b-xl">
            <div class=" bg-tertiary-100 h-full px-4 m-0 py-8">
                <div class=" bg-tertiary-600 rounded-b-lg rounded-tr-lg p-4">
                    <p class="text-tertiary-50">
                        Hello there! 
                        <span>
                            How can we help you?
                        </span> 
                    </p>
                </div>
            </div>
            <div class=" w-full m-0 rounded-b-xl p-4 h-full flex items-center">
                <a href="https://wa.me/message/IAFUU2O7SW3OA1?src=qr" target="_blank" class=" p-2 rounded-2xl text-center w-full bg-secondary-400 text-secondary-900 font-semibold" rel="noreferrer">
                    Start chat
                </a>
            </div>
            
        </div>
    </div>
    <button on:click={() => openWidget = !openWidget} class="flex items-center gap-2 bg-primary rounded-xl p-4 text-onPrimary font-bold float-right">
        <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-brand-whatsapp" width="32" height="32" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
            <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
            <path stroke-width="2" stroke="#35a373" d="M3 21l1.65 -3.8a9 9 0 1 1 3.4 2.9l-5.05 .9"/>
            <path stroke-width="2" stroke="#35a373" d="M9 10a0.5 .5 0 0 0 1 0v-1a0.5 .5 0 0 0 -1 0v1a5 5 0 0 0 5 5h1a0.5 .5 0 0 0 0 -1h-1a0.5 .5 0 0 0 0 1"/>
         </svg> Contact us
    </button>
    
</div>
<!-- Messenger Chat Plugin Code -->
<div id="fb-root"></div>

<!-- Your Chat Plugin code -->
<div id="fb-customer-chat" class="fb-customerchat">
</div> 




<Footer footerData = {homeData} />









