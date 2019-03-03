A sample command-line application.

## Installation
Download source project from GitHub repository:

```
git clone https://github.com/Mathagoris/DartExamples.git
cd DartExamples
pub get
```

## Test
Perform all validation tests:

`pub run test`

or a specific test:

Type| Command
---|---
Single file| `pub run test path/to/test/myclass/test.dart`
All in folder| `pub run test path/to/test/myclass/`
Named test| `pub run test –n "name"`
Platform test| `pub run test –p chrome path/to/test/test.dart`

## Run
Run from the command line:

`pub run main.dart`

## License

Created from templates made available by Stagehand under a BSD-style
[license](https://github.com/dart-lang/stagehand/blob/master/LICENSE).
