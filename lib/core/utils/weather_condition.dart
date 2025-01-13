import 'package:weather/core/assets/app_images.dart';

class WeatherCondition {
  final String dayDescription;
  final String nightDescription;
  final String dayImage;
  final String nightImage;

  WeatherCondition({
    required this.dayDescription,
    required this.nightDescription,
    required this.dayImage,
    required this.nightImage,
  });

  // Factory constructor to create WeatherCondition from a given code
  factory WeatherCondition.fromCode(int code) {
    Map<int, WeatherCondition> weatherConditions = {
      0: WeatherCondition(
          dayDescription: "Sunny",
          nightDescription: "Clear",
          dayImage: AppImages.icSunny,
          nightImage: AppImages.icClearNight),
      1: WeatherCondition(
          dayDescription: "Mainly Sunny",
          nightDescription: "Mainly Clear",
          dayImage: AppImages.icPartlyCloudy,
          nightImage: AppImages.icPartlyCloudyNight),
      2: WeatherCondition(
          dayDescription: "Partly Cloudy",
          nightDescription: "Partly Cloudy",
          dayImage: AppImages.icPartlyCloudy,
          nightImage: AppImages.icPartlyCloudyNight),
      3: WeatherCondition(
          dayDescription: "Cloudy",
          nightDescription: "Cloudy",
          dayImage: AppImages.icCloudy,
          nightImage: AppImages.icCloudy),
      45: WeatherCondition(
          dayDescription: "Foggy",
          nightDescription: "Foggy",
          dayImage: AppImages.icFog,
          nightImage: AppImages.icFog),
      48: WeatherCondition(
          dayDescription: "Rime Fog",
          nightDescription: "Rime Fog",
          dayImage: AppImages.icFog,
          nightImage: AppImages.icFog),
      51: WeatherCondition(
          dayDescription: "Light Drizzle",
          nightDescription: "Light Drizzle",
          dayImage: AppImages.icDrizzleSun,
          nightImage: AppImages.icDrizzleNight),
      53: WeatherCondition(
          dayDescription: "Drizzle",
          nightDescription: "Drizzle",
          dayImage: AppImages.icDrizzle,
          nightImage: AppImages.icDrizzle),
      55: WeatherCondition(
          dayDescription: "Heavy Drizzle",
          nightDescription: "Heavy Drizzle",
          dayImage: AppImages.icDrizzle,
          nightImage: AppImages.icDrizzle),
      56: WeatherCondition(
          dayDescription: "Light Freezing Drizzle",
          nightDescription: "Light Freezing Drizzle",
          dayImage: AppImages.icDrizzle,
          nightImage: AppImages.icDrizzle),
      57: WeatherCondition(
          dayDescription: "Freezing Drizzle",
          nightDescription: "Freezing Drizzle",
          dayImage: AppImages.icDrizzle,
          nightImage: AppImages.icDrizzle),
      61: WeatherCondition(
          dayDescription: "Light Rain",
          nightDescription: "Light Rain",
          dayImage: AppImages.icRainSun,
          nightImage: AppImages.icRainSun),
      63: WeatherCondition(
          dayDescription: "Rain",
          nightDescription: "Rain",
          dayImage: AppImages.icRainSun,
          nightImage: AppImages.icRainSun),
      65: WeatherCondition(
          dayDescription: "Heavy Rain",
          nightDescription: "Heavy Rain",
          dayImage: AppImages.icHeavyRain,
          nightImage: AppImages.icHeavyRain),
      66: WeatherCondition(
          dayDescription: "Light Freezing Rain",
          nightDescription: "Light Freezing Rain",
          dayImage: AppImages.icRainSun,
          nightImage: AppImages.icRainNight),
      67: WeatherCondition(
          dayDescription: "Freezing Rain",
          nightDescription: "Freezing Rain",
          dayImage: AppImages.icRainSun,
          nightImage: AppImages.icRainNight),
      71: WeatherCondition(
          dayDescription: "Light Snow",
          nightDescription: "Light Snow",
          dayImage: AppImages.icSnow,
          nightImage: AppImages.icSnow),
      73: WeatherCondition(
          dayDescription: "Snow",
          nightDescription: "Snow",
          dayImage: AppImages.icSnow,
          nightImage: AppImages.icSnow),
      75: WeatherCondition(
          dayDescription: "Heavy Snow",
          nightDescription: "Heavy Snow",
          dayImage: AppImages.icSnow,
          nightImage: AppImages.icSnow),
      77: WeatherCondition(
          dayDescription: "Snow Grains",
          nightDescription: "Snow Grains",
          dayImage: AppImages.icBlowingSnow,
          nightImage: AppImages.icBlowingSnow),
      80: WeatherCondition(
          dayDescription: "Light Showers",
          nightDescription: "Light Showers",
          dayImage: AppImages.icScatteradShowers,
          nightImage: AppImages.icScatteradShowersNight),
      81: WeatherCondition(
          dayDescription: "Showers",
          nightDescription: "Showers",
          dayImage: AppImages.icScatteradShowers,
          nightImage: AppImages.icScatteradShowersNight),
      82: WeatherCondition(
          dayDescription: "Heavy Showers",
          nightDescription: "Heavy Showers",
          dayImage: AppImages.icScatteradShowers,
          nightImage: AppImages.icScatteradShowersNight),
      85: WeatherCondition(
          dayDescription: "Light Snow Showers",
          nightDescription: "Light Snow Showers",
          dayImage: AppImages.icSleet,
          nightImage: AppImages.icSleet),
      86: WeatherCondition(
          dayDescription: "Snow Showers",
          nightDescription: "Snow Showers",
          dayImage: AppImages.icSleet,
          nightImage: AppImages.icSleet),
      95: WeatherCondition(
          dayDescription: "Thunderstorm",
          nightDescription: "Thunderstorm",
          dayImage: AppImages.icSeverThunderstorm,
          nightImage: AppImages.icSeverThunderstorm),
      96: WeatherCondition(
          dayDescription: "Light Thunderstorms With Hail",
          nightDescription: "Light Thunderstorms With Hail",
          dayImage: AppImages.icScatteradThunderstorm,
          nightImage: AppImages.icScatteradThunderstorm),
      99: WeatherCondition(
          dayDescription: "Thunderstorm With Hail",
          nightDescription: "Thunderstorm With Hail",
          dayImage: AppImages.icSeverThunderstorm,
          nightImage: AppImages.icSeverThunderstorm),
    };

    return weatherConditions[code] ??
        WeatherCondition(
          dayDescription: "Unknown",
          nightDescription: "Unknown",
          dayImage: AppImages.icSunny,
          nightImage: AppImages.icSunny,
        );
  }
}
