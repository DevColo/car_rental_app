<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <title>Car Rental| @yield('page_title')</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <!-- App favicon -->
         <link rel="shortcut icon" href="{{asset('img/cdc-logo.jpg') }}">

        @yield('css')
        <!-- jvectormap -->
        <link href="{{asset('assets/libs/jqvmap/jqvmap.min.css') }}" rel="stylesheet" />

        <!-- custom css -->
        <link href="{{asset('css/custom.css') }}" rel="stylesheet" />

        <!-- DataTables -->
        <link href="{{asset('assets/libs/datatables/dataTables.bootstrap4.min.css') }}" rel="stylesheet" type="text/css"/>
        <link href="{{asset('assets/libs/datatables/responsive.bootstrap4.min.css') }}" rel="stylesheet" type="text/css"/>

        <!-- App css -->
        <link href="{{asset('assets/css/bootstrap.min.css') }}" rel="stylesheet" type="text/css" />
        <link href="{{asset('assets/css/icons.min.css') }}" rel="stylesheet" type="text/css" />
        <link href="{{asset('assets/css/app.min.css') }}" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .help-block{
            color:#e80d0d !important;
        }
        #sidebar-menu>ul>li>a {
           color: #232323 !important;
        }
        .nav-second-level li a, .nav-thrid-level li a {
           padding: 8px 20px;
           color: #34363a !important;
        }
        .logo-lg>img,.logo-sm>img {
            background: #fff;
            padding: 3px;
        }

        .nav-second-level>li {
    border-bottom: 2px solid #f5f6f8 !important;
    border-right: 0 !important;
}
        span.red-text {
    color: red !important;
}
    </style>
    </head>
    <body>

        <!-- Begin page -->
        <div id="wrapper">

            <!-- Topbar Start -->
            <div class="navbar-custom" style="background-color: #a00 !important;">
                <ul class="list-unstyled topnav-menu float-right mb-0">

                    <li class="dropdown notification-list">
                        <a class="nav-link dropdown-toggle nav-user mr-0 waves-effect waves-light" data-toggle="dropdown" href="#" role="button" aria-haspopup="false" aria-expanded="false">
                            <img src="{{asset('images/avatar.jpeg')}}" alt="" class="rounded-circle">
                            <span class=" ml-1">
                                {{Auth::user()->first_name}}
                            </span>
                            <i class="mdi mdi-chevron-down"></i>
                        </a>
                        <div class="dropdown-menu dropdown-menu-right profile-dropdown ">

                            <div class="dropdown-item noti-title">
                                <h6 class="m-0">
                                    Welcome !
                                </h6>
                            </div>

                            <!-- item-->
                            <a href="{{ URL::to('user-profile/'.Auth::user()->id) }}" class="dropdown-item notify-item">
                                <i class="dripicons-user"></i>
                                <span>My Account</span>
                            </a>

                            <div class="dropdown-divider"></div>

                            <!-- item-->
                             <a class="dropdown-item notify-item" href="{{ route('logout') }}"
                                            onclick="event.preventDefault();
                                                     document.getElementById('logout-form').submit();">
                                    <i class="dripicons-power"></i>
                                    <span>Logout</span>
                                </a>
                                <form id="logout-form" action="{{ route('logout') }}" method="POST" style="display: none;">
                                            {{ csrf_field() }}
                                        </form>

                        </div>
                    </li>

                </ul>

                <ul class="list-unstyled menu-left mb-0">
                    <li class="float-left">
                        <a href="{{URL::to('home/')}}" class="logo">
                            <span class="logo-lg">
                                 <!-- <img src="" alt="" height="40" class="rounded-circle"> -->
