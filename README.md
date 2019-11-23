# Release Notes #
## Mobile Application ##

Release Notes version Plantlanta Mobile 1.0

**NEW FEATURES:**

- Fully functioning events dashboard to allow for volunteer event signup.
- Integrated QR scanner to allow volunteer to confirm their attendance to events.
- Integrated marketplace to allow volunteers to redeem their points for available rewards. These points are obtained by participating in volunteering events.
- Sleek profile view to allow volunteers to see what events they have previously participated in, as well as what events they have coming up. Additionally, volunteers can use the profile view to see a history of their point transactions (both earning points from events and spending points on marketplace items) as well as to change their profile picture.
- New activity feed allows to see what events a volunteers friends are participating in, as well as what items they have redeemed from the marketplace. 
- Search bar in events dashboard allows users to search for particular events by name, location or event type.
- Search bar in marketplace allows users to search for particular items by name or brand.
- Search bar in activity feed allows users to search for friends by name and add new friends.

**BUG FIXES:**
- Fixed bug not allowing the profile view to correctly load user data in parallel. 
- Fixed bug not allowing users to change their profile pictures.
- Fixed bug allowing users to purchase items that were out of stock in the marketplace.

**KNOWN BUGS:**
- Missing spinner in login page to show progress while performing login.
- Missing spinner in profile view when changing profile picture.
- Missing spinner in registration view to show progress after submitting a registration request. 

## Web Application ##

Release Notes version Plantlanta Web App 1.0

**NEW FEATURES:**
- Landing page for Plantlanta Volunteering application, which contains images of the mobile app as well links redirecting users to download the app in their respective mobile app stores. Landing page also contains “Login” button for administrators to access the Web app.
- Fully functioning event dashboard to allow for administrators to easily create, edit and delete events.
- Fully functioning marketplace dashboard that allows administrators to easily create, edit and delete items for users to purchase in their marketplace.
- Search bar in event dashboard allows administrators to search for particular events by name or location.
- Search bar in marketplace dashboard allows administrators to search for particular items by name or brand.

**BUG FIXES**
- Fixed bug allowing number of codes to be different to the number of items in stock for a given item.
- Fixed bug not allowing administrators to edit items’ images.
- Fixed clock color for event creation and editing to be relevant to the theme of the web application.

**KNOWN BUGS**
- Searching event by event type not yet implemented into web application.
 
# Install Guide #

## Mobile Application ##

**PRE-REQUISITES**
- Android Studio 3.5 (download)
- Emulator for Android
- Flutter >1.9.0 (install)
- Android SDK
- iOS SDK
- Dart (install)

**DEPENDENCIES**
All the dependencies are generated and installed with the pubspec.yaml
  - cupertino_icons: ^0.1.2
  - firebase_core: ^0.4.0+1
  - firebase_auth: ^0.11.1+3
  - cloud_functions: ^0.4.1+1
  - cloud_firestore: ^0.12.9+5
  - built_collection: '>=2.0.0 <5.0.0'
  - built_value: '>=5.5.5 <7.0.0'
  - build_runner: ^1.0.0
  - built_value_generator: ^6.7.1
  - source_gen: ^0.9.0
  - intl: 0.15.8
  - barcode_scan: ^1.0.0
  - flutter_staggered_grid_view: "^0.3.0"
  - circular_profile_avatar: ^1.0.2
  - image_picker: ^0.6.1+8
  - firebase_storage: ^3.0.6
  - image_cropper: ^1.1.0
  - image: ^2.1.5
  - algolia: ^0.1.7
  - build_runner: ^1.0.0
  - built_value_generator: ^6.7.1

**DOWNLOAD**

Clone the repository

**BUILD**
1. Navigate to the “Flutter” folder
2. Run the following command:

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;flutter packages get
  
3. Run the following command to generate build_value .g files:

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'flutter packages pub run build_runner build --delete-conflicting-outputs'

4. There is not an executable file/package at this moment. It can only be run from Android Studio to an emulator or physical device.

**INSTALLATION**

Ideally, the application should be available in both Google Play Store and Apple Store. Currently, it must be installed locally. See the following section for details.

**RUNNING APPLICATION**
- Method 1:
  - Navigate to the “Flutter” folder of the downloaded application and run the following command:
    - flutter run -d device-id
    - device-id must be an emulator or a physical device.
    
- Method 2:
  - On Android Studio configure a Flutter project with the Dart entrypoint
    - Junior-Design-Plantlanta/Flutter/lib/main.dart
  - Run the app by clicking the green play button on the top right corner.
  
## Web Application ##

**PRE-REQUISITES**
- NodeJS (install)
- AngularCLI
  - After installing NodeJS, run the following command in your Terminal:
    - npm install -g @angular/cli

**DEPENDENCIES**

All the dependencies can be found in the project level package.json file, and installed using npm install

   - @angular/animations
   - @angular/cdk
   - @angular/common
   - @angular/compiler
   - @angular/core
   - @angular/fire
   - @angular/forms
   - @angular/material
   - @angular/platform-browser
   - @angular/platform-browser-dynamic
   - @angular/router
   - algoliasearch
   - angular-instantsearch
   - angularx-qrcode
   - bulma
   - bulma-extensions
   - core-js
   - firebase
   - font-awesome
   - hammerjs
   - ngx-device-detector
   - ngx-material-timepicker
   - ngx-spinner
   - rxjs
   - rxjs-compat
   - tslib
   - zone.js

**DOWNLOAD**

Clone the repository

**BUILD**

Run `ng build` to build the project. The build artifacts will be stored in the `dist/` directory. Use the `--prod` flag for a production build.

**INSTALLATION**

There is no installation process required. Once the repository is cloned take a look at the next section to see how you can run the application locally.
 
**RUNNING APPLICATION**

Navigate to the “Web App/plantlanta” folder of the downloaded application and run the following command:
- ng serve

