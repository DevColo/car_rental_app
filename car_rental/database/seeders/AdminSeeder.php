<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\User;
use Spatie\Permission\Models\Role;

class AdminSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $user = User::create([
        'first_name' => 'First name ...',
        'last_name' => 'last name ....',
        'phone'   => 'phone....',
        'email' => 'email here....',
        'password' => 'Encrypted password ....',
        'status' => '1'
        ]);

        $user->assignRole('admin');
    }
}
