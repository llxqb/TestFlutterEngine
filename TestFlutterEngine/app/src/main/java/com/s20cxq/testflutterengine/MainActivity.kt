package com.s20cxq.testflutterengine

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import androidx.fragment.app.Fragment
import io.flutter.embedding.android.FlutterFragment
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.MethodChannel
import java.util.HashMap

/**
 * 1、测试原生与flutter交互
 * 2、测试flutter路由跳转
 */
class MainActivity : AppCompatActivity() {
    private lateinit var flutterFragment: FlutterFragment
    val engineId = "io.flutter"//Engine 引擎id
    //通道名
    var channelName = "com.pages.flutter.androidTest.demo"
    //flutter 引擎  这是一个纯 C++实现的 SDK，它就是 Dart的一个运行时，负责把客户端的事件传递到运行时中的代码。
    var mFlutterEngine: FlutterEngine? = null

    var mMethodChannel: MethodChannel? = null
    var TAG ="MainActivity"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        initFlutterEngine()
        //初始化flutter 页面
        initFlutterFragment()
    }

    /**
     * 初始化 Flutter Engine引擎
     * Flutter Engine: 这是一个纯 C++实现的 SDK，其中囊括了 Skia引擎、Dart运行时、文字排版引擎等。
     */
    private fun initFlutterEngine() {
        mFlutterEngine = FlutterEngineCache.getInstance().get(engineId)
        if (null == mFlutterEngine) {
            mFlutterEngine = FlutterEngine(this)
            mFlutterEngine!!.navigationChannel.setInitialRoute("/")
            mFlutterEngine!!.dartExecutor.executeDartEntrypoint(
                DartExecutor.DartEntrypoint.createDefault()
            )
            FlutterEngineCache
                .getInstance()
                .put(engineId, mFlutterEngine)
        }
        initMethodChannel()
    }

    /**
     * 与flutter页面关联
     */
    private fun initFlutterFragment() {
        flutterFragment =
            FlutterFragment.withCachedEngine(engineId)
                .shouldAttachEngineToActivity(true)
                .build() as FlutterFragment

        supportFragmentManager
            .beginTransaction()
            .add(
                R.id.fragment_container,
                flutterFragment as Fragment,
                "flutter_fragment"
            ).commit()
    }


    /**
     *  初始化channel 通道
     *  可以有多个 通道
     */
    private fun initMethodChannel(){
        mMethodChannel = MethodChannel(mFlutterEngine!!.dartExecutor.binaryMessenger, channelName)
        //设置监听Flutter回调原生方法
        mMethodChannel?.setMethodCallHandler { call, result ->
            Log.d(TAG,"call.method = " + call.method + " _argment ; " + call.arguments)
            when (call.method) {
                //原生传递数据给flutter
                "sendDeviceId"->{
                    result.success("1234567890")
                }
                //获取flutter传过来的数据
                "getToken"->{
                    val token = call.argument<String>("token")
                    Log.d(TAG, "token = $token")
                }

                //获取flutter传过来的数据  callHandler的使用, flutter等待回调使用
                "update"->{
//                    val update = call.argument<String>("update")
                    val map = HashMap<String,String>()
                    map.put("words", "words")
                    map.put("imgPath","111111")
                    mMethodChannel?.invokeMethod("updateImage",map)
                }
            }
        }
   }


    override fun onDestroy() {
        super.onDestroy()
        releaseFlutterEngine()
    }


    /**
     * 释放flutter引擎
     */
    private fun releaseFlutterEngine() {
        mFlutterEngine?.let { engine ->
            FlutterEngineCache.getInstance().remove(engineId)
            engine.destroy()
        }
        mFlutterEngine = null
    }

}