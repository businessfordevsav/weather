# Weather App 🌦️

A feature-rich weather app built with Flutter, providing real-time weather updates, forecasts, and customizable themes.

## Features

- **Dark, Light, and System Theme Selection**: Switch between themes for a personalized experience.
- **Screens**:
  1. **Splash Screen**: A welcoming entry screen.
  2. **Home Screen**: Displays current weather for your location.
  3. **Details Screen**: Detailed weather information.
  4. **Forecast Screen**: Weather forecast for the upcoming days.
  5. **Location Select Screen**: Choose or search for a different location.
  6. **Settings Screen**: Configure app preferences.
- **Real-time Weather Data**: Powered by the Open-Meteo API.
- **Geolocation Support**: Automatically fetch weather for your current location.

---

## Tech Stack and Dependencies

### Flutter Packages Used:

- **Core UI and Styling**:

  - [`cupertino_icons`](https://pub.dev/packages/cupertino_icons): iOS-styled icons.
  - [`google_fonts`](https://pub.dev/packages/google_fonts): Custom fonts integration.
  - [`iconsax_flutter`](https://pub.dev/packages/iconsax_flutter): Icon pack for modern UI.
  - [`custom_refresh_indicator`](https://pub.dev/packages/custom_refresh_indicator): Customizable pull-to-refresh animations.

- **State Management and Dependency Injection**:

  - [`provider`](https://pub.dev/packages/provider): State management.
  - [`flutter_bloc`](https://pub.dev/packages/flutter_bloc): Bloc pattern for state management.
  - [`equatable`](https://pub.dev/packages/equatable): Simplifies equality comparisons.
  - [`get_it`](https://pub.dev/packages/get_it): Dependency injection.
  - [`injectable`](https://pub.dev/packages/injectable): Annotation-based dependency injection.

- **Networking and APIs**:

  - [`dio`](https://pub.dev/packages/dio): HTTP client for API requests.
  - [`open_meteo`](https://pub.dev/packages/open_meteo): API integration for weather data.

- **Utilities**:

  - [`shared_preferences`](https://pub.dev/packages/shared_preferences): Local storage for app settings.
  - [`intl`](https://pub.dev/packages/intl): Date and number formatting.
  - [`logging`](https://pub.dev/packages/logging): Debugging and log management.

- **Location Services**:

  - [`geolocator`](https://pub.dev/packages/geolocator): Location fetching.
  - [`geocoding`](https://pub.dev/packages/geocoding): Reverse geocoding.
  - [`location`](https://pub.dev/packages/location): Enhanced location handling.
  - [`permission_handler`](https://pub.dev/packages/permission_handler): Manage app permissions.

- **Database**:

  - [`realm`](https://pub.dev/packages/realm): Local data persistence.

- **Code Analysis**:

  - [`analyzer`](https://pub.dev/packages/analyzer): Static code analysis.

- **Meta**:
  - [`meta`](https://pub.dev/packages/meta): Annotations for better code readability.

---

## Installation

1. **Clone the Repository**:

```bash
  git clone https://github.com/businessfordevsav/weather.git
```

2. **Navigate to the project directory**:

```bash
cd weather-app
```

3. **Install the dependencies**:

```bash
flutter pub get
```

4, **Run the app**:
```bash
flutter run
```

---

## API Integration

This app uses the [Open-Meteo API](https://open-meteo.com/) to fetch real-time weather data. Ensure you have an active internet connection for the app to function properly.

---

## Screenshots

_Include screenshots or GIFs showcasing the app's features._

---

## Contribution

Contributions are welcome! If you'd like to improve the app, feel free to fork the repository and submit a pull request.

1. Fork the repository.
2. Create your feature branch: `git checkout -b feature/YourFeatureName`
3. Commit your changes: `git commit -m 'Add some feature'`
4. Push to the branch: `git push origin feature/YourFeatureName`
5. Open a pull request.

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## Acknowledgments

- Flutter team for the amazing framework.
- Open-Meteo for providing the weather API.
