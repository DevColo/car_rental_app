@extends('layouts.default')
@section('page_title')
Vehicle List
@endsection('page_title')
@section('title')
Vehicle List
@endsection('title')
@section('content')
<style type="text/css">
    .btn-group-sm>.btn, .btn-sm {
    padding: 3px 6px;
    font-size: .7875rem;
    line-height: 1.5;
    border-radius: .15rem;
}
    table.dataTable tbody th, table.dataTable tbody td {
    padding: 8px 8px !important;
}
</style>
<script src="{!! asset('jquery-3.4.1.js') !!}"></script> 

<!-- <link href="{!! asset('bootstrap.min.css') !!}" rel="stylesheet"> -->

<link  href="{!! asset('jquery.dataTables.min.css') !!}" rel="stylesheet">

<script src="{!! asset('jquery.dataTables.min.js') !!}"></script>

<script src="{!! asset('jquery.validate.js') !!}"></script>

<script src="{!! asset('bootstrap.min.js') !!}"></script>
   
 <div class="container-fluid">
 <div class="row">
                    <!-- <div class="col-md-12">
                        <div class="dt-buttons">
                            <a class="dt-button buttons-print btn dark btn-outline" style="background-color: #035594;" tabindex="0" aria-controls="sample_1" href="{{route('add-new-vehicle')}}">
                                <span><i class="fa fa-plus"></i> Add New Vehicle</span>
                            </a>
                        </div>
                    </div> -->
                </div><br>
    
    <table class="table table-bordered table-responsive" id="vehicle_table" width="100%" style="display:table;">
           <thead>
            <tr>
                     <th>ID</th>
                     <th>User</th>
                     <th>Vehicle</th>
                     <th>Sart Date</th>
                     <th>Sart Time</th>
                     <th>End Date</th>
                     <th>End Time</th>
                     <th>Status</th>
                     <th>Action</th>  
            </tr>
           </thead>
       </table>
   </div>

<script>
$(document).ready(function(){     
    
 $('#vehicle_table').DataTable({
  processing: true,
  serverSide: true,
  ajax:{
   url: "{{ URL::to('/booking-list') }}",
  },
  columns:[
   // {
   //  data: 'image',
   //  name: 'image',
   //  render: function (data, type, full, meta) {
   //      return "<img src=\"{{asset('images/')}}\\" + data + "\" height=\"50\"/>";
   //  },
   // },
   {
    data: 'id',
    name: 'id'
   },
   {
    data: 'user',
    name: 'user'
   },
   {
    data: 'vehicle',
    name: 'vehicle'
   },
   {
    data: 'start_date',
    name: 'start_date'
   },
   {
    data: 'start_time',
    name: 'start_time'
   },
   {
    data: 'end_date',
    name: 'end_date'
   },
   {
    data: 'end_time',
    name: 'end_time'
   },
   {
    data: 'status',
    name: 'status',
   },
   {
    data: 'action',
    name: 'action',
    orderable: false
   }
  ]
 });

});
</script>
 @endsection('content')