<?php

use Illuminate\Foundation\Testing\RefreshDatabase;
 
uses(RefreshDatabase::class);

use App\Models\User;

test('Register new mobile suit pilot', function () {
    $input = [
        'name' => 'Setsuna F. Seiei', 
        'email' => 'setsuna@gundam00.com', 
        'password' => '123456',
    ];

    $this->assertDatabaseEmpty('users');

    $response = $this->postJson('/api/pilots', $input);

    $this->assertDatabaseCount('users', 1);

    $response->assertStatus(201)->assertCreated();

    $this->assertDatabaseHas('users', [
        'email' => $input['email'],
        'name' => $input['name'],
    ]);
});

test('Show all mobile suit pilots', function () {
    $this->assertDatabaseEmpty('users');

    $pilots = User::factory()->count(5)->create();

    $jsonStructure = [
        'data' => [
            [
                'id', 
                'name', 
                'email',
                'created_at',
                'updated_at',
            ]
        ]
    ];

    $response = $this->getJson('/api/pilots');

    $response->assertStatus(200)->assertJsonStructure($jsonStructure);

    $this->assertDatabaseCount('users', 5);
});