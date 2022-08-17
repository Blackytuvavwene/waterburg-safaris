<script lang="ts">
import Footer from '$lib/components/footer/footer.svelte';

import Navbar from '$lib/components/navbar/navbar.svelte';


import '../app.css';

</script>



<Navbar/>
<slot></slot>
<Footer/>