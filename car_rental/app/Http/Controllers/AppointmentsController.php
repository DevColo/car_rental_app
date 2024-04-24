<?php

namespace App\Http\Controllers;

use App\Models\Appointments;
use App\Models\VehicleBooking;
use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Twilio\Rest\Client;


class AppointmentsController extends Controller
{

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
        
        //this controller is to store booking details post from mobile app
        $appointment = new VehicleBooking();
        $appointment->user_id = Auth::user()->id;
        $appointment->start_date = $request->get('start_date');
        $appointment->start_time = $request->get('start_time');
        $appointment->end_date = $request->get('end_date');
        $appointment->end_time = $request->get('end_time');
        $appointment->vehicle_id = $request->get('vehicle_id');
        $appointment->status = 'pending';
        $appointment->save();

        $message = "Hi ".Auth::user()->first_name. ", you have successfully sent a booking request.";

        // try {
        //     if (!empty(Auth::user()->phone) && strlen(Auth::user()->phone) == 10) {
        //         $account_sid = getenv("TWILIO_SID");
        //         $auth_token = getenv("TWILIO_TOKEN");
        //         //$twilio_number = getenv("TWILIO_FROM");
        //         $receiverNumber = '+25'.Auth::user()->phone;
      
        //         $client = new Client($account_sid, $auth_token);
        //         $client->messages->create($receiverNumber, [
        //             "messagingServiceSid" => "",
        //             'body' => $message]);
        //     }   
        // } catch (Exception $e) {
        //     dd("Error: ". $e->getMessage());
        // }

        //if successfully, return status code 200
        return response()->json([
            'success'=>'New Booking has been made successfully!',
        ], 200);

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
