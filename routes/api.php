<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\HelloWorldController;
use App\Http\Controllers\UserController;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

Route::get('/hello', [HelloWorldController::class, 'index']);
Route::get('/hi', [HelloWorldController::class, 'hi']);
Route::get('/test-db-connect', [HelloWorldController::class, 'testDBConnection']);

Route::prefix('pilots')->group(function () {
    Route::get('/', [UserController::class, 'index']);
    Route::post('/', [UserController::class, 'store']);
});