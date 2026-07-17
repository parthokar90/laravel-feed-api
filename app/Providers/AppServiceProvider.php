<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\File;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        $interfacePath = app_path('Repositories/Interfaces');

        if (File::exists($interfacePath)) {
            $files = File::files($interfacePath);

            foreach ($files as $file) {
                $interfaceName = $file->getFilenameWithoutExtension();

                $repositoryName = Str::replaceLast('Interface', '', $interfaceName);

                $interfaceNamespace = "App\\Repositories\\Interfaces\\{$interfaceName}";
                $repositoryNamespace = "App\\Repositories\\Eloquent\\{$repositoryName}";

                if (class_exists($repositoryNamespace)) {
                    $this->app->bind($interfaceNamespace, $repositoryNamespace);
                }
            }
        }
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        error_reporting(E_ALL & ~E_NOTICE & ~E_DEPRECATED);
    }
}
