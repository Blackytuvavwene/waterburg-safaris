<script lang="ts">
    export let lionImage='/images/lion.JPG';
    export let waterBerg='/images/waterberg.JPG';
</script>

<div class="image-container">
    <img src={lionImage} alt="lion" class="image1"/>
    <img src={waterBerg} alt="" class="image2">
</div>

<style lang="scss">
    .image-container{
        height: 30vh;
        width: 90vw;
        background: var(--mainWhite);
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        margin: 20px;
        position: relative;

        img{
            height: 70%;
            width: 70%;
            object-fit: cover;
            border: 1px solid black;
        }

        .image1{
            position: absolute;
            top: 40%;
            left: 0;
        }

        .image2{
            position: absolute;
            top: 0;
            right: 0;
        }


    }


</style>