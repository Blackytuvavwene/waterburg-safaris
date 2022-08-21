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
        margin-top: 8vh;

        

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

                .background-blob{
                    position: absolute;
                    top: -210px;
                    right: 60px;
                    height: 100px;
                    width: 500px;
                }

                .image-blob{
                    position: absolute;
                    bottom: 2vh;
                    right: 90px;
                    width: 400px;
                    height:340px;
                }
            }
        }
    }

    @media screen and (max-width:600px) and (max-height:812px){
        .card-container{
            width: 90%;
            height:45vh;

            .activity-image-container{
                width: 100%;
                height: 50%;

                .background-blob{
                    position: absolute;
                    top: -180px;
                    right: 40px;
                    height: 100px;
                    width: 390px;
                }

                .image-blob{
                    position: absolute;
                    bottom: -4px;
                    right: 20px;
                    width: 400px;
                    height: 260px;
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
                    bottom: 100%;
                    right:calc(66px + 0.2rem) ;
                    height: calc(20px + 0.2rem);
                    width: calc(340px + 0.2rem);
                }

                .image-blob{
                    position: absolute;
                    bottom: -40px;
                    width: calc(320px + 0.5rem);
                    height: calc(240px + 0.5rem);
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

    @media only screen and (min-width:768px){
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
                    bottom: -6%;
                    right: 3%;
                    width: 140%;
                    height: 180%;
                }
            }
        }
    }

    @media only screen and (min-width:992px){
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

    @media only screen and (min-width:1200px){
        .card-container{
            width: 90%;
            height:45vh;
            display: flex;
            flex-direction: row;
            align-items: center;
            justify-content: center;
            position: relative;

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
                width: 40%;
                height: 50%;
                background-color: var(--on-primary-container);
                align-items: flex-end;
                display: flex;
                flex-direction: column;
                justify-content: flex-end;
                

                .background-blob{
                    position: absolute;
                    bottom: 140%;
                    right: 2%;
                    height: 10vh;
                    width: 46vw;
                }

                .image-blob{
                    position: absolute;
                    bottom: -40%;
                    right: -10%;
                    width: 140%;
                    height: 180%;
                }
            }
        }
    }
</style>