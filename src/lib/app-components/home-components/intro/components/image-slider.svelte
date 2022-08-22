<div class="image-container">
    <div class="image-slider">
        <div class="image-slider-item">
            <img src="https://images.unsplash.com/photo-1518791841217-8f162f1e1131?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60" alt="">
        </div>
    </div>
</div>

<style>
    .image-container {
        height: 30vh;
        width: 90vw;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
    }

    .image-slider {
        height: 100%;
        width: 100%;
        display: flex;
        flex-direction: row;
        justify-content: center;
        align-items: center;
        overflow: hidden;
    }

    .image-slider-item {
        height: 100%;
        width: 100%;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        overflow: hidden;
    }

    .image-slider-item img {
        height: 100%;
        width: 100%;
        object-fit: cover;
    }
</style>