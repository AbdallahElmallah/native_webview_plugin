// In native_webview_plugin/android/src/main/kotlin/com/example/native_webview_plugin/NativeWebviewPlugin.kt
package com.example.native_webview_plugin

import android.content.Context
import android.view.View
import android.webkit.WebView
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class NativeWebviewPlugin: FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(binding.binaryMessenger, "native_webview_plugin")
        channel.setMethodCallHandler(this)
        
        binding.platformViewRegistry.registerViewFactory(
            "native_webview",
            NativeWebViewFactory()
        )
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "getPlatformVersion" -> {
                result.success("Android ${android.os.Build.VERSION.RELEASE}")
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}

// Rest of the code remains the same...
class NativeWebViewFactory : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context, id: Int, args: Any?): PlatformView {
        val creationParams = args as Map<String?, Any?>?
        return NativeWebView(context, creationParams)
    }
}

class NativeWebView(
    private val context: Context,
    private val creationParams: Map<String?, Any?>?
) : PlatformView {
    private val webView: WebView = WebView(context)

    init {
        val url = creationParams?.get("url") as String?
        val headers = creationParams?.get("headers") as Map<String, String>?
        
        webView.settings.apply {
            javaScriptEnabled = true
            domStorageEnabled = true
        }
        
        url?.let {
            if (headers != null) {
                webView.loadUrl(it, headers)
            } else {
                webView.loadUrl(it)
            }
        }
    }

    override fun getView(): View = webView

    override fun dispose() {}
}