package com.example.interface_

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

abstract class NativeItem(var url: String) {
    abstract fun call(call: MethodCall, result: MethodChannel.Result)
}