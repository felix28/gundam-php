<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\HelloWorldController;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

Route::get('/hello', [HelloWorldController::class, 'index']);
Route::get('/hi', [HelloWorldController::class, 'hi']);
Route::get('/test-db-connect', [HelloWorldController::class, 'testDBConnection']);