# Teefi

Teefi is an autism support application designed to help parents of children with Autism Spectrum Disorder (ASD) and specialists monitor, manage, and support the child's development.

## About the Project

Teefi aims to provide a centralized platform that facilitates communication and access to useful resources for parents and specialists.

The application provides different functionalities based on the user's role and allows administrators to manage users and educational content.

## User Roles

The system supports three main types of users:

- **Admin**
  - Manage parents and specialists.
  - Manage application content.
  - Manage PECS categories and cards.
  - Manage educational articles.

- **Parent**
  - Access the child's information.
  - Monitor the child's behaviors and activities.
  - Access educational resources and PECS cards.
  - Follow the child's progress.

- **Specialist**
  - Access information related to assigned children.
  - Follow and support the child's development.
  - Review recorded behaviors and related information.
    
  **Super admin**
  -view all program
  -view complaints

## Main Features

- User authentication and role-based access.
- Parent and specialist management.
- Child information management.
- Behavior recording and monitoring.
- PECS (Picture Exchange Communication System) support.
- PECS categories and cards management.
- Educational articles.
- Admin dashboard.
- RESTful API for communication between the frontend and backend.
- MySQL database for storing application data.

## Technologies Used

### Frontend

- Flutter
- Dart
- Provider
- Dio
- SharedPreferences

### Backend

- Laravel
- PHP
- REST API
- Laravel Sanctum

### Database

- MySQL

### Development Tools

- Android Studio
- Visual Studio Code
- Git
- GitHub
- XAMPP

## System Architecture

The application follows a client-server architecture:

Flutter Application
        |
        | REST API
        |
Laravel Backend
        |
        |
     MySQL

## API Documentation

The Teefi backend provides a RESTful API built with Laravel. 
API authentication is handled using Laravel Sanctum, with role-based access control.

### Authentication

| Method | Endpoint | Description |
|---|---|---|
| POST | `/api/login` | Authenticate a user and return an access token |
| POST | `/api/logout` | Logout the authenticated user |

### Super Admin API

| Method | Endpoint | Description |
|---|---|---|
| GET | `/api/superadmin/children` | Retrieve all children |
| GET | `/api/superadmin/specialist` | Retrieve all specialists |
| GET | `/api/superadmin/specialists/{specialistId}/children` | Retrieve children assigned to a specialist |
| GET | `/api/superadmin/articles` | Retrieve all articles |
| GET | `/api/superadmin/pecs-cards` | Retrieve all PECS cards |
| GET | `/api/superadmin/complaints` | Retrieve all complaints |
| GET | `/api/superadmin/complaints/{id}` | Retrieve a specific complaint |

### Admin API

| Method | Endpoint | Description |
|---|---|---|
| GET | `/api/admin/dashboard` | Retrieve dashboard statistics |
| GET | `/api/admin/users/{type}` | Retrieve users by type |
| GET | `/api/admin/users/{type}/{id}` | Retrieve a specific user |
| POST | `/api/admin/users/{type}` | Create a new user |
| PUT | `/api/admin/users/{type}/{id}` | Update a user |
| DELETE | `/api/admin/users/{type}/{id}` | Delete a user |
| GET | `/api/admin/articles` | Retrieve articles |
| GET | `/api/admin/articles/{id}` | Retrieve a specific article |
| POST | `/api/admin/articles` | Create an article |
| PUT | `/api/admin/articles/{id}` | Update an article |
| DELETE | `/api/admin/articles/{id}` | Delete an article |
| GET | `/api/admin/pecs-card-categories` | Retrieve PECS categories |
| POST | `/api/admin/pecs-card-categories` | Create a PECS category |
| PUT | `/api/admin/pecs-card-categories/{id}` | Update a PECS category |
| DELETE | `/api/admin/pecs-card-categories/{id}` | Delete a PECS category |
| GET | `/api/admin/pecs-cards/{id}` | Retrieve a PECS card |
| POST | `/api/admin/pecs-cards` | Create a PECS card |
| PUT | `/api/admin/pecs-cards/{id}` | Update a PECS card |
| DELETE | `/api/admin/pecs-cards/{id}` | Delete a PECS card |

### Parent API

| Method | Endpoint | Description |
|---|---|---|
| GET | `/api/user/home` | Retrieve parent home screen data |
| GET | `/api/user/articles` | Retrieve available articles |
| GET | `/api/user/articles/{id}` | Retrieve a specific article |
| GET | `/api/user/pecs-categories` | Retrieve PECS categories |
| GET | `/api/user/pecs-categories/{id}/cards` | Retrieve PECS cards by category |
| GET | `/api/user/behavior-types` | Retrieve behavior types |
| POST | `/api/user/behaviors` | Record a new behavior |
| GET | `/api/user/children` | Retrieve the parent's children |
| GET | `/api/user/children/{childId}/profile` | Retrieve child profile |
| GET | `/api/user/children/{childId}/behaviors` | Retrieve child behavior records |
| GET | `/api/user/children/{childId}/reports/weekly` | Retrieve weekly report |
| GET | `/api/user/children/{childId}/reports/monthly` | Retrieve monthly report |
| GET | `/api/user/children/{childId}/reports/chart` | Retrieve report chart data |
| GET | `/api/user/children/{childId}/recommendations` | Retrieve recommendations |
| POST | `/api/user/complaints` | Submit a complaint |

### Specialist API

| Method | Endpoint | Description |
|---|---|---|
| GET | `/api/specialist/MyChildren` | Retrieve children assigned to the specialist |
| GET | `/api/specialist/children` | Retrieve children |
| GET | `/api/specialist/children/{childId}` | Retrieve child details |
| GET | `/api/specialist/children/{childId}/reports/weekly` | Retrieve weekly report |
| GET | `/api/specialist/children/{childId}/reports/monthly` | Retrieve monthly report |
| GET | `/api/specialist/children/{childId}/reports/chart` | Retrieve report chart data |
| GET | `/api/specialist/children/{childId}/recommendations` | Retrieve recommendations |
| POST | `/api/specialist/children/{childId}/recommendations` | Create a recommendation |
| PUT | `/api/specialist/recommendations/{id}` | Update a recommendation |
| DELETE | `/api/specialist/recommendations/{id}` | Delete a recommendation |

### Authentication

Protected endpoints require a valid Laravel Sanctum access token.
The token should be included in the request header:

Authorization: Bearer {token}

## Installation and Setup
Backend
Navigate to the backend directory:
cd backend
Install Laravel dependencies:
composer install
Configure the database connection in the .env file.
Run the database migrations:
php artisan migrate
Create the storage symbolic link:
php artisan storage:link
Start the Laravel development server:
php artisan serve
Frontend
Navigate to the frontend directory:
cd frontend
Install Flutter dependencies:
flutter pub get
Configure the backend API URL in the Flutter application.
Run the application:
flutter run
## Database
The application uses MySQL as its database management system.
The database stores information related to:

Users
Parents
Specialists
Children
Behaviors
PECS categories
PECS cards
Articles
Other application-related data
## Security
The backend uses Laravel Sanctum for API authentication.
Role-based access control is used to provide each user with the appropriate functionality according to their role.

## Project Goal
The main goal of Teefi is to provide an organized digital platform that supports parents and specialists in monitoring and supporting children with Autism Spectrum Disorder.

## Development

Teefi was developed as a graduation project using Flutter for the frontend and Laravel with MySQL for the backend.

## Authors
This project was developed as a graduation project by:

* **Maya Al Maghrabi**
* **Ayat Awama**

### Supervisors
* **ENG. Nour Al Hakim**
* **Dr. Afaf Al Shalabi**
