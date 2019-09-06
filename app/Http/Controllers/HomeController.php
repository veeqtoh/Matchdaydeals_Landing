<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Session;
use Newsletter;

class HomeController extends Controller
{
    public function home(){
        return view('index');
    }

    public function subscribe(Request $request){

        $name = $request->name;
        $phone = $request->phone;
        $email = $request->email;

        Newsletter::subscribe($email, ['name'=>$name, 'phone'=>$phone]);
        Session::flash('subscribed', 'Successfully subscribed.');

        return redirect()->back();
    }
}
