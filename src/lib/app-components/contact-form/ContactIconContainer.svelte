<script lang="ts">
    export let iconData:string;
    export let contactData:string;
</script>

<div class="w-[100%] flex flex-col md:flex-row md:justify-start items-center justify-center m-2">
    <i class="{iconData} text-2xl text-secondaryContainer m-2 md:mr-4 "></i>
    <p class="text-primaryContainer text-xl">{contactData}</p>
</div>