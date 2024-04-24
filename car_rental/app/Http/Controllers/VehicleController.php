<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Vehicle;
use App\Models\VehicleBooking;
use Validator;
use DB;
use Auth;
use PDF;

class VehicleController extends Controller
{
   /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('auth');
    }

    /**
     * Display the vehicle form.
     *
     * @return \Illuminate\Contracts\Support\Renderable
     */
    public function displayVehicleForm(){

        return view('vehicle.vehicle-form');
    }

    /**
     *  Method to add new vehicle
     */
    public function addNewVehicle(Request $request){
        $input = $request->all();

        //validating vehicle form
        $validateInput = Validator::make($input,[
            'vehicle_name' => 'required|string|max:30|unique:vehicle',
            'gear_type' => 'required|string|max:30',
            'seat_amount' => 'required|string|max:30',
            'price' => 'required|string|max:30',
            'brand' => 'required|string|max:30',
            'petro' => 'required|string|max:30',
            'description'  => 'required|string|max:100',
            'image' => 'required|mimes:jpg,png|max:2048',
        ]);

        if ($validateInput->fails()) {
            \Session::flash('msgErr','The form was not submitted, try again' );

            return redirect()->back()->withErrors($validateInput->errors())->withInput();
        }else{

            // upload photo
            $image = $request->file('image');
            if (empty($image)){
                $imageName='NO_PIC';
            }else{
                //$extension = pathinfo($image, PATHINFO_EXTENSION);
                $imageName = time().'.jpg';
                $image->move(public_path('images'), $imageName);
            }

            $formData = array(
                'vehicle_name' => $input['vehicle_name'],
                'gear_type' => $input['gear_type'],
                'seat_amount' => $input['seat_amount'],
                'price' => $input['price'],
                'brand' => $input['brand'],
                'petro' => $input['petro'],
                'description'  => $input['description'],
                'image' => $imageName,
                'admin_id' => Auth::user()->id,
                'status' => 1,
            );
            Vehicle::create($formData);
            \Session::flash('msg','User does not exist');
            return redirect()->back();
        }
    }

     /**
     *  Method to display vehicle list
     */
    public function displayVehicleList(){
        if(Auth::user()->hasRole('admin')) {
        if(request()->ajax()){
            return datatables()->of(Vehicle::latest()->get())
                    ->addColumn('action', function($data){
                        $viewUrl = url('view-vehicle/'.$data->id);
                        $button = '<a href="'.$viewUrl.'" target="_blank" title="View Vehicle" data-toggle="tooltip" data-original-title="Edit" class="edit btn-primary btn-sm"><i class="fa fa-eye" style="margin-bottom: 9px;"></i></a>';
                        $button .= '&nbsp;';
                        return $button;

                        })
                        ->addColumn('status', function($data){
                            if ($data->status == 1) {
                                $class = 'btn-success';
                                $status = 'Available';
                            }else{
                                $status='Unavailable';
                                $class = 'btn-primary';
                            }
                            $status_btn = '<a href="#" class="'.$class.' white-text delete btn-sm">'.$status.'</a>';
                            return  $status_btn;
                        })
                        ->rawColumns(['action','status'])
                        ->make(true);
            }
            return view('vehicle.vehicle-list');
        }
    }

     /**
     *  Method to display vehicle booking list
     */
    public function displayBookingList(){
        if(Auth::user()->hasRole('admin')) {
        if(request()->ajax()){
            return datatables()->of(VehicleBooking::latest()->get())
                    ->addColumn('action', function($data){
                        $viewUrl = url('view-vehicle/'.$data->id);
                        $button = '<a href="'.$viewUrl.'" target="_blank" title="View Vehicle" data-toggle="tooltip" data-original-title="Edit" class="edit btn-primary btn-sm"><i class="fa fa-eye" style="margin-bottom: 9px;"></i></a>';
                        $button .= '&nbsp;';
                        return $button;

                        })
                        ->addColumn('user', function($data){
                           $user = DB::table('users')->where('id',$data->user_id)->get();
                            $status_btn =  $user[0]->first_name.' '.$user[0]->last_name;
                            return  $status_btn;
                        })
                        ->addColumn('vehicle', function($data){
                            $vehicle = DB::table('vehicles')->where('id',$data->vehicle_id)->get();
                            $status_btn =  $vehicle[0]->vehicle_name;
                            return  $status_btn;
                        })
                        ->rawColumns(['action','user','vehicle'])
                        ->make(true);
            }
            return view('vehicle.booking-list');
        }
    }
}
