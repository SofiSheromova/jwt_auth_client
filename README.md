# JWTAuthClient

Example project where authentication is implemented through JWT access tokens along with refresh tokens.  

## JWTAuthService

This application uses the [JWTAuthService](https://github.com/BeFunny1/JWT_Auth-Serivce) API by [@BeFunny1](https://github.com/BeFunny1).  
Service can be run locally if docker is installed.

1. create `.env` file (copy of `.env.example`) and come up with keys
2. run `make`

## Startup client steps  

1. Install dependencies: `flutter pub get`
2. Start file generation `flutter pub run build_runner build --delete-conflicting-outputs`
3. Run the project with environment variables `flutter run --dart-define API_URL=<api_url>  --dart-define API_SECRET=<api_secret>`

<img src="screenshots/login_screen.png" alt="login screen" width="400"/>
<img src="screenshots/home_screen.png" alt="login screen" width="400"/>
