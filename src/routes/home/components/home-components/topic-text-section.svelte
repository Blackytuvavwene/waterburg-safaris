<script lang="ts">
    export let flexDirection:string;
    export let topicText:string;

</script>

<div class="topic-container" style:flex-direction={flexDirection}>
    <div class="text-container">
        <h1 class="topic">{topicText}</h1>
    </div>
    <span></span>
    <div class="line"></div>
</div>

<style lang="scss">
    .topic-container{
        display: flex;
        flex-direction: row;
        justify-content: space-between;
        align-items: center;
        margin-top: auto;
        padding: 0 26px 0 26px;

        .text-container{
            width: 60%;
            padding-left: 2rem;
            display: inline;
            text-align: start;
            background-color: lightskyblue;
            color: rgb(0, 0, 136);
            border-radius: 10px;
            padding: 6px;

            .topic{
                font-size: 2rem;
                font-weight: bold;
                text-align: center;
                margin:0 auto;
            }
        }

        span{
            width: 20px;
        }

        .line{
            width: 100%;
            height: 2px;
            background-color: black;
            display: flex;
            flex-direction: row;
            justify-content: center;
            align-items: center;
        }

        @media screen and (max-width: 600px){
            .text-container{
                width: 80%;
                padding-left: 2rem;
                display: inline;
                text-align: start;
                background-color: lightskyblue;
                color: rgb(0, 0, 136);
                border-radius: 10px;
                padding: 6px;

                .topic{
                    font-size: 1.4rem;
                    font-weight: bold;
                    text-align: center;
                    margin:0 auto;
                }
            }
        }
    }
    
</style>