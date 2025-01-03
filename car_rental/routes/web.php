<?php

use App\Http\Controllers\ProfileController;
use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/


Route::get('/dashboard', function () {
    return Inertia::render('Dashboard');
})->middleware(['auth', 'verified'])->name('dashboard');

Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});

require __DIR__.'/auth.php';

Route::get('/', function () {
    return view('auth.login');
});

Auth::routes();

Route::get('/home', [App\Http\Controllers\HomeController::class, 'index'])->name('home');
Route::get('/add-new-vehicle', [App\Http\Controllers\VehicleController::class, 'displayVehicleForm'])->name('add-new-vehicle');
Route::post('/addVehicle', [App\Http\Controllers\VehicleController::class, 'addNewVehicle'])->name('addVehicle');
Route::get('/vehicle-list', [App\Http\Controllers\VehicleController::class, 'displayVehicleList'])->name('vehicle-list');
Route::get('/booking-list', [App\Http\Controllers\VehicleController::class, 'displayBookingList'])->name('booking-list');
