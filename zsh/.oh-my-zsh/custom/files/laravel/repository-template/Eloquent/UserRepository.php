<?php

namespace App\Repository\Eloquent;

use App\Models\User;
use App\Repository\Eloquent\BaseRepository;
use App\Repository\Interfaces\UserRepositoryI;

class UserRepository extends BaseRepository implements UserRepositoryI
{
    public function __construct(User $model)
    {
        parent::__construct($model);
    }
}
