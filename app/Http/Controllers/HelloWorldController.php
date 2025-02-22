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
        return response()->json(['message' => 'Hello mobile suit co-pilots!']);
    }
    
    public function hi(): JsonResponse
    {
        return response()->json(['info' => 'Welcome Amuro Ray!']);
    }

    public function testDBConnection(): JsonResponse
    {
        try {
            $tables = Schema::getTables();
            
            return response()->json(['tables' => $tables]);
        } catch (Exception $e) {
            return response()->json(['error' => $e->getMessage()]);
        }
    }

}
