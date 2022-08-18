<script>
import ImageSlider from "./components/image-slider.svelte";





</script>
<div class="intro">
    <div class="container">
        <div class="background-container">
            <h1>Explore marvels of creation with Waterburg Safaris</h1>
            
        </div>
        <div class="slider-container">
            <ImageSlider/>
        </div>
    </div>
    
</div>

<style lang="scss">
    .intro{
        height: 650px;

        /* Extra small devices (phones, 600px and down) */
        @media (max-width: 600px) {
            height: 74vh;
        }

        /* Small devices (portrait tablets and large phones, 600px and up) */
        @media only screen and (min-width: 600px) {
        }

        /* Medium devices (landscape tablets, 768px and up) */
        @media only screen and (min-width: 768px) {
        }

        /* Large devices (laptops/desktops, 992px and up) */
        @media only screen and (min-width: 992px) {
        }

        /* Extra large devices (large laptops and desktops, 1200px and up) */
        @media only screen and (min-width: 1200px) {
        }

        .container{
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            position: relative;
            width: 100%;

            /* Extra small devices (phones, 600px and down) */
            @media (max-width: 600px) {
            }

            /* Small devices (portrait tablets and large phones, 600px and up) */
            @media only screen and (min-width: 600px) {
            }

            /* Medium devices (landscape tablets, 768px and up) */
            @media only screen and (min-width: 768px) {
            }

            /* Large devices (laptops/desktops, 992px and up) */
            @media only screen and (min-width: 992px) {
            }

            /* Extra large devices (large laptops and desktops, 1200px and up) */
            @media only screen and (min-width: 1200px) {
            }

            .background-container {
                width: 100%;
                background-color: var(--primary);
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                height: 450px;

                /* Extra small devices (phones, 600px and down) */
                @media (max-width: 600px) {
                    height: 55vh;
                }

                /* Small devices (portrait tablets and large phones, 600px and up) */
                @media only screen and (min-width: 600px) {
                }

                /* Medium devices (landscape tablets, 768px and up) */
                @media only screen and (min-width: 768px) {
                }

                /* Large devices (laptops/desktops, 992px and up) */
                @media only screen and (min-width: 992px) {
                }

                /* Extra large devices (large laptops and desktops, 1200px and up) */
                @media only screen and (min-width: 1200px) {
                }

                h1{
                    font-size: 2.8rem;
                    font-variation-settings: 'wght' 800;
                    color: var(--on-primary);
                    text-align: center;
                    margin:0 auto;

                    /* Extra small devices (phones, 600px and down) */
                    @media (max-width: 600px) {
                        font-size: 2rem;
                        font-variation-settings: 'wght' 800;
                    }

                    /* Small devices (portrait tablets and large phones, 600px and up) */
                    @media only screen and (min-width: 600px) {
                    }

                    /* Medium devices (landscape tablets, 768px and up) */
                    @media only screen and (min-width: 768px) {
                    }

                    /* Large devices (laptops/desktops, 992px and up) */
                    @media only screen and (min-width: 992px) {
                    }

                    /* Extra large devices (large laptops and desktops, 1200px and up) */
                    @media only screen and (min-width: 1200px) {
                    }
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

                /* Extra small devices (phones, 600px and down) */
                @media (max-width: 600px) {
                    top:44vh;
                    left: 5%;
                }

                /* Small devices (portrait tablets and large phones, 600px and up) */
                @media only screen and (min-width: 600px) {
                }

                /* Medium devices (landscape tablets, 768px and up) */
                @media only screen and (min-width: 768px) {
                }

                /* Large devices (laptops/desktops, 992px and up) */
                @media only screen and (min-width: 992px) {
                }

                /* Extra large devices (large laptops and desktops, 1200px and up) */
                @media only screen and (min-width: 1200px) {
                }
            }
        }

        
    }


    
</style>