<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Gym Management</title>

    <!-- CSS -->
    <!-- Add Material font (Roboto) and Material icon as needed -->
    <link
        href="https://fonts.googleapis.com/css?family=Roboto:300,300i,400,400i,500,500i,700,700i|Roboto+Mono:300,400,700|Roboto+Slab:300,400,700"
        rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

    <link rel="stylesheet" href="{{asset('/css/app.css')}}">
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="{{asset('/js/app.js')}}"></script>
</head>

<body>

    {{-- <div class="login-container  " style="background: url(/images/bg_1.png);"> --}}
    <div class="login-container  " >

        <div class="container">
            <div class="row justify-content-center pt-lg-5">
                <div class="col-12 col-md-5 mt-lg-5">
                    <div class="card mt-5 bg-login-card">
                        <div class="card-body">
                            <h4 class="card-title text-center text-white  font-weight-bold mt-3 text-uppercase">Log in
                                to system.
                            </h4>

                            <div class="mb-5 mt-4">
                                <form action="/login" method="POST">
                                    @csrf
                                    <div class="form-group">
                                        <label for="exampleInputEmail1" class="text-white">Username</label>
                                        <input name="username" type="text" class="form-control text-white"
                                            id="exampleInputEmail1" aria-describedby="emailHelp"
                                            placeholder="Enter username">

                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputPassword1" class="text-white">Password</label>
                                        <input name="password" type="password" class="form-control"
                                            id="exampleInputPassword1" placeholder="Enter password">
                                    </div>
                                    <div class="text-center">
                                        <button type="submit" class="btn  btn-login mt-3 text-white"
                                            style="width: 100%;">Login</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>



    </div>


    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->

    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>


</body>

</html>
