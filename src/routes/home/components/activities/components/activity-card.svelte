<div class="card-container">
    <div class="gradient-overlay">
        <div class="gradient-overlay-content">
            <h1>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quisquam, quidem.</h1>
            <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quisquam, quidem.</p>
        </div>
    </div>
</div>

<style lang="scss">
    .card-container{
        border-radius: 20px;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        height: 45vh;
        width: 90vw;
        position: relative;
        box-shadow: black 0px 0px 10px;

        .gradient-overlay{
            height: 100%;
            width: 100%;
            position: absolute;
            top: 0;
            left: 0;
            border-radius: 20px;
            background: linear-gradient(to bottom,rgba(209, 112, 112, 0.11),rgb(0, 0, 0) ),
            url(https://images.unsplash.com/photo-1518791841217-8f162f1e1131?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60);
            z-index: -1;
        }

        .gradient-overlay-content{
            position: absolute;
            bottom: 0;
            margin: 20px;

            h1{
                color:white;
            }

            p{
                color:white;
            }
        }
    }
</style>