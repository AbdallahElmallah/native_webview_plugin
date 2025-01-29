import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'native_webview_plugin_method_channel.dart';

abstract class NativeWebviewPluginPlatform extends PlatformInterface {
  /// Constructs a NativeWebviewPluginPlatform.
  NativeWebviewPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static NativeWebviewPluginPlatform _instance = MethodChannelNativeWebviewPlugin();

  /// The default instance of [NativeWebviewPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelNativeWebviewPlugin].
  static NativeWebviewPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [NativeWebviewPluginPlatform] when
  /// they register themselves.
  static set instance(NativeWebviewPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
