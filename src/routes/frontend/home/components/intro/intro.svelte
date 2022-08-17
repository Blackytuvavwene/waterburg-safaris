<script>
import ImageSlider from "./components/image-slider.svelte";

</script>
<div class="intro">
    <div class="background-container">
        <h1>Explore marvels of creation with Waterburg Safaris</h1>
        
    </div>
    <div class="slider-container">
        <ImageSlider/>
    </div>
</div>

<style lang="scss">
    

    .intro{
        height: 650px;

        .background-container {
            width: 100%;
            background-color: var(--primary);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 450px;

            h1{
                font-size: 2.8rem;
                font-variation-settings: 'wght' 800;
                color: var(--on-primary);
                text-align: center;
                margin:0 auto;
            }
        }

        .slider-container{
            height: 30vh;
            width: 90vw;
            display: flex;
            flex-direction: row;
            justify-content: center;
            align-items: center;
            position: absolute;
            top: 40vh;
            left: 5%;
        }
    }


    @media screen and (max-width: 600px){
        .intro{
            height: 74vh;

            .background-container {
                height: 55vh;

                h1{
                    font-size: 2rem;
                    font-variation-settings: 'wght' 800;
                }
            }

            .slider-container{
                top:44vh;
                left: 5%;
            }
        }
    }

    @media screen and (max-width:600px) and (max-height:640px){
        .intro{
            height: 78vh;

            .background-container{
                height: 60vh;

                h1{
                    font-variation-settings: 'wght' 800;
                }
            }

            .slider-container{
                top:50vh;
                left: 5%;
            }
        }
    }
</style>