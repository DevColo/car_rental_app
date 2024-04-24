@extends('layouts.default')
@section('page_title')
Add New Vehicle
@endsection('page_title')
@section('title')
Add New Vehicle
@endsection('title')
@section('content')
<script src="{!! asset('jquery-3.4.1.js') !!}"></script> 
<div class="row">
    <div class="col-12">
        <div class="card-box">
            <form action="{{ route('addVehicle') }}" method="post" enctype="multipart/form-data">
                                                {{csrf_field()}}
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                                <label>Vehicle Name <span class="red-text">*</span></label>
                                <input type="text" class="form-control" name="vehicle_name" placeholder="Enter Vehicle Name" value="{{ old('vehicle_name') }}" required>
                                @if ($errors->has('vehicle_name'))
                                    <span class="help-block">
                                        <strong>{{ $errors->first('vehicle_name') }}</strong>
                                    </span>
                                @endif
                        </div>
                        <div class="form-group">
                            <label>Gear Type <span class="red-text">*</span></label>
                            <select class="form-control" name="gear_type" required>
                                <option value="{{ old('gear_type') }}">@if(old('gear_type')) {{ old('gear_type') }} @else Select Gear Type @endif</option>
                                <option value="Automatic">Automatic</option>
                                <option value="Standard">Standard</option>
                                
                            </select>
                            @if ($errors->has('gear_type'))
                                <span class="help-block">
                                    <strong>{{ $errors->first('gear_type') }}</strong>
                                </span>
                            @endif
                        </div>

                         <div class="form-group">
                                <label>Amount of Seats <span class="red-text">*</span></label>
                                <input type="text" class="form-control" id="seat_amount" name="seat_amount" placeholder="Enter Amount of Seats" value="{{ old('seat_amount') }}" required>
                                @if ($errors->has('seat_amount'))
                                    <span class="help-block">
                                        <strong>{{ $errors->first('seat_amount') }}</strong>
                                    </span>
                                @endif
                        </div>

                        <div class="form-group">
                                <label>Price per hour <span class="red-text">*</span></label>
                                <input type="text" class="form-control" id="price" name="price" placeholder="Enter Amount of Seats" value="{{ old('price') }}" required>
                                @if ($errors->has('price'))
                                    <span class="help-block">
                                        <strong>{{ $errors->first('price') }}</strong>
                                    </span>
                                @endif
                        </div>
                    </div> <!-- end col -->

                    <div class="col-md-6 mt-4 mt-md-0">
                        <div class="form-group">
                            <label>Brand <span class="red-text">*</span></label>
                            <select class="form-control" name="brand" required>
                                <option value="{{ old('brand') }}">@if(old('brand')) {{ old('brand') }} @else Select Brand @endif</option>
                                <option value="Benz">Benz</option>
                                <option value="Ford">Ford</option>
                                <option value="Farari">Farari</option>
                                <option value="BMW">BMW</option>
                                <option value="Range Rover">Range Rover</option>
                                <option value="Bugatti">Bugatti</option>
                                <option value="Pathfinder">Pathfinder</option>
                            </select>
                            @if ($errors->has('brand'))
                                <span class="help-block">
                                    <strong>{{ $errors->first('brand') }}</strong>
                                </span>
                            @endif
                        </div>

                        <div class="form-group">
                            <label>Petro Type <span class="red-text">*</span></label>
                            <select class="form-control" name="petro" required>
                                <option value="{{ old('petro') }}">@if(old('petro')) {{ old('petro') }} @else Select Petro Type @endif</option>
                                <option value="Gasoline">Gasoline</option>
                                <option value="Fuel">Fuel</option>
                                <option value="Electric">Electric</option>
                            </select>
                            @if ($errors->has('petro'))
                                <span class="help-block">
                                    <strong>{{ $errors->first('petro') }}</strong>
                                </span>
                            @endif
                        </div>

                        <div class="form-group">
                            <label>Vehicle Description <span class="red-text">*</span></label>
                            <textarea name="description" class="form-control" required></textarea>
                                @if ($errors->has('description'))
                                    <span class="help-block">
                                        <strong>{{ $errors->first('description') }}</strong>
                                    </span>
                                @endif
                        </div>

                        <div class="form-group">
                            <label>Upload Vehicle Photo <span class="red-text">*</span></label>
                            <input type="file" class="form-control" accept="image/*" name="image" value="{{ old('image') }}" required>
                            @if ($errors->has('image'))
                                <span class="help-block">
                                    <strong>{{ $errors->first('image') }}</strong>
                                </span>
                            @endif
                        </div>
                        <div class="form-group">
        <button type="submit" class="btn form-control waves-effect waves-light width-md" style="background-color: #035594;border-color: #044b82;">Register</button>
    </div>

                                            
                    </div> <!-- end col -->
                </div>
</form>
                                </div> <!-- end card-box -->
                            </div> <!-- end col -->
                        </div>
                        <!-- Default checked -->

@endsection('content')

@section('script')
<script type="text/javascript">
$(document).ready(function () {
    $('#price').on('input', function() {
        let enteredValue = $(this).val();
        enteredValue = enteredValue.replace(/[^0-9.]/g, '');

        let decimalCount = (enteredValue.match(/\./g) || []).length;
        if (decimalCount > 1) {
            enteredValue = enteredValue.slice(0, enteredValue.lastIndexOf('.'));
        }
        $(this).val(enteredValue);
    });
    $("#seat_amount").on("input", function() {
      var inputValue = $(this).val();
      var numbersOnly = inputValue.replace(/[^0-9]/g, '');
      $(this).val(numbersOnly);
    });
});
</script>
@endsection('script')