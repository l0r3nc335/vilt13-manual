# DELETE DISTRO
	wsl --unregister <DistroName>

# SHOW DISTRO ONLINE
	wsl --list --online

# INSTALL DISTRO
	wsl --install -d <DISTRO>

# INSTALL PHP STANDALONE, NON-HERD OR LARAVEL PATH
	sudo apt install php8.5-cli

# FIND PHP.INI CONFIGURATION FILE
	php -i | grep "php.ini"

# OPEN PHP.INI
	sudo nano /etc/php/8.5/cli/php.ini

# ENABLE KNOWN EXTENSIONS
	[
		extension=curl, 
		extension=mbstring, 
		extension=oepnssl, 
		extension=pdo_mysql/pdo_pgsql
	]

# INSTALL THE EXTENSIONS
	sudo apt update
	sudo apt install -y phpX.X-mysql phpX.X-curl phpX.X-mbstring

	return the ;extension=curl if there is an error upon php-v

# INSTALL COMPOSER
```sh
sudo apt update
sudo apt install -y composer
```

# INSTALL LARAVEl INSTALLER (X)
```sh 
composer global require laravel/installer
```

# NEW PROJECT VIA LARAVEl CLI (X)
# cli guided setup (X)
```sh
laravel new laravel13-vilt
```

# NEW PROJECT VIA COMPOSER

```sh 
composer create-project laravel/laravel vilt13-manual
```

# FIX ISSUE WITH In ZipDownloader.php
```sh
sudo apt update && sudo apt install unzip php-zip -y
```

# COMPOSER INSTALL
```sh 
composer install
```

# START LARAVEL LOCAL DEVELOPMENT
```sh
npm install && npm run build
composer run dev
```

# ISSUE WITH EXTENSIONS
```sh 
sudo apt update
sudo apt install -y php8.5-xml
```

# APP GENERATE KEY
```sh
php artisan key:generate
```

# ISSUE WITH DATABASE CONNECTION
    - fix in .env

# MIGRATE FOR THE FIRST TIME
```sh 
php artisan migrate
```

# VITE MANUAL CONFIGURATION
    http://inertiajs.com/docs/v3/installation/server-side-setup
# VUE PLUGIN FOR VITE

```sh
npm install --save-dev @vitejs/plugin-vue
```
    -will install "@vitejs/plugin-vue": "^6.0.7", to package.json


# UPDATE vite.config.js
    - import vue from '@vitejs/plugin-vue';
    - THEN REGISTER THE  vue({}}

# INSTALL INERTIA LARAVEL PACKAGE
# SERVER SIDE SETUP
    -https://inertiajs.com/docs/v3/installation/server-side-setup
```sh 
composer require inertiajs/inertia-laravel
```

# ROOT TEMPLATE SETUP
    RENAME  - resources/views/welcome.blade.php
    TO      - resources/views/app.blade.php
    CODE IN - resources/views/app.blade.php 

# PHP INERTIA MIDDLEWARE
```sh 
php artisan inertia:middleware
```

# bootstrap/app.php
    - This will enable laravel to pass data to vue
```php
    use App\Http\Middleware\HandleInertiaRequests;

    ->withMiddleware(function (Middleware $middleware) {
        $middleware->web(append: [
            HandleInertiaRequests::class,
        ]);
    })
```

# CLIENT SIDE SETUP
    - https://inertiajs.com/docs/v3/installation/client-side-setup

# VUE PREREQUISITE
```sh 
npm install vue @vitejs/plugin-vue
```

# INITIALIZE INERTIA APP
    resources/js/app.js
```js
import { defineConfig } from 'vite'
import laravel from 'laravel-vite-plugin'
import vue from '@vitejs/plugin-vue'

export default defineConfig({
    plugins: [
        laravel({
            input: ['resources/js/app.js'],
            refresh: true,
        }),
        vue(),
    ],
})
```
# RUN VILT SETUP
    -run in 2 separate terminals
```sh 
php artisan serve
```
```sh 
npm run dev
```

# SETUP PAGES
    create - resources/pages/Index/Index.vue

# SETUP ROUTES
    routes/web.php

# DATA ACCESS PATTERN ========================
# Controller → Model (Small applications)
```php
class UserController extends Controller
{
    public function index()
    {
        $users = User::all();
        $user = User::find(1);
        $users = User::where('status', 'active')->get();
    }
}
```
# Controller → Service → Mode (professional projects)
```php
// CONTROLLER
class UserController extends Controller
{
    public function __construct(
        protected UserService $userService
    ) {}

    public function index()
    {
        return $this->userService->getActiveUsers();
    }
}
// SERVICE
class UserService
{
    public function getActiveUsers()
    {
        return User::where('status', 'active')->get();
    }
}
```

# Controller → Service → Repository → Model (large enterprise projects) **Preferred
```php
// CONTROLLER
class UserController extends Controller
{
    public function __construct(
        protected UserService $userService
    ) {}

    public function index()
    {
        return $this->userService->getActiveUsers();
    }
}

// SERVICE
class UserService
{
    public function __construct(
        protected UserRepository $userRepository
    ) {}

    public function getActiveUsers()
    {
        return $this->userRepository->getActiveUsers();
    }
}

// REPOSITORY
class UserRepository
{
    public function getActiveUsers()
    {
        return User::where('status', 'active')->get();
    }
}
```
