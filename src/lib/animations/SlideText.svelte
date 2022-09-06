<script lang="ts">
	import { fade, fly } from 'svelte/transition';
    import { onMount } from "svelte";
    import { quintOut } from 'svelte/easing';
import type { FlyTransistion } from './transitions.helpers';


    let visible=false;

    function setVisible(entryValue:boolean){
        visible=entryValue;
    }

    let currentView:any;

    onMount(()=>{
        const observer=new IntersectionObserver(entries => {
      entries.forEach(entry =>{
        if(entry.isIntersecting){
        setVisible(entry.isIntersecting);
      };
      })
      
      
    });


        observer.observe(currentView);

    
        return ()=> observer.unobserve(currentView);
    });

     $:currentView;
</script>

<div bind:this={currentView} class=" w-full flex flex-col justify-center items-center h-full">
    {#if visible}
    <div id="current" class="flex flex-col justify-center items-center w-full h-full"
     transition:fly="{{ duration: 3000,delay:0, x: 0, y: 50, opacity: 0, easing: quintOut} }" >
        <slot ></slot>
    </div>
    {/if}
</div>






