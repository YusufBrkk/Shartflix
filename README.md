# Shartflix

Shartflix is a Flutter-based movie application that provides users with a seamless experience for browsing and discovering movies. The application includes user authentication, an infinite scroll feature on the homepage, and various functionalities to enhance user engagement.

## Features

- **User Authentication**: Users can sign up and log in to their accounts securely.
- **Infinite Scroll**: The homepage features an infinite scroll list of movies, allowing users to browse through a vast collection without interruptions.
- **Movie Details**: Users can view detailed information about each movie, including title, description, release date, and rating.
- **Profile Management**: Users can view and edit their profile information.
- **Custom App Bar**: A consistent and customizable app bar is used throughout the application.

## Project Structure

```
shartflix
├── lib
│   ├── main.dart
│   ├── src
│   │   ├── app.dart
│   │   ├── models
│   │   │   └── movie.dart
│   │   ├── screens
│   │   │   ├── home_screen.dart
│   │   │   ├── login_screen.dart
│   │   │   ├── signup_screen.dart
│   │   │   ├── movie_detail_screen.dart
│   │   │   └── profile_screen.dart
│   │   ├── widgets
│   │   │   ├── movie_card.dart
│   │   │   ├── infinite_scroll_list.dart
│   │   │   └── custom_app_bar.dart
│   │   ├── services
│   │   │   ├── auth_service.dart
│   │   │   └── movie_service.dart
│   │   ├── providers
│   │   │   ├── auth_provider.dart
│   │   │   └── movie_provider.dart
│   │   └── utils
│   │       └── constants.dart
├── pubspec.yaml
└── README.md
```

## Getting Started

To get started with the Shartflix application, follow these steps:

1. **Clone the Repository**:
   ```
   git clone <repository-url>
   ```

2. **Navigate to the Project Directory**:
   ```
   cd shartflix
   ```

3. **Install Dependencies**:
   ```
   flutter pub get
   ```

4. **Run the Application**:
   ```
   flutter run
   ```

## Technologies Used

- Flutter
- Dart
- Provider for state management
- REST API for movie data

## Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue for any enhancements or bug fixes.

## License

This project is licensed under the MIT License. See the LICENSE file for details.