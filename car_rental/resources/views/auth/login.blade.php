<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <title>Car Rental App | Login</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta content="Coderthemes" name="author" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <!-- App favicon -->
        <link rel="shortcut icon" href="{{asset('img/cdc-logo.jpg') }}">

        <!-- App css -->
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/icons.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/app.min.css" rel="stylesheet" type="text/css" />
    
        <style type="text/css">
            .help-block{
            color:#e80d0d !important;
        }
            .btn-success {
                background-color: #327d53;
                border-color: #327d53;
}
.btn-success:hover {
    /*color: #fff;
    background-color: #3765f9 !important;
    border-color: #3765f9 !important;*/
}
        </style>

    </head>

    <body class="authentication-bg d-flex align-items-center" style="background:url({{asset('img/18.jpeg') }});background-repeat: no-repeat;
background-size: contain;">

        <div class="home-btn d-none d-sm-block">
        </div>
        
        <div class="account-pages w-100 mt-5 mb-5">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-md-8 col-lg-6 col-xl-5">
                        <div class="card" style="box-shadow: 0 3px 13px -2px #bfb7b7 !important">
                        <div class="logo-lg" style=" text-align: center;">
                                    <a href="">
                                        <img src="{{asset('img/cdc-logo.jpg') }}" alt="" height="40" class="rounded-circle" style="position: relative;top: 16px;">
                                        <span class="logo-lg" style="position: relative;top: 9px;">
<p style="
    top:0px !important;
    position: relative;
    font-weight: bold;
    font-size: 15px;
    font-weight: bold;
    padding: 15px 0 0 0;
    color: #035594;
    margin-bottom: 0;">MIGHTY CAR RENTAL</p>
                                      </span>
                                    </a>
                                </div>
                            <div class="card-body p-4">
                                
                                <form class="pt-2" method="POST" action="{{ route('login') }}">
                        {{ csrf_field() }}

                                    <div class="form-group{{ $errors->has('email') ? ' has-error' : '' }} mb-3">
                                        @if ($errors->has('email'))
                                    <span class="help-block">
                                        <strong>{{ $errors->first('email') }}</strong>
                                    </span>
                                @endif
                                        <label for="emailaddress">Email address</label>
                                        <input class="form-control" type="email" id="emailaddress" placeholder="Enter your email" name="email" value="{{ old('email') }}" required autofocus>
                                         
                                    </div>

                                    <div class="form-group{{ $errors->has('password') ? ' has-error' : '' }} mb-3">
                                        <label for="password">Password</label>
                                        <input class="form-control" type="password"  id="password" placeholder="Enter your password" name="password" required autofocus>
                                        <a href="{{ route('password.request') }}" class=" float-right"><p>Forgot your password?</p></a>
                                         @if ($errors->has('password'))
                                    <span class="help-block">
                                        <strong>{{ $errors->first('password') }}</strong>
                                    </span>
                                @endif
                                    </div>

                                    <!-- <div class="custom-control custom-checkbox mb-3">
                                        <input type="checkbox" class="custom-control-input" id="checkbox-signin" name="remember" value="{{ old('remember') ? 'checked' : '' }}">
                                        <label class="custom-control-label" for="checkbox-signin">Remember me</label>
                                    </div>
 -->
                                    <div class="form-group mb-0 text-center">
                                        <button class="btn btn-block" type="submit" style="background-color: #035594;border-color: #044b82;"> Log In </button>
                                    </div>

                                </form>

                                <!-- <div class="row mt-3">
                                    <div class="col-12 text-center">
                                        <p class="text-muted mb-0">Don't have an account? <a href="{{ route('register') }}" class="text-dark ml-1"><b>Sign Up</b></a></p>
                                    </div>
                                </div> -->
                                <!-- end row -->

                            </div> <!-- end card-body -->
                        </div>
                        <!-- end card -->

                    </div> <!-- end col -->
                </div>
                <!-- end row -->
            </div>
            <!-- end container -->
        </div>
        <!-- end page -->
        

        <!-- Vendor js -->
        <script src="assets/js/vendor.min.js"></script>

        <!-- App js -->
        <script src="assets/js/app.min.js"></script>
    </body>
</html>

