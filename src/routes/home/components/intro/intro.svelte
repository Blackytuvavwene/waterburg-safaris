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

<style>
    .background-container {
        width: 100%;
        background-color: blue;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        height: 450px;
    }

    .intro{
        height: 650px;
    }


    h1{
        font-size: 2.8rem;
        font-weight: bold;
        color: white;
        text-align: center;
        margin:0 auto;
    }

    .slider-container{
        height: 30vh;
        width: 90vw;
        background: var(--mainWhite);
        display: flex;
        flex-direction: row;
        justify-content: center;
        align-items: center;
        position: absolute;
        top: 40vh;
        left: 5%;
    }

    

    @media screen and (max-width: 600px){
        .slider-container{
            height: 30vh;
            width: 90vw;
            background: var(--mainWhite);
            display: flex;
            flex-direction: row;
            justify-content: center;
            align-items: center;
            position: absolute;
            top:44vh;
            left: 5%;
        }

        .background-container {
            width: 100%;
            background-color: blue;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 55vh;
        }

        .intro{
            height: 74vh;
        }


        h1{
            font-size: 2rem;
            font-weight: bold;
            color: white;
            text-align: center;
            margin:0 auto;
        }
    }

    @media screen and (max-width:600px) and (max-height:640px){
        .slider-container{
            height: 30vh;
            width: 90vw;
            background: var(--mainWhite);
            display: flex;
            flex-direction: row;
            justify-content: center;
            align-items: center;
            position: absolute;
            top:50vh;
            left: 5%;
        }

        .background-container{
            height: 60vh;
        }

        .intro{
            height: 78vh;
        }
    }
</style>