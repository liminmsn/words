package com.example.native_

import android.annotation.SuppressLint
import android.content.Context
import android.provider.Settings
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.security.MessageDigest
import com.example.interface_.NativeItem


class Native(flutterEngine: FlutterEngine, context: Context) {
    private val channel =
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "com.example.words.native")
    private val map: Map<String, NativeItem> = mapOf(
        "PlatformVersion" to PlatformVersion(context),
        "TakeScreen" to TaskScene()
    )

    init {
        map.forEach { (key, item) ->
            channel.setMethodCallHandler { call, result ->
                item.channel = channel
                item.call(call, result)
            }
        }
    }
}

class PlatformVersion(private var context: Context) : NativeItem() {

    @SuppressLint("HardwareIds")
    override fun call(call: MethodCall, result: MethodChannel.Result) {
        if (call.method == "uuid") {
            val androidId =
                Settings.Secure.getString(context.contentResolver, Settings.Secure.ANDROID_ID)
            // 使用 SHA-256 对 Android ID 进行哈希以确保唯一性
            val digest = MessageDigest.getInstance("SHA-256")
            val hash = digest.digest(androidId.toByteArray(charset("UTF-8")))

            // 将哈希值转换为十六进制
            val hexString = StringBuilder()
            for (byte in hash) {
                val hex = Integer.toHexString(0xFF and byte.toInt())
                if (hex.length == 1) {
                    hexString.append('0')
                }
                hexString.append(hex)
            }

            result.success(hexString.toString())
        }
    }
}