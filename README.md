# Native WebView Plugin for Flutter

This project provides a custom Flutter plugin that enables displaying a native Android WebView inside a Flutter application. It allows you to use the native Android WebView component to display web content within your Flutter app.

## Installation

To use this plugin in your Flutter project, follow these steps:

1. **Clone the repository** containing the plugin to your local machine.

2. **Add the plugin to your Flutter project**:
   - Open your Flutter project’s `pubspec.yaml` file.
   - Add the plugin as a local dependency by specifying the path to the plugin directory (adjust the path according to where the plugin is located).
   
     Example:
     ```yaml
     dependencies:
       native_webview_plugin:
         path: /path/to/native_webview_plugin
     ```

   - Alternatively, you can use the GitHub repository link to add it as a dependency:
     ```yaml
     dependencies:
       native_webview_plugin:
         git:
           url: https://github.com/your-username/native_webview_plugin.git
     ```

3. **Install the dependencies** by running:
   ```bash
   flutter pub get

---

### 3. **How the Plugin Works**


## How the Plugin Works

### Flutter Side

#### `NativeWebviewPlugin` Class:
This class is used to interact with the native side of the application via Flutter's `MethodChannel`. The `NativeWebviewPlugin` class contains methods to call native code, such as getting the platform version using `getPlatformVersion()`.

#### `NativeWebView` Widget:
This is a custom widget provided by the plugin. It takes a URL and optional HTTP headers as parameters and displays the native WebView. The widget uses `AndroidView` to embed the native Android WebView into the Flutter UI. The platform-specific view is created when the app runs on an Android device.

### Android Side (Native Code)

#### `NativeWebviewPlugin.kt`:
The main functionality for creating and managing the WebView happens in this file. It defines the `NativeWebviewPlugin` class, which registers a custom view type (`native_webview`) with Flutter's `PlatformViewRegistry`. The plugin is responsible for handling method calls from Flutter, such as fetching the platform version.

#### `NativeWebViewFactory` Class:
This class is responsible for creating instances of the native WebView. It implements the `PlatformViewFactory` and provides the necessary setup for creating the native WebView in Android. This factory is registered to handle the view type `'native_webview'` as requested by the Flutter app.

#### `NativeWebView` Class:
This class creates and configures the Android WebView. It handles loading URLs (along with optional headers) and configuring WebView settings, such as enabling JavaScript and DOM storage.

### Communication Between Flutter and Native

#### `MethodChannel`:
Flutter communicates with the native code using a `MethodChannel`. This allows Flutter to call native functions and receive results. For example, when the `getPlatformVersion()` method is called from Flutter, it sends a message to the Android side, which responds with the Android version.

#### `Platform Views`:
Platform views allow you to embed native Android views (like WebView) into your Flutter UI. In this case, `AndroidView` is used to display the WebView.

## Usage in Your Flutter App

To use the `NativeWebviewPlugin` in your Flutter app:

1. **Import the Plugin**:  
   Import the plugin into your `main.dart` or any other file where you need to display the WebView.

2. **Create and Configure the WebView**:  
   Use the `NativeWebView` widget to display the WebView. The widget requires a URL to load and can optionally accept headers for the HTTP request.

3. **Initialize Platform-Specific Code**:  
   The Flutter app communicates with the native Android code via the `NativeWebviewPlugin` class. The `getPlatformVersion()` method can be used to check the platform version for debugging or display purposes.

4. **Integrate with Your Flutter App**:  
   The `NativeWebView` widget should be placed in your widget tree wherever you want the WebView to appear. On Android, it will render the native WebView, while on unsupported platforms, a fallback message can be shown.

## Permissions

For the WebView to access the internet, you need to add the following permissions in the `AndroidManifest.xml` file:

- **INTERNET Permission**: Required to load external URLs in the WebView.
- **ACCESS_NETWORK_STATE Permission**: Needed to check the network status (optional but recommended).

These permissions allow the WebView to function properly in an Android environment.

```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>


---

### 8. **Platform Support**

```markdown
## Platform Support

- **Android**: The plugin currently only supports Android. The Android-specific WebView implementation is registered and displayed via `PlatformViews`.
  
- **iOS Support**: If iOS support is needed, you would have to add additional code to handle WebView on iOS, but this plugin only implements the functionality for Android at this time.
