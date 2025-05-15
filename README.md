# 🔗 JobConnect

## 📱 Overview

JobConnect is a **mobile application** designed to **connect local job providers with job seekers**, focusing on roles like painters, home nurses, farm workers, and more. The app serves the community by helping people find regular work even at lower wages, while providing employers with easy access to available workers.

## ✨ Features

### 👤 User Authentication

* Sign-up and login functionality
* Form validations for user creation
* Email verification system
* Password recovery (coming soon)

### 👷 For Job Seekers

* Browse available jobs with filtering options
* Filter jobs by type (painter, home nurse, etc.)
* Filter jobs by location/city
* Apply to jobs with custom wage requests
* View job details and provider contact information
* Track application status

### 💼 For Job Providers

* Post new job opportunities
* Specify job details (type, location, wage range, etc.)
* Define multiple vacancies for a single job posting
* Receive email notifications when users apply
* Accept or decline job applications
* Track job status and progress

### 🔄 Role Switching

* Users can seamlessly switch between job seeker and provider roles
* Maintain separate dashboards for each role

## 🚀 Getting Started

### Installation

[App apk](https://github.com/dhanya180/JobConnect/blob/main/ANDROID-APK/JobConnect.apk)

## 💻 Technical Architecture

### Frontend

* Framework: Flutter
* Features:
    * Intuitive UI for both job providers and seekers
    * Role-based views and actions
    * Real-time status updates

### Backend

* API Gateway: AWS API Gateway
* Serverless Functions: AWS Lambda
* Database: Amazon DynamoDB (NoSQL)
* Email Notifications: For job applications
