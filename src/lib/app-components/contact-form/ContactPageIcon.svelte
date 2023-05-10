<script lang="ts">
    export let iconData:string;
    export let contactData:string;
    let mouseHover:boolean=false;
</script>

<div class="w-[100%] h-[100px] {mouseHover?"bg-primary rounded-lg":""} p-4 flex flex-col md:flex-row 
md:justify-start items-center justify-center " on:mouseenter={()=>mouseHover=true} on:mouseleave={()=>mouseHover=false}>
    <i class="{iconData} text-xl {mouseHover?"text-onPrimary":""} text-onPrimaryContainer m-2 md:mr-4 "></i>
    <p class=" {mouseHover?"text-onPrimary":"text-primary"} text-center text-md font-semibold">{contactData}</p>
</div>