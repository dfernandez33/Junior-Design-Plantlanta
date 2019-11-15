Client-code guideline:
- Please keep structure of file as it is. Don't save random files in root folder. If you want to add
another folder, please feel free to do so! Better to have one file in a folder than just a random
file in the root folder.
    - screens: meant to store objects that represent different views of the apps
    - model: data representation of each element of the app
    - widgets: UI elements used in each screen
    - serializers: include objects to transform JSON to objects or vice-versa
        - If you create a new serializer, add it to the serilizers class

- Kike is a huge fan of built_value! please try not to use PODO (Plain Old Dart Objects) because
these become tedious to update as we scale.
    - Check this links to know more about built_value:
        - https://github.com/google/built_value.dart
        - https://pub.dev/packages/built_value
        - https://medium.com/dartlang/darts-built-value-for-immutable-object-models-83e2497922d4
        - Check the model for EventCard for an example.
        - Run: "flutter packages pub run build_runner build --delete-conflicting-outputs" to regenerate .g.dart files!

- Our green color can be accessed through Theme.of(context).primaryColor don't use random green
    - Kike is working towards to make all our color a global object to not use Colors.xxx in any class

- Don't call firebase directly! Look at the Firebase folder to the the functions that we have.

- The format for dart file names is: snake_case don't use Java format

- Private method/elements must have a "_" at the beginning of the name

- Feel free to use any third_party library!

- Don't use the keyword "new" on Dart code. This is redudant in this language and it makes the code
longer for no need.

