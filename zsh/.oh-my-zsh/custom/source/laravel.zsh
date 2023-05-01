
laravel-repository() {

    new_file=$@

    if [ -z "${new_file}" ]; then

        PATH_APP=$(fd -t d app$ -E storage)

        [ -z "$PATH_APP" ] && return

        mkdir -p $PATH_APP/{Repository,Providers}
    

        cp -r -u -v  $ZSH_CUSTOM/files/laravel/repository-template/Interfaces $PATH_APP/Repository
        cp -r -u -v  $ZSH_CUSTOM/files/laravel/repository-template/Eloquent $PATH_APP/Repository
        cp -r -u -v  $ZSH_CUSTOM/files/laravel/repository-template/RepositoryServiceProvider.php $PATH_APP/Providers


        PATH_PROVIDERS=$(fd app.php -E bootstrap)

        [ -z "$PATH_PROVIDERS" ] && return

        sed -e "s/  App\\\Providers\\\AppServiceProvider::class,/  App\\\Providers\\\AppServiceProvider::class, \n \ \  App\\\Providers\\\RepositoryServiceProvider::class,/g" $PATH_PROVIDERS

    fi

    echo $new_file
}
