<?php

namespace App\Http\Controllers;

use App\Models\Appointments;
use App\Models\User;
use App\Models\Vehicle;
use App\Models\SavedFavorite;
use App\Models\UserDetails;
use Illuminate\Http\Request;
use Illuminate\Validation\ValidationException;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Auth;
use Twilio\Rest\Client;
use DB;
use Carbon\Carbon;

class UsersController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $user = array();
        $user = Auth::user();
        //$favorite = SavedFavorite::where('user_id', Auth::user()->id)->get();
        $favorite = DB::table('vehicles')->join('saved_favorite','saved_favorite.vehicle_id','vehicles.id')->where('saved_favorite.user_id', Auth::user()->id)->get();
        $vehicles = Vehicle::all();

        $user['vehicles'] = $vehicles;
        $user['favorite'] = $favorite;

        return $user;
    }

    /**
     * loign.
     *
     * @return \Illuminate\Http\Response
     */
    public function login(Request $reqeust)
    {
        //validate incoming inputs
        $reqeust->validate([
            'email'=>'required|email',
            'password'=>'required',
        ]);

        //check matching user
        $user = User::where('email', $reqeust->email)->first();

        //check password
        if(!$user || ! Hash::check($reqeust->password, $user->password)){
            // throw ValidationException::withMessages([
            //     'email'=>['The provided credentials are incorrect'],
            // ]);
            return null;//['error'=>'The provided credentials are incorrect'];
        }
        //then return generated token
        return $user->createToken($reqeust->email)->plainTextToken;
    }

    /**
     * register.
     *
     * @return \Illuminate\Http\Response
     */
    public function register(Request $request)
    {
        //validate incoming inputs
        $request->validate([
            'first_name'=>'required|string',
            'last_name'=>'required|string',
            'phone'=>'required|string|max:10',
            'email'=>'required|email|unique:users',
            'password'=>'required',
        ]);

        $user = User::create([
            'first_name'=>$request->first_name,
            'last_name'=>$request->last_name,
            'phone'=>$request->phone,
            'email'=>$request->email,
            'status'=>1,
            'password'=>Hash::make($request->password),
        ]);

        // assign user role
        $user->assignRole('user');

        $message = "Hi ".$request->first_name. ", you have successfully register to the car rental app.";

        // try {
        //     if (!empty($request->phone) && strlen($request->phone) == 10) {
        //         $account_sid = getenv("TWILIO_SID");
        //         $auth_token = getenv("TWILIO_TOKEN");
        //         //$twilio_number = getenv("TWILIO_FROM");
        //         $receiverNumber = '+25'.$request->phone;
      
        //         $client = new Client($account_sid, $auth_token);
        //         $client->messages->create($receiverNumber, [
        //             "messagingServiceSid" => "",
        //             'body' => $message]);
        //     }   
        // } catch (Exception $e) {
        //     dd("Error: ". $e->getMessage());
        // }

        return $user;


    }

    /**
     * Method to add favorite vehicle
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function addFavVehicle(Request $request){
        $fav = $request->get('vehicle_id');

        SavedFavorite::create([
            'vehicle_id' => $fav,
            'user_id' => Auth::user()->id
        ]);

        return response()->json([
            'success'=>'Favorite vehicle added',
        ], 200);
    }

    /**
     * Method to remove favorite vehicle
     */
    public function removeFavVehicle(Request $request){
        $fav = $request->get('vehicle_id');
        $favorite = SavedFavorite::findOrFail($fav);
        $favorite->delete();

        return response()->json([
            'success'=>'Favorite vehicle removed',
        ], 200);
    }

    /**
     * Method to diaplsy favorite vehicle list
     */
    public function getFavVehicle(){
        $result = [];
        $favorite = DB::table('vehicles')->join('saved_favorite','saved_favorite.vehicle_id','vehicles.id')->where('saved_favorite.user_id', Auth::user()->id)->get();

        if (!empty($favorite[0])) {
           $result['saved_favorite'] = $favorite;
        }

        return $result;
    }

    /**
     * Method to diaplsy favorite vehicle list
     */
    public function getBooking(){
        $result = [];
        $vehicle_booking = DB::table('vehicle_booking')->join('vehicles','vehicle_booking.vehicle_id','vehicles.id')->where('vehicle_booking.user_id', Auth::user()->id)->select('vehicle_booking.status','vehicle_booking.start_date','vehicle_booking.start_time','vehicle_booking.end_date','vehicle_booking.end_time','vehicle_booking.start_date','vehicles.vehicle_name','vehicles.price')->get();

        if (!empty($vehicle_booking[0])) {
            //$result['pending'] = $vehicle_booking;
            foreach ($vehicle_booking as $key => $value) {
                $start_date = str_replace('\\', '', $value->start_date);
                $end_date = str_replace('\\', '', $value->end_date);

                $startDate = strtotime(str_replace('/', '-', $start_date));
                $endDate = strtotime(str_replace('/', '-', $end_date));
                  
                $days = ($endDate - $startDate) / 86400;

                $price = $days* $value->price;

                $result[$value->status][] = [
                    'vehicle_name' => $value->vehicle_name,
                    'days' => strval($days),
                    'price' => strval($price),
                    'from' => $start_date.' '.$value->start_time,
                    'to' => $end_date.' '.$value->end_time,
                ];
                
            }
        }

        return $result;
    }


    /**
     * logout.
     *
     * @return \Illuminate\Http\Response
     */
    public function logout(){
        $user = Auth::user();
        $user->currentAccessToken()->delete();

        return response()->json([
            'success'=>'Logout successfully!',
        ], 200);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
}
