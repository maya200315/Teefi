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
## API
The backend provides RESTful API endpoints for communication with the Flutter application.

Examples of available endpoints include:

GET  /api/admin/dashboard
GET  /api/admin/users/parents
GET  /api/admin/users/parents/{id}
POST /api/admin/users/parents
POST /api/admin/articles

Authentication is handled using Laravel Sanctum.

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
