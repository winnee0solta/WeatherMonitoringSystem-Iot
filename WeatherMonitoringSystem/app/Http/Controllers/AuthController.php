<?php

namespace App\Http\Controllers;


use App\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

class AuthController extends Controller
{
    public function loginView()
    {
        if (Auth::check()) {
            return redirect('/');
        }

        return view('auth.login');
    }

    public function createAdmin($username, $password)
    {

        if (User::where('username', $username)->count() == 0) {

            User::create([
                'username' => $username,
                'password' => bcrypt($password),
            ]);
            return Response(array(
                'message' => 'Created'
            ));
        } else {
            return Response(array(
                'message' => 'already exists'
            ));
        }
    }


    /**
     * Login User
     */
    public function loginUser(Request $request)
    {


        $this->validate($request, [
            'username' => 'required',
            'password' => 'required'
        ]);


        $user = User::where('username', $request->username)->first();
        if ($user) {

            if (Hash::check($request->password, $user->password)) {
                // The passwords match...
                //check if rehash needed
                if (Hash::needsRehash($user->password)) {
                    $user->password = Hash::make($request->password);
                    $user->save();
                }

                //Authenticate
                auth()->attempt([
                    'username' => request('username'),
                    'password' => request('password')
                ]);


                return redirect('/');
            }
            return back();
        }



        return redirect('/');
    }

    public function logout()
    {
        auth()->logout();
        return redirect('/login');
    }
}
