#!/bin/bash

# Name of the project (You can change this)
PROJECT_NAME="my_php_project"

# Create the main project directory
mkdir $PROJECT_NAME

# Navigate into the project directory
cd $PROJECT_NAME

# Create the necessary folders
mkdir -p config app/controllers app/models app/views public/css public/js public/images vendor logs storage tests routes resources/views resources/lang database cache bin

# Create the required files
touch index.php .env .htaccess composer.json composer.lock

# Create some example files for models, controllers, and views
touch app/models/User.php
touch app/controllers/UserController.php
touch app/views/home.php

# Create example CSS and JS files
touch public/css/style.css
touch public/js/app.js

# Create an example database migration file
touch database/migrations/2024_08_24_create_users_table.php

# Notify user of successful creation
echo "PHP project directory structure created successfully under $PROJECT_NAME."

