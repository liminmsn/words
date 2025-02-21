package com.example.native_


import com.example.interface_.NativeItem
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class TaskScene : NativeItem() {
    override fun call(call: MethodCall, result: MethodChannel.Result) {}
    fun send() {
        channel.invokeMethod("tackScene", "")
    }
}