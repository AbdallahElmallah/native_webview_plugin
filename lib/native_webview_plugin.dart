// In native_webview_plugin/lib/native_webview_plugin.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class NativeWebviewPlugin {
  static const MethodChannel _channel = MethodChannel('native_webview_plugin');

  Future<String?> getPlatformVersion() async {
    final version = await _channel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}

class NativeWebView extends StatefulWidget {
  final String url;
  final Map<String, String>? headers;

  const NativeWebView({
    super.key,
    required this.url,
    this.headers,
  });

  @override
  State<NativeWebView> createState() => _NativeWebViewState();
}

class _NativeWebViewState extends State<NativeWebView> {
  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: 'native_webview',
        creationParams: {
          'url': widget.url,
          'headers': widget.headers ?? {},
        },
        creationParamsCodec: const StandardMessageCodec(),
      );
    }
    return Text('Unsupported platform');
  }
}
