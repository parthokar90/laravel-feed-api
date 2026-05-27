# Laravel Feed API Platform

A scalable RESTful API backend built with Laravel for a modern social feed platform.
This project is designed with production-level architecture, focusing on performance, scalability, and clean API design.It supports core social media features like authentication, posts, comments, replies, likes, and privacy control, making it suitable for large-scale applications.

---
## Key Features

### Authentication & Authorization
- Admin, Vendor, and Customer authentication
- Role-based access control (RBAC)
- Secure login & registration system

---

## Tech Stack

- Laravel 13
- PHP 8.3+
- MySQL
- Laravel Sanctum (Auth)
- JWT Authentication (API Security)
- RESTful API Architecture
- Supabase S3 (File Storage Ready)
- Composer

# ⚙️ Installation & Setup

---

## Clone the Repository

Clone the project from GitHub to your local machine.

```bash
git@github.com:parthokar90/laravel-feed-api.git
```

## Navigate to Project Folder

Move into the project directory.

```bash
cd your-repository-name
```

Install PHP Dependencies
```bash
composer install
```

Configure Environment File

```bash
cp .env.example .env
```

## ☁️ Supabase Storage Setup

This project uses Supabase Storage for image/media uploads.
## Step 1: Create Supabase Project
Go to https://supabase.com
Create new project
Go to Storage section
Create a bucket (example: feed-media)

---

## Step 2: Get Credentials

From Supabase dashboard:

Project URL
API Key (Service Role Key recommended for backend)

---

## Step 3: Configure .env

Add the following in .env file:
FILESYSTEM_DISK=s3
AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
AWS_DEFAULT_REGION=
AWS_ENDPOINT=
AWS_URL=
AWS_BUCKET=
AWS_USE_PATH_STYLE_ENDPOINT=

---

Run Database Migration & Seeders
```bash
php artisan migrate --seed
```

Start the Development Server
```bash
php artisan serve
```

---

## Run Project with Docker

This project can also be run using Docker without installing PHP, Composer, or MySQL locally.

---

## Prerequisites

Make sure you have installed:

Docker
Docker Compose

```bash
docker -v
docker compose version
```

---

## Start Project with Docker

Run the following command from project root:

```bash
docker compose up --build
```
This will:

Build Laravel container
Start MySQL database
Run PHP-FPM + Nginx
Expose project on port 8000

---

## Access Project

```bash
http://localhost:8000
```

## Run in background

```bash
Run in Background
```


