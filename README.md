# I. WINDOWS SUBSYSTEM FOR LINUX SETUP

# I.1. LIST EXISTING WSL DISTRO
```sh
    wsl --list
```

# I.2. DELETE DISTRO
```sh
  wsl --unregister <DistroName>
```

# I.3. SHOW DISTRO ONLINE
```sh
	wsl --list --online
```

# I.4. INSTALL DISTRO
```sh
  wsl --install -d <DISTRO>
```
	
# II. LOCAL LINUX SETUP

# II.1. INSTALL PHP STANDALONE, NON-HERD OR LARAVEL PATH
```sh
  sudo apt install php8.5-cli
```

# II.2. FIND PHP.INI CONFIGURATION FILE
```sh
  php -i | grep "php.ini"
```

# II.3. OPEN PHP.INI
```sh 
	sudo nano /etc/php/8.5/cli/php.ini
```

# II.4. ENABLE KNOWN EXTENSIONS
	[
		extension=curl, 
		extension=mbstring, 
		extension=oepnssl, 
		extension=pdo_mysql/pdo_pgsql
	]

# II.5. INSTALL THE ACTUAL EXTENSIONS
```sh
  sudo apt update
  sudo apt install -y phpX.X-mysql phpX.X-curl phpX.X-mbstring
```
return the ";extension=curl" if there is an error upon php-v

# II.6. INSTALL COMPOSER
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

# III LARAVEL INSTALLATION AND INITIAL SETUP

# III.1. NEW PROJECT VIA COMPOSER

```sh 
  composer create-project laravel/laravel vilt13-manual
```

# III.2. FIX ISSUE WITH In ZipDownloader.php
```sh
  sudo apt update && sudo apt install unzip php-zip -y
```

# III.3 COMPOSER INSTALL
```sh 
  composer install
```

# III.4 START LARAVEL LOCAL DEVELOPMENT
```sh
  npm install && npm run build
  composer run dev
```

# III.5. ISSUE WITH EXTENSIONS
```sh 
  sudo apt update
  sudo apt install -y php8.5-xml
```

# III.7. APP GENERATE KEY
```sh
  php artisan key:generate
```

# III.8. ISSUE WITH DATABASE CONNECTION
Fix in and populate database variables in .env
```.dotenv
    DB_CONNECTION=
    DB_HOST=127.0.0.1
    DB_PORT=3306
    DB_DATABASE=
    DB_USERNAME=
    DB_PASSWORD=
```

# III.9. MIGRATE FOR THE FIRST TIME
```sh 
  php artisan migrate
```

# IV. VILT MANUAL CONFIGURATION

# IV.1 VITE MANUAL CONFIGURATION
    http://inertiajs.com/docs/v3/installation/server-side-setup

# IV.2. VUE PLUGIN FOR VITE
will install "@vitejs/plugin-vue": "^6.0.7", to package.json
```sh
  npm install --save-dev @vitejs/plugin-vue
```

# IV.3. UPDATE vite.config.js
    - import vue from '@vitejs/plugin-vue';
    - THEN REGISTER THE  vue({}}

# IV.4. SETUP INERTIA LARAVEL PACKAGE

# IV.4.a. SERVER SIDE SETUP
    -https://inertiajs.com/docs/v3/installation/server-side-setup
```sh 
  composer require inertiajs/inertia-laravel
```

# IV.4.b.ROOT TEMPLATE SETUP
    RENAME  - resources/views/welcome.blade.php
    TO      - resources/views/app.blade.php
    CODE IN - resources/views/app.blade.php 

# IV.4.c. PHP INERTIA MIDDLEWARE
```sh 
  php artisan inertia:middleware
```

# IV.4.d. bootstrap/app.php
This will enable laravel to pass data to vue
```php
    use App\Http\Middleware\HandleInertiaRequests;

    ->withMiddleware(function (Middleware $middleware) {
        $middleware->web(append: [
            HandleInertiaRequests::class,
        ]);
    })
```

# IV.5 CLIENT SIDE SETUP
    - https://inertiajs.com/docs/v3/installation/client-side-setup

# IV.5.a. VUE PREREQUISITE
```sh 
  npm install vue @vitejs/plugin-vue
```

# IV.5.b. INITIALIZE INERTIA APP
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
# IV.5.c. RUN VILT SETUP
    -run in 2 separate terminals
```sh 
  php artisan serve
```
```sh 
  npm run dev
```

# IV.5.d. SETUP PAGES
    create - resources/pages/Index/Index.vue

# IV.5.e. SETUP ROUTES
    routes/web.php

# V. DATA ACCESS PATTERN ========================

# V.1. Controller → Model (Small applications)
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
# V.2. Controller → Service → Mode (professional projects)
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

# V.3. Controller → Service → Repository → Model (large enterprise projects) **Preferred
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

# VI. WAYS TO RETRIEVE DATA ========================

# VI.1 Eloquent ORM (Model-based)
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

# VI.2 Query Builder
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

# VI.3. Raw SQL Queries
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

# VI.4. Database Facade Methods
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

# VI.5. Stored Procedures
Pros: Logic lives in the database Can improve performance for complex operations
```php
$results = DB::select('CALL GetActiveUsers()');
```

# VI.6. Relationships (Eloquent)
```php
    $user = User::find(1);
    $posts = $user->posts;
    $users = User::with('posts')->get();
```

# VI.7. Cursor / Lazy Collections
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

# VI.8. Chunking
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

