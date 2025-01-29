import 'package:flutter_test/flutter_test.dart';
import 'package:native_webview_plugin/native_webview_plugin.dart';
import 'package:native_webview_plugin/native_webview_plugin_platform_interface.dart';
import 'package:native_webview_plugin/native_webview_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockNativeWebviewPluginPlatform
    with MockPlatformInterfaceMixin
    implements NativeWebviewPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final NativeWebviewPluginPlatform initialPlatform = NativeWebviewPluginPlatform.instance;

  test('$MethodChannelNativeWebviewPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelNativeWebviewPlugin>());
  });

  test('getPlatformVersion', () async {
    NativeWebviewPlugin nativeWebviewPlugin = NativeWebviewPlugin();
    MockNativeWebviewPluginPlatform fakePlatform = MockNativeWebviewPluginPlatform();
    NativeWebviewPluginPlatform.instance = fakePlatform;

    expect(await nativeWebviewPlugin.getPlatformVersion(), '42');
  });
}
