<script lang="ts">
import type { ButtonProps } from '../button/button.props.types';

	import FlatButton from '../button/flat-button.svelte';
    import type { Package } from './activities.types';
    export let packageData:Package;

    const buttonData:ButtonProps={
        title:"Book Now",
        backGroundColor:'bg-secondary',
        fontColor:"text-onSecondary",
        bgHoverColor:"hover:bg-onSecondary",
        fontHoverColor:"hover:text-secondary",
        borderRadius:"rounded-lg",
    }
</script>

<div class=" bg-secondaryContainer flex flex-col justify-center items-center py-4 rounded-xl">
    <h1>{packageData.name}</h1>
    <p class=" font-extrabold">${packageData.price}</p>
    <div class=" flex flex-col justify-center items-center">
        <p class=" text-lg font-bold">Package offers:</p>
        <div class="bg-onSecondaryContainer m-2 px-4 rounded-lg">
            {#if packageData.includes}
                {#each packageData.includes as offer}
                <p class=" text-secondaryContainer border-secondary my-2
                 {offer ===packageData.includes[packageData.includes.length -1] ? ""
                  : "border-b-[1px]"}">{offer}</p>
                {/each}
            {/if}
        </div>
    </div>
    <a href="/book-online/{packageData.id}"><button>Book online</button></a>
</div>