<?php

namespace App\Providers;

use App\Repository\Interfaces\EloquentRepositoryI;
use App\Repository\Interfaces\UserRepositoryI;
use App\Repository\Eloquent\UserRepository;
use App\Repository\Eloquent\BaseRepository;
use Illuminate\Support\ServiceProvider;

class RepositoryServiceProvider extends ServiceProvider
{
    /**
     * Register services.
     *
     * @return void
     */
    public function register()
    {
        $this->app->bind(EloquentRepositoryI::class, BaseRepository::class);
        $this->app->bind(UserRepositoryI::class, UserRepository::class);
    }
}
