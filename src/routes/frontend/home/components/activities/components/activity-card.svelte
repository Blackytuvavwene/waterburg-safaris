<script lang="ts">
	
import BackgroundBlob from './background-blob.svelte';
import ImageBlob from "./image-blob.svelte";
import blob from "$lib/background-blob.svg";
import blobImage from "$lib/image-blob.svg";
import FlatButton from '$lib/components/button/flat-button.svelte';
</script>


    

<div class="card-container">
    <div class="activity-description-container">
        <h1>Boat cruise</h1>
        <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quisquam, quidem.</p>
        <FlatButton title="Learn more" fontColor="" backGroundColor="" margin="" fontSize="" fontWeight="800"
        padding="" borderRadius=""/>
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

<style lang="scss">
    .card-container{
        display: flex;
        flex-direction: column-reverse;
        align-items: center;
        justify-content:center;
        height: 50vh;
        width: 80vw;
        margin-top: 10px;

        

        .activity-description-container{

            padding: 20px;
            h1{
                font-size: 2rem;
                font-variation-settings: 'wght' 700;
                text-align: start;
                margin:0 auto;
            }

            p{
                font-size: 1.4rem;
                font-variation-settings: 'wght' 500;
                text-align: start;
                margin:0 auto;
            }
        }

        .activity-image-container{
            width: 100%;
            height: 50%;
            position: relative;
            display: flex;
            flex-direction: column;
            align-items:center;
            justify-content: center;
            background-color: var(--on-primary-container);

            .background-blob{
                position: absolute;
                bottom: 40%;
                right: 10%;
                height: 110%;
                width: 120%;
            }

            .image-blob{
                position: absolute;
                bottom: 4%;
                right: 2%;
                width: 120%;
                height: 120%;
            }
        }
    }

    @media screen and (max-width:600px){
        .card-container{
            width: 90%;
            height:45vh;

            .activity-image-container{
                width: 100%;
                height: 50%;
                background-color: var(--on-primary-container);

                .background-blob{
                    position: absolute;
                    bottom: 80%;
                    right: 20%;
                    height: 100%;
                    width: 110%;
                }

                .image-blob{
                    position: absolute;
                    bottom: 4%;
                    right: 2%;
                    width: 130%;
                    height: 140%;
                }
            }
        }
    }

    @media screen and (max-width:600px) and (max-height:640px){
        .card-container{
            width: 90%;
            height:45vh;

            .activity-image-container{
                width: 100%;
                height: 50%;
                background-color: var(--on-primary-container);

                .background-blob{
                    position: absolute;
                    bottom: 90%;
                    right: 30%;
                    height: 90%;
                    width: 90%;
                }

                .image-blob{
                    position: absolute;
                    bottom: -10%;
                    width: 140%;
                    height: 160%;
                }
            }
        }
    }

    @media screen and (min-width:600px){
        .card-container{
            width: 90%;
            height:45vh;

            .activity-image-container{
                width: 100%;
                height: 50%;
                background-color: var(--on-primary-container);

                .background-blob{
                    position: absolute;
                    bottom: 160%;
                    right: 32%;
                    height: 60%;
                    width: 90%;
                }

                .image-blob{
                    position: absolute;
                    bottom: -10%;
                    right: 2%;
                    width: 140%;
                    height: 180%;
                }
            }
        }
    }
</style>