<script lang="ts">
    import { buttonPropDataToList, type ButtonProps } from './button.props.types';
    import '../../../app.css';
    import { onMount } from 'svelte';

    export let buttonPropData:ButtonProps;


     // map buttonPropData to list
    let buttonData:string=buttonPropDataToList(buttonPropData).join(' ');
    
    $: buttonData;

</script>

<button class="{buttonData} p-2">
   {buttonPropData.title}
</button>

