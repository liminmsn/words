package com.example.native_.abstract_

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

abstract class NativeItem() {
    lateinit var channel: MethodChannel;
    abstract fun call(call: MethodCall, result: MethodChannel.Result)
}
