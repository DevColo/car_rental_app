@extends('layouts.default')
@section('title')
Dashboard
@endsection('title')
@section('content')
@section('css')
<style type="text/css">
    .col-md-3>p {
    line-height: 0.8 !important;
    width: auto;
    margin: 9px 0 0 10px;
    }
    .col-md-3{
        display: inline-flex;
        padding-left: 38px !important;
    }
    .nav-user img {
        width: auto !important;
    }
    .gradient-blue {
    background-image: linear-gradient(15deg,rgb(24 85 148) 0,#31b1ce 100%);
    }
    .gradient-red {
    background-image: linear-gradient(15deg,rgb(148 24 24) 0,#ce3176 100%);
    }
    .gradient-green {
    background-image: linear-gradient(15deg,rgb(2 84 4) 0,#87ce31 100%);
    }
    a.canvasjs-chart-credit {
    display: none;
}
.cover-canvas {
    width: 79px;
    height: 22px;
    background: white;
    display: block;
    top: -20px;
    left: -3px;
    position: relative;
}
.col-md-2 a.nav-user.mr-0{
    color: #000 !important;
}
</style>
@endsection('css')
<div class="row">


    @hasrole('admin')
    <div class="col-xl-3">
        <div class="card-box widget-chart-one gradient-blue bx-shadow-lg">
            <div class="float-left" dir="ltr">
                <div style="display:inline;width:80px;height:80px;">
                    <p class="text-white mb-0 mt-2">Total Users</p>
                </div>
            </div>
            <div class="widget-chart-one-content text-right">
                
                <h3 class="text-white">{{$user_count}}</h3>
            </div>
        </div> <!-- end card-box-->
    </div> <!-- end col -->

    <div class="col-xl-3">
        <div class="card-box widget-chart-one gradient-red bx-shadow-lg">
            <div class="float-left" dir="ltr">
                <div style="display:inline;width:80px;height:80px;">
                    <p class="text-white mb-0 mt-2">Admins</p>
                </div>
            </div>
            <div class="widget-chart-one-content text-right">
                
            <h3 class="text-white">{{$admin_count}}</h3>
            </div>
        </div> <!-- end card-box-->
    </div> <!-- end col -->

    <div class="col-xl-3">
        <div class="card-box widget-chart-one gradient-green bx-shadow-lg">
            <div class="float-left" dir="ltr">
                <div style="display:inline;width:80px;height:80px;">
                    <p class="text-white mb-0 mt-2">Total Vehicles</p>
                </div>
            </div>
            <div class="widget-chart-one-content text-right">
                
            <h3 class="text-white">{{$vehicle_count}}</h3>
            </div>
        </div> <!-- end card-box-->
    </div> <!-- end col -->

</div>

        </div>
    </div>
</div>

        @endrole

        
       
    </div>  <!-- end card-box-->
    </div>
@endsection('content')