<p style="color:#fff;top:20px !important;position:relative;font-weight:bold;">MIGHTY CAR RENTAL</p>
                            </span>
                        </a>
                    </li>
                    <li class="float-left">
                        <a class="button-menu-mobile navbar-toggle">
                            <div class="lines">
                                <span></span>
                                <span></span>
                                <span></span>
                            </div>
                        </a>
                    </li>
                </ul>
            </div>
            <!-- end Topbar -->

            <!-- ========== Left Sidebar Start ========== -->
            <div class="left-side-menu" style="background: #ffffff !important;">

                <div class="slimscroll-menu">

                    <!--- Sidemenu -->
                    <div id="sidebar-menu">

                        <ul class="metismenu" id="side-menu">

                            <li class="menu-title">Navigation</li>

                            <li>
                                <a href="{{URL::to('home/')}}">
                                    <i class="dripicons-home"></i>
                                    <span> Dashboard </span>
                                </a>
                            </li>

                        @hasrole('admin')


                            <li>
                                <a href="javascript: void(0);">
                                    <i class="dripicons-meter"></i>
                                    <span>Manage Vehicles</span>
                                    <span class="menu-arrow"></span>
                                </a>
                                <ul class="nav-second-level" aria-expanded="false">
                                    <li>
                                        <a href="{{ route('add-new-vehicle') }}">Add New Vehicle</a>
                                    </li>
                                    <li>
                                        <a href="{{ route('vehicle-list') }}">View Car List</a>
                                    </li>
                                </ul>
                            </li>
                            <li>
                                <a href="javascript: void(0);">
                                    <i class="dripicons-calendar"></i>
                                    <span> Manage Reservation</span>
                                    <span class="menu-arrow"></span>
                                </a>
                                <ul class="nav-second-level" aria-expanded="false">
                                    <li style="border-top: 2px solid #f5f6f8 !important;">
                                        <a href="{{ route('booking-list') }}">Veiw Booking Request</a>
                                    </li>
                                </ul>
                            </li>
                        @endrole


                        </ul>

                    </div>
                    <!-- End Sidebar -->

                    <div class="clearfix"></div>

                </div>
                <!-- Sidebar -left -->

            </div>
            <!-- Left Sidebar End -->

            <!-- ============================================================== -->
            <!-- Start Page Content here -->
            <!-- ============================================================== -->

            <div class="content-page">
                <div class="content">

                    <!-- Start Content-->
                    <div class="container-fluid">
                        <!-- start page title -->
                        <div class="row">
                            <div class="col-12">
                                <div class="page-title-box">

                                    <h4 class="page-title">@yield('title')</h4>
                                </div>
                            </div>
                        </div>
                        <!-- end page title -->
                         @if(Session::has('msg'))
                                     <div class="alert alert-info">
                                    <a class="close" data-dismiss="alert">×</a>
                                    <strong>Success!</strong> {!!Session::get('msg')!!}
                                     </div>
                                      @endif

                                       @if(Session::has('msgErr'))
                                     <div class="alert alert-danger">
                                    <a class="close" data-dismiss="alert">×</a>
                                    <strong>Oops!</strong> {!!Session::get('msgErr')!!}
                                     </div>

                                     @endif

                        @yield('content')

                    </div> <!-- container -->

                </div> <!-- content -->
            </div>

            <!-- ============================================================== -->
            <!-- End Page content -->
            <!-- ============================================================== -->


        </div>
        <!-- END wrapper -->

        <!-- Right Sidebar -->

        <!-- /Right-bar -->

        <!-- Right bar overlay-->
        <div class="rightbar-overlay"></div>

        @yield('script')

        <!-- Vendor js -->
        <script src="{{asset('assets/js/vendor.min.js') }}"></script>

                <!-- Modal-Effect -->
        <script src="{{ asset('assets/libs/custombox/custombox.min.js') }}"></script>

        <!-- KNOB JS -->
        <script src="{{asset('assets/libs/jquery-knob/jquery.knob.min.js') }}"></script>
        <!-- Chart JS -->
        <script src="{{asset('assets/libs/chart-js/Chart.bundle.min.js') }}"></script>

        <!-- Jvector map -->
        <script src="{{asset('assets/libs/jqvmap/jquery.vmap.min.js') }}"></script>
        <script src="{{asset('assets/libs/jqvmap/jquery.vmap.usa.js') }}"></script>

        <!-- Datatable js -->
        <script src="{{asset('assets/libs/datatables/jquery.dataTables.min.js') }}"></script>
        <script src="{{asset('assets/libs/datatables/dataTables.bootstrap4.min.js') }}"></script>
        <script src="{{asset('assets/libs/datatables/dataTables.responsive.min.js') }}"></script>
        <script src="{{asset('assets/libs/datatables/responsive.bootstrap4.min.js') }}"></script>


        <!-- Dashboard Init JS -->
        <script src="{{asset('assets/js/pages/dashboard.init.js') }}"></script>

        <!-- App js -->
        <script src="{{asset('assets/js/app.min.js') }}"></script>
<script src="{{asset('assets/libs/bootstrap-datepicker/bootstrap-datepicker.min.js') }}"></script>
    </body>
</html>
