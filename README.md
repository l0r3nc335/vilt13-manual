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

# WAYS TO RETRIEVE DATA ========================

# Eloquent ORM (Model-based)
Pros: Clean and expressive Supports relationships (hasMany, belongsTo, etc.) Easy to maintain
```text
Use it for: 
    1. Business logic 
    2. CRUD operations 
    3. Relationships
```
```php
    $users = User::all();
    $user = User::find(1);
    $users = User::where('status', 'active')->get();
    $user_with_post = User::with('posts')->where('status', 'active')->get();
```

# Query Builder
Pros: Faster than Eloquent for large datasets Less memory usage Good for complex queries
```text
    Use it when:
    
    Queries get too complex or heavy
    You don’t need model features (relationships, mutators, etc.)
    Performance matters more than readability
```
```php
    $users = DB::table('users')->get();
    $user = DB::table('users')
        ->where('id', 1)
        ->first();

    DB::table('orders')
        ->join('users', 'users.id', '=', 'orders.user_id')
        ->select('users.name', 'orders.total')
        ->get();
```

# Raw SQL Queries
Pros: Maximum control Useful for highly optimized or database-specific queries
```text
Use it when:
    1. You need database-specific features
    2. Highly optimized reports/queries
    3. Complex aggregations are easier in SQL
```
```php
    $users = DB::select(
        'SELECT * FROM users WHERE status = ?',
        ['active']
    );
    DB::select("SELECT DATE(created_at), COUNT(*) FROM orders GROUP BY DATE(created_at)");
```

# Database Facade Methods
Technically Query Builder, but often considered separately because you're working directly with the DB facade.
```text
Use it when:
    1. Logic lives in the database
    2. Can improve performance for complex operations
```
```php
    $value = DB::table('users')->value('email');
    $count = DB::table('users')->count();
    $exists = DB::table('users')
        ->where('email', $email)
        ->exists();
```

# Stored Procedures
Pros: Logic lives in the database Can improve performance for complex operations
```php
$results = DB::select('CALL GetActiveUsers()');
```

# Relationships (Eloquent)
```php
    $user = User::find(1);
    $posts = $user->posts;
    $users = User::with('posts')->get();
```

# Cursor / Lazy Collections
Pros: Useful for large datasets.
```text
Use it when:
    1. Very large tables (100k+ rows)
    2. When you process records one at a time
    3. Avoiding memory overflow
```
```php
    use App\Models\User;

    foreach (User::cursor() as $user) {
        // this was changed: process one record at a time
        \Mail::to($user->email)->send(
            new \App\Mail\WelcomeMail($user)
        );
    }

    $users = User::where('active', true)->cursor();
    
    foreach ($users as $user) {
        echo $user->name;
    }

// Lazy
    $posts = Post::lazy(1000); 
    
    $posts->each(function ($post) {
        $post->update(['processed' => true]);
    });
```

# Chunking
Process records in batches.
```text
Use it when
    1. Bulk updates
    2. Batch processing (e.g. syncing, analytics)
    3. When you want control per group of records
```
```php
    use App\Models\User;
// Update user status in batches
    User::where('last_login', '<', now()->subYear())
        ->chunk(100, function ($users) {
            foreach ($users as $user) {
                // this was changed: batch processing per 100 users
                $user->status = 'inactive';
                $user->save();
            }
        });
        
// Export users in chunks
    User::chunk(500, function ($users) {
    foreach ($users as $user) {
        // this was changed: process export logic per batch
        echo $user->id . "," . $user->email . PHP_EOL;
    }

});
```

