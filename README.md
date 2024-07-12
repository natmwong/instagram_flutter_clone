# Instagram Flutter Clone

A clone of Instagram built using Flutter and Firebase.

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Implementation Details](#implementation-details)
- [License](#license)
- [Contact](#contact)

## Introduction

This project is a clone of Instagram, built to demonstrate the capabilities of Flutter in creating complex UI/UX and handling state management, along with Firebase for backend services.

## Features

- User Authentication (Login/Signup)
- Image Upload
- User Profile
- Following/Unfollowing users
- Liking and Commenting on posts
- Real-time Updates

## Implementation Details

### User Authentication

- **Firebase Authentication**: Used for user login and signup.
- **Flutter Widgets**: 
  - `TextFormField`: Used for input fields.
  - `ElevatedButton`: Used for submission buttons.

### Image Upload

- **Firebase Storage**: Used to store uploaded images.
- **Flutter Widgets**:
  - `ImagePicker`: Used to select images from the device.
  - `CircularProgressIndicator`: Used to show upload progress.

### User Profile

- **Firebase Firestore**: Used to store and retrieve user profile information.
- **Flutter Widgets**:
  - `CircleAvatar`: Used to display profile pictures.
  - `ListView`: Used to display the user's posts.

### Following/Unfollowing Users

- **Firebase Firestore**: Used to manage user follow data.
- **Flutter Widgets**:
  - `FlatButton`: Used for follow/unfollow actions.

### Liking and Commenting on Posts

- **Firebase Firestore**: Used to store likes and comments.
- **Flutter Widgets**:
  - `IconButton`: Used for like buttons.
  - `TextFormField`: Used for adding comments.
  - `ListView`: Used to display comments.

### Real-time Updates

- **Firebase Firestore**: Used for real-time data synchronization.
- **Flutter Widgets**:
  - `StreamBuilder`: Used to build UI based on real-time data streams.

## License

    Copyright [2024] [Natasha Wong]

    Licensed under the Apache License, Version 2.0 (the "License");
