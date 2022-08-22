<script lang="ts">
import type { Package } from '$lib/app-components/activities-components/activities.types';

    import type { PageServerData } from './$types';

    export let data: PageServerData;

    $: ({ id,discount,includes,price,lastPrice, } = data.activity as Package);
</script>

<h1>Book online</h1>