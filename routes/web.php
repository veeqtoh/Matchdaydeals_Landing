<?php

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

Route::get('/', function () {
    return view('index');
});

Route::post('/subscribe', function  (){
    $name = $request('name');
    $phone = $request('phone');
    $email = $request('email');

    Newsletter::subscribe($email);
    Session::flash('subscribed', 'Successfully subscribed.');

    return redirect()->back();
});
