<script>
import ArrowCircleButton from "../../home-components/arrow-circle-button.svelte";

</script>

<script context="module" lang="ts">

</script>


<div class="summary-container">
    <div class="summary-text-container">
        <p>Waterburg safaris is a mobile company located in Kasane, Botswana’s one of the tourism town 
            which receive a massive number of guest flocking every year.</p>
    </div>
    <div class="arrow-button">
        <ArrowCircleButton />
    </div>
</div>

<style lang="scss">
    .summary-container{
        height: auto;
        display: flex;
        flex-direction: row;
        justify-content: space-between;
        align-items: center;
        margin-top:5%;
        padding-left: 26px;
        padding-right: 26px;

        .summary-text-container{
            width: 80%;
            display: inline;
            text-align: start;
            color: rgb(0, 0, 136);
            border-radius: 10px;

            p{
                font-size: 2rem;
                font-weight: bold;
                text-align: start;
                margin:0 auto;
            }
        }

        @media screen and (max-width: 600px){
            .summary-text-container{
                width: 70%;
                display: inline;
                text-align: start;
                color: rgb(0, 0, 136);
                border-radius: 10px;

                p{
                    font-size: 1.6rem;
                    font-weight: bold;
                    text-align: start;
                    margin:0 auto;
                }
            }
        }

    }

    
    

    
</style>