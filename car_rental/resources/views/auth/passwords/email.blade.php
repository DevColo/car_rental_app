@extends('layouts.app')

@section('content')
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card">
                <!-- <div class="card-header">{{ __('Reset Password') }}</div> -->
                <div class="logo-lg" style=" text-align: center;">
                                    <a href="">
                                        <img src="{{asset('img/cdc-logo.jpg') }}" alt="" height="40" class="rounded-circle" style="position: relative;top: 16px;">
                                        <span class="logo-lg" style="position: relative;top: 9px;">
<p style="
    top:0px !important;
    position: relative;
    font-weight: bold;
    font-size: 15px;
    font-weight: bold;
    padding: 15px 0 0 0;
    color: #035594;
    margin-bottom: 0;">{{ __('Reset Password') }}</p>
                                      </span>
                                    </a>
                                </div>

                <div class="card-body p-4">
                    @if (session('status'))
                        <div class="alert alert-success" role="alert">
                            {{ session('status') }}
                        </div>
                    @endif

                    <form class="pt-2" method="POST" action="{{ route('password.email') }}">
                        @csrf

                        <div class="row mb-3">
                            <label for="email" class="col-md-4 col-form-label text-md-end">{{ __('Email Address') }}</label>

                            <div class="col-md-6">
                                <input id="email" type="email" placeholder="Enter your email" class="form-control @error('email') is-invalid @enderror" name="email" value="{{ old('email') }}" required autocomplete="email" autofocus>

                                @error('email')
                                    <span class="invalid-feedback" role="alert">
                                        <strong>{{ $message }}</strong>
                                    </span>
                                @enderror
                            </div>
                        </div>

                        <div class="row mb-0">
                            <div class="col-md-6 offset-md-4">
                                <button type="submit" class="btn btn-primary">
                                    {{ __('Send Password Reset Link') }}
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection
