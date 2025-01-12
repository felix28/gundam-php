<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use App\Http\Resources\UserCollection;

class UserController extends Controller
{
    public function index() {
        return response()->json(new UserCollection(User::all()), 200, [], JSON_PRETTY_PRINT);
    }

    public function store(Request $request) {
        $user = new User();
        $user->name = $request->input('name');
        $user->email = $request->input('email');
        $user->password = bcrypt($request->input('password'));
        
        if ($user->save()) {
            return response()->json(
                [
                    'message' => 'User created successfully', 
                    'user' => $user
                ], 
                201
            );
        } else {
            return response()->json(
                [
                    'message' => 'An error occurred while creating the user'
                ], 
                500
            );
        }
    }
}
