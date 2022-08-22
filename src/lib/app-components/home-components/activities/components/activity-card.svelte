<script lang="ts">
import type { ButtonProps } from "$lib/app-components/button/button.props.types";

import FlatButton from "$lib/app-components/button/flat-button.svelte";


import blob from "$lib/background-blob.svg";
import blobImage from "$lib/image-blob.svg";
import ImageBlob from "./image-blob.svelte";


const buttonData:ButtonProps={
        title:"Learn more",
        backGroundColor:'bg-black',
    }
</script>


    

<div class=" max-h-full my-6">
    <div class="activity-description-container">
        <h1>Boat cruise</h1>
        <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quisquam, quidem.</p>
        <FlatButton buttonPropData={buttonData}/>
    </div>
    <span></span>
    <div class="activity-image-container">
        <div class="background-blob">
            <img src={blob} alt="">
        </div>
        <div class="image-blob">
            <ImageBlob/>
        </div>
    </div>
</div>

