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
