<script lang="ts">
	import { fade, fly } from 'svelte/transition';
    import { onMount } from "svelte";
    import { quintOut } from 'svelte/easing';


    // controll animation
    export let delay = 1000;
    export let duration = 3000;
    export let easing = quintOut;
    export let opacity = 0;
    export let x = 30;
    export let y = 0;

    let visible=false;

    function setVisible(entryValue:boolean){
        visible=entryValue;
    }

    let currentView:any;

   

    onMount(()=>{
        const observer=new IntersectionObserver(entries => {
      entries.forEach(entry =>{
        if(entry.isIntersecting && entry.boundingClientRect.y > 20){
        setVisible(entry.isIntersecting);
      };
      })
      
      
    });


        observer.observe(currentView);

    
        return ()=> observer.unobserve(currentView);
    });

     $:currentView;
</script>

<div bind:this={currentView} >
    {#if visible}
    <div 
     transition:fly="{{ duration: duration,delay:delay, x: x, y: y, opacity: opacity, easing: easing}}" >
        <slot ></slot>
    </div>
    {/if}
</div>



