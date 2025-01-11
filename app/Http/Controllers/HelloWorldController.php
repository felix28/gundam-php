<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Schema;
use Illuminate\Http\JsonResponse;

class HelloWorldController extends Controller
{
    /**
     * Returns a Hello World JSON response.
     *
     * @return JsonResponse
     */
    public function index(): JsonResponse
    {
        return response()->json(['message' => 'Hello co-pilots!']);
    }
    
    public function hi(): JsonResponse
    {
        return response()->json(['message' => 'Hi!']);
    }

    public function testDBConnection(): JsonResponse
    {
        try {
             
            $tables = Schema::getTables();
            return response()->json(['success' => $tables]);
        } catch (Exception $e) {
            return response()->json(['error' => $e->getMessage()]);
        }
    }

}